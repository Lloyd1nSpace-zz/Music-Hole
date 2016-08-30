//
//  ArtistNameTableViewController.swift
//  Music-Hole
//
//  Created by Lloyd W. Sykes on 7/30/16.
//  Copyright © 2016 Lloyd W. Sykes. All rights reserved.
//

import UIKit
import ChameleonFramework
import SnapKit

class ArtistNameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let artistDataStore = ArtistDataStore.sharedArtistData
    var orangeToYellowGradientColor: [UIColor!]!
    var artistTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewCustomizations()
        self.artistDataStore.getArtistNamesWithCompletion {
            self.artistTableView.reloadData()
        }
        
        self.searchButtonSetup()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.artistDataStore.topArtists.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        self.orangeToYellowGradientColor = [UIColor.flatOrangeColorDark(), UIColor.flatOrangeColor(), UIColor.flatYellowColor(), UIColor.flatYellowColorDark(), UIColor.flatOrangeColor(), UIColor.flatOrangeColorDark()]
        
        let cell = self.artistTableView.dequeueReusableCellWithIdentifier("artistName", forIndexPath: indexPath)
        cell.textLabel?.text = self.artistDataStore.topArtists[indexPath.row]
        let cellColor = UIColor.init(gradientStyle: .LeftToRight, withFrame: cell.frame, andColors: self.orangeToYellowGradientColor)
        cell.backgroundColor = cellColor
        let outlineColor = UIColor.flatBlackColor()
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = outlineColor.CGColor
        cell.textLabel?.textColor = Constants.primaryTextColor
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let destination = ArtistInfoViewController()
        let selectedArtist = self.artistDataStore.topArtists[indexPath.row]
        let selectedArtistForURL = selectedArtist.stringByReplacingOccurrencesOfString(" ", withString: "+")
        
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
                let imageURL = NSURL(string: imageURLasString),
                let imageData = NSData(contentsOfURL: imageURL) else {
                    print("Couldn't pull the CONTENT from the Artist Info ArtistNameTableViewController")
                    return
            }
            
            self.artistDataStore.artistBio = bio
            self.artistDataStore.artistImage = UIImage(data: imageData)
            
            self.navigationController?.showViewController(destination, sender: "")
        })
        
        self.artistTableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    func searchButtonSetup() {
        
        let searchButton = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: #selector(self.searchTapped))
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = searchButton
    }
    
    @IBAction func searchTapped(sender: AnyObject) {
        
        print("Search Tapped!")
        
        let searchVC = SearchViewController()
        
        self.navigationController?.showViewController(searchVC, sender: "")
        
//        self.presentViewController(searchVC, animated: false) {
//            
//            searchVC.navigationController?.navigationBar.backItem?.title = "Back"
//            //  self.navigationController?.navigationBar.backItem?.title = "Back"
//        }
        
    }
    
    
    //    @IBAction func searchTapped(sender: AnyObject) {
    //
    //        let searchController = UIAlertController(title: "Search", message: "", preferredStyle: .Alert)
    //        searchController.addTextFieldWithConfigurationHandler { (artistName) in
    //            artistName.placeholder = "Enter Artist Name Here"
    //            artistName.textAlignment = NSTextAlignment.Center
    //            self.artistDataStore.userSearchText = artistName.text!
    //        }
    //        let searchAction = UIAlertAction(title: "Search", style: .Default) { (userSearch) in
    //
    //          //  self.artistDataStore.searchArtistsWithCompletion(self.artistDataStore.userSearchText, completion: {
    //                 self.presentViewController(SearchTableViewController(), animated: true, completion: nil)
    //           // })
    //
    //        }
    //
    //        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
    //        searchController.addAction(searchAction)
    //        searchController.addAction(cancelAction)
    //
    //        self.presentViewController(searchController, animated: true, completion: nil)
    //    }
    
    func viewCustomizations() {
        
        self.view.backgroundColor = UIColor.flatYellowColorDark()
        self.navigationController?.navigationBar.backgroundColor = UIColor.flatYellowColorDark()
        self.navigationController?.navigationBar.topItem?.title = "Top Artists"
        
        self.artistTableView.delegate = self
        self.artistTableView.dataSource = self
        self.artistTableView.accessibilityLabel = "tableView"
        self.artistTableView.accessibilityIdentifier = "tableView"
        self.artistTableView.backgroundColor = UIColor.flatYellowColorDark()
        self.artistTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "artistName")
        
        self.view.addSubview(self.artistTableView)
        self.artistTableView.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view)
            make.width.equalTo(self.view)
            make.height.equalTo(self.view)
        }
        
        if let navController = self.navigationController {
            
            navController.hidesNavigationBarHairline = true
            self.setStatusBarStyle(UIStatusBarStyleContrast)
            if let style = UIContentStyle(rawValue: 500) {
                navController.setThemeUsingPrimaryColor(UIColor.flatYellowColorDark(), withSecondaryColor: UIColor.flatYellowColor(), usingFontName: "Artist Info", andContentStyle: style)
            }
        }
    }
}