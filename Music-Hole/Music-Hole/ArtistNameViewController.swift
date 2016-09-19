//
//  ArtistNameTableViewController.swift
//  Music-Hole
//
//  Created by Lloyd W. Sykes on 7/30/16.
//  Copyright © 2016 Lloyd W. Sykes. All rights reserved.
//

import UIKit
//import ChameleonFramework

class ArtistNameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let artistDataStore = ArtistDataStore.sharedArtistData
    var artistTableView = UITableView()
    let searchBar = SearchViewController().searchBar
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewCustomizations()
        
        self.artistDataStore.getArtistNamesWithCompletion {
            self.artistTableView.reloadData()
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
        let formattedArtistName = self.formatArtistName(selectedArtistName: selectedArtist)
    
        let selectedArtistForURL = formattedArtistName.replacingOccurrences(of: " ", with: "+")
        
        self.artistDataStore.similarArtistsNames.removeAll()
        self.artistDataStore.similarArtistImages.removeAll()
        
        LastFMApiClient.getArtistBioWithCompletion(selectedArtistForURL, completion: { (artistInfo) in
            guard
                let info = artistInfo["artist"] as? NSDictionary,
                let bioInfo = info["bio"] as? NSDictionary,
                let bio = bioInfo["content"] as? String,
                let imageInfo = info["image"] as? [NSDictionary] else {
                    fatalError("Couldn't pull the CONTENT from the Artist Info ArtistNameViewController")
                   // return
            }
            
            let imageSize = imageInfo[3]
            guard
                let imageURLasString = imageSize["#text"] as? String,
                let imageURL = URL(string: imageURLasString),
                let imageData = try? Data(contentsOf: imageURL) else {
                    fatalError("Couldn't pull the CONTENT from the Artist Info ArtistNameViewController")
                  //  return
            }
            
            self.artistDataStore.artistBio = bio
            self.artistDataStore.artistImage = UIImage(data: imageData)
            
            guard
                let artistDict = artistInfo["artist"] as? NSDictionary,
                let similarArtistsDict = artistDict["similar"] as? NSDictionary,
                let similarArtists = similarArtistsDict["artist"] as? [NSDictionary] else {
                    fatalError("There was an error unwrapping the similar artists information in the ArtistNameViewController.")
            }
            
            for artists in similarArtists {
                
                if let artistNames = artists["name"] as? String {
                    
                    self.artistDataStore.similarArtistsNames.append(artistNames)
                    print("These are the similar artist names: \(self.artistDataStore.similarArtistsNames)")
                } else {
                    print("There was an error unwrapping the similar artists Name in the data store.")
                }
                
                if let artistImageDict = artists["image"] as? [NSDictionary] {
                    
                    for images in artistImageDict {
                        
                        if images["size"] as? String == "large" {
                            
                            guard let imageAsString = images["#text"] as? String else {
                                fatalError("There was a problem unwrapping similar artists images in the data store.")
                            }
                            
                            self.artistDataStore.similarArtistImages.append(imageAsString)
                            print("These are the similar artist URL Strings: \(self.artistDataStore.similarArtistImages)")
                        }
                    }
                }
            }
            
            self.navigationController?.show(destination, sender: "")
        })
        
        self.artistTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func formatArtistName(selectedArtistName: String) -> String {
        var formattedArtistName = ""
        
        if selectedArtistName.contains("+") {
            formattedArtistName = selectedArtistName.replacingOccurrences(of: "+", with: "%2B")
        } else if selectedArtistName.contains("é") {
            formattedArtistName = selectedArtistName.replacingOccurrences(of: "é", with: "%C3%A9")
        } else {
            formattedArtistName = selectedArtistName
        }
        
        return formattedArtistName
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
