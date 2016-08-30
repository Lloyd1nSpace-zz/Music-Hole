//
//  SearchTableViewController.swift
//  Music-Hole
//
//  Created by Lloyd W. Sykes on 8/14/16.
//  Copyright © 2016 Lloyd W. Sykes. All rights reserved.
//

import UIKit
import ChameleonFramework

class SearchTableViewController: UITableViewController {

    let artistsDataStore = ArtistDataStore.sharedArtistData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.accessibilityLabel = "tableView"
        self.tableView.accessibilityIdentifier = "tableView"
        self.artistsDataStore.searchArtistsWithCompletion(self.artistsDataStore.userSearchText) { 
            self.tableView.reloadData()
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.artistsDataStore.artistSearchResults.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("searchResults", forIndexPath: indexPath)
        cell.textLabel?.text = self.artistsDataStore.artistSearchResults[indexPath.row]
        
        return cell
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
}