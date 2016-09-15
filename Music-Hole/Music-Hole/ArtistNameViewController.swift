//
//  ArtistNameTableViewController.swift
//  Music-Hole
//
//  Created by Lloyd W. Sykes on 7/30/16.
//  Copyright © 2016 Lloyd W. Sykes. All rights reserved.
//

import UIKit
//import ChameleonFramework
//import SnapKit

class ArtistNameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let artistDataStore = ArtistDataStore.sharedArtistData
    var artistTableView = UITableView()
    let searchBar = SearchViewController().searchBar
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewCustomizations()
        
        if let searchBarEmpty = self.searchBar.text?.isEmpty {
            
            self.artistDataStore.getArtistNamesWithCompletion {
                
                self.artistTableView.reloadData()
                print("The searchBarText is empty: \(searchBarEmpty)")
            }
            
        } else {
            
            self.artistDataStore.searchArtistsWithCompletion(self.searchBar.text!, completion: {
                
                self.artistTableView.reloadData()
                
            })
        }
        
     self.artistDataStore.getSimilarArtistsWithCompletion("Drake") { 
        print("These are the similar artists names in relation to Drake: \(self.artistDataStore.similarArtistsNames)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.artistDataStore.topArtists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.artistTableView.dequeueReusableCell(withIdentifier: "artistName", for: indexPath)
        cell.textLabel?.text = self.artistDataStore.topArtists[(indexPath as NSIndexPath).row]
        //  let cellColor = UIColor.init(gradientStyle: .leftToRight, withFrame: cell.frame, andColors: Constants.orangeToYellowColorArray)
        cell.backgroundColor = UIColor.yellow
        //   let outlineColor = UIColor.flatBlack()
        let outlineColor = UIColor.black
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = outlineColor.cgColor
        cell.textLabel?.textColor = Constants.primaryTextColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let destination = ArtistInfoViewController()
        let selectedArtist = self.artistDataStore.topArtists[(indexPath as NSIndexPath).row]
        let selectedArtistForURL = selectedArtist.replacingOccurrences(of: " ", with: "+")
        
        LastFMApiClient.getArtistBioWithCompletion(selectedArtistForURL, completion: { (artistInfo) in
            guard
                let info = artistInfo["artist"] as? NSDictionary,
                let bioInfo = info["bio"] as? NSDictionary,
                let bio = bioInfo["content"] as? String,
                let imageInfo = info["image"] as? [NSDictionary] else {
                    print("Couldn't pull the CONTENT from the Artist Info ArtistNameTableViewController")
                    return
            }
            
            let imageSize = imageInfo[3]
            guard
                let imageURLasString = imageSize["#text"] as? String,
                let imageURL = URL(string: imageURLasString),
                let imageData = try? Data(contentsOf: imageURL) else {
                    print("Couldn't pull the CONTENT from the Artist Info ArtistNameTableViewController")
                    return
            }
            
            self.artistDataStore.artistBio = bio
            self.artistDataStore.artistImage = UIImage(data: imageData)
            
            self.navigationController?.show(destination, sender: "")
        })
        
        self.artistTableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func searchButtonSetup() {
        
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(self.searchTapped))
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = searchButton
    }
    
    @IBAction func searchTapped(_ sender: AnyObject) {
        
        print("Search Tapped!")
        
        let searchVC = SearchViewController()
        
        self.navigationController?.show(searchVC, sender: "")
        
    }
    
    func viewCustomizations() {
        
        self.view.backgroundColor = Constants.mainColor
        self.navigationController?.navigationBar.backgroundColor = Constants.mainColor
        self.navigationController?.navigationBar.topItem?.title = "Top Artists"
        
        self.artistTableView.delegate = self
        self.artistTableView.dataSource = self
        self.artistTableView.accessibilityLabel = "tableView"
        self.artistTableView.accessibilityIdentifier = "tableView"
        self.artistTableView.backgroundColor = Constants.mainColor
        self.artistTableView.register(UITableViewCell.self, forCellReuseIdentifier: "artistName")
        
        self.view.addSubview(self.artistTableView)
        
        self.artistTableView.translatesAutoresizingMaskIntoConstraints = false
        self.artistTableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.artistTableView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.artistTableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.artistTableView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        
        self.searchButtonSetup()
        
    }  
}
