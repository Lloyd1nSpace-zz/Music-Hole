//
//  SearchResultsViewController.swift
//  Music-Hole
//
//  Created by Lloyd W. Sykes on 8/30/16.
//  Copyright © 2016 Lloyd W. Sykes. All rights reserved.
//

import UIKit
//import ChameleonFramework

class SearchResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let artistsDataStore = ArtistDataStore.sharedArtistData
    var searchResultsTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.settingUpTableView()
        
        self.artistsDataStore.searchArtistsWithCompletion(self.artistsDataStore.userSearchText) {
            self.searchResultsTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.artistsDataStore.artistSearchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.searchResultsTableView.dequeueReusableCell(withIdentifier: "searchResults", for: indexPath)
        cell.textLabel?.text = self.artistsDataStore.artistSearchResults[(indexPath as NSIndexPath).row]
   //     let cellColor = UIColor.init(gradientStyle: .leftToRight, withFrame: cell.frame, andColors: Constants.orangeToYellowColorArray)
     //   cell.backgroundColor = cellColor
        let outlineColor = UIColor.black
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = outlineColor.cgColor
        cell.textLabel?.textColor = Constants.primaryTextColor
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func settingUpTableView() {
        
        self.searchResultsTableView.accessibilityLabel = "tableView"
        self.searchResultsTableView.accessibilityIdentifier = "tableView"
        
        self.view.addSubview(self.searchResultsTableView)
        self.searchResultsTableView.translatesAutoresizingMaskIntoConstraints = false
        self.searchResultsTableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.searchResultsTableView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.searchResultsTableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.searchResultsTableView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        
    }
    
}
