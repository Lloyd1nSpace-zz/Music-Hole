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

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        self.searchBarSetup()
    }
    
    func searchBarSetup() {
        
        self.view.backgroundColor = UIColor.init(gradientStyle: UIGradientStyle.TopToBottom, withFrame: self.view.frame, andColors: Constants.orangeToYellowColorArray)
        
        self.searchBar.delegate = self
        self.view.addSubview(searchBar)
        self.searchBar.snp_makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.centerY.equalTo(self.view.snp_top).offset(80)
            make.centerX.equalTo(self.view)
        }

        self.searchBar.barTintColor = Constants.mainColor
        self.searchBar.translucent = true
        
        self.searchBar.placeholder = "Enter Artist Name Here"
    
        if self.searchBar.text?.isEmpty == false {
            
            print("There's text in the searchBar!")
            
            self.navigationController?.showViewController(ArtistNameViewController(), sender: nil)
        }
        
        
    }
   
    
}