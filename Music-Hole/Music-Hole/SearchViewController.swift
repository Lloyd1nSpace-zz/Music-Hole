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

class SearchViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        self.searchBarSetup()
    }
    
    func searchBarSetup() {
        
        self.view.backgroundColor = Constants.mainColor
        
        let searchBar = UISearchBar()
        self.view.addSubview(searchBar)
        searchBar.snp_makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.centerY.equalTo(self.view.snp_top).offset(80)
            make.centerX.equalTo(self.view)
        }

        searchBar.barTintColor = Constants.mainColor
        searchBar.translucent = true
        
        searchBar.placeholder = "Enter Artist Name Here"
        
    }
}