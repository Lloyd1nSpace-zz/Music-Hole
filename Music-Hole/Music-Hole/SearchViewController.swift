//
//  SearchTableViewController.swift
//  Music-Hole
//
//  Created by Lloyd W. Sykes on 8/14/16.
//  Copyright © 2016 Lloyd W. Sykes. All rights reserved.
//

import UIKit
import ChameleonFramework
import SnapKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let artistsDataStore = ArtistDataStore.sharedArtistData
    var searchTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.settingUpTableView()
        
        self.artistsDataStore.searchArtistsWithCompletion(self.artistsDataStore.userSearchText) {
            self.searchTableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.artistsDataStore.artistSearchResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.searchTableView.dequeueReusableCellWithIdentifier("searchResults", forIndexPath: indexPath)
        cell.textLabel?.text = self.artistsDataStore.artistSearchResults[indexPath.row]
        let cellColor = UIColor.init(gradientStyle: .LeftToRight, withFrame: cell.frame, andColors: Constants.orangeToYellowColorArray)
        cell.backgroundColor = cellColor
        let outlineColor = UIColor.flatBlackColor()
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = outlineColor.CGColor
        cell.textLabel?.textColor = Constants.primaryText
        
        return cell
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    func settingUpTableView() {
        
        self.searchTableView.accessibilityLabel = "tableView"
        self.searchTableView.accessibilityIdentifier = "tableView"
        
        self.view.addSubview(self.searchTableView)
        self.searchTableView.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view)
            make.width.equalTo(self.view)
            make.height.equalTo(self.view)
        }
    }
}