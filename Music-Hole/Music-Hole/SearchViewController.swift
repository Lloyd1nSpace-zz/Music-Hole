//
//  SearchTableViewController.swift
//  Music-Hole
//
//  Created by Lloyd W. Sykes on 8/14/16.
//  Copyright © 2016 Lloyd W. Sykes. All rights reserved.
//

import UIKit
//import ChameleonFramework

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBarSetup()
    }
    
    func searchBarSetup() {
        
        self.navigationController?.navigationBar.topItem?.title = "Search"
        
      //  self.view.backgroundColor = UIColor.init(gradientStyle: UIGradientStyle.topToBottom, withFrame: self.view.frame, andColors: Constants.orangeToYellowColorArray)
        self.view.backgroundColor = UIColor.yellow
        
        self.searchBar.delegate = self
        self.view.addSubview(searchBar)
        
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.searchBar.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.searchBar.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
        self.searchBar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.searchBar.barTintColor = Constants.mainColor
        self.searchBar.isTranslucent = true
        
        self.searchBar.placeholder = "Enter Artist Name Here"
        
        if self.searchBar.text?.isEmpty == false {
            
            print("There's text in the searchBar!")
            
            self.navigationController?.show(ArtistNameViewController(), sender: nil)
        }
        
    } 
}
