//
//  ArtistInfoViewController.swift
//  Music-Hole
//
//  Created by Lloyd W. Sykes on 7/30/16.
//  Copyright © 2016 Lloyd W. Sykes. All rights reserved.
//

import UIKit
import SnapKit
import ChameleonFramework

class ArtistInfoViewController: UIViewController, UIScrollViewDelegate {
    
    let artistDataStore = ArtistDataStore.sharedArtistData
    var artistScrollView = UIScrollView()
    var artistBioTextView = UITextView()
    var artistBioTextViewHeightConstraint = NSLayoutConstraint()
    var artistImage = UIImageView()
    var bioLabel = UILabel()
    var expandButton = UIButton()
    var discographyLabel = UILabel()
    var artistDiscographyStackView = UIStackView()
    var similarArtistsLabel = UILabel()
    var similarArtistsStackView = UIStackView()
    //var testImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.createViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createViews() {
        
        self.artistScrollView.delegate = self
        
        self.view.addSubview(self.artistScrollView)
        self.artistScrollView.addSubview(self.artistImage)
        self.artistScrollView.addSubview(self.bioLabel)
        self.artistScrollView.addSubview(self.artistBioTextView)
        self.artistScrollView.addSubview(self.expandButton)
        self.artistScrollView.addSubview(self.discographyLabel)
        self.artistScrollView.addSubview(self.artistDiscographyStackView)
        self.artistScrollView.addSubview(self.similarArtistsLabel)
        self.artistScrollView.addSubview(self.similarArtistsStackView)
        
        self.artistScrollView.scrollEnabled = true
        
        self.artistImage.layer.masksToBounds = true
        self.artistImage.layer.cornerRadius = 8
        self.artistImage.backgroundColor = UIColor.grayColor()
        self.artistImage.image = self.artistDataStore.artistImage
        //   self.testImage.image = UIImage(named: "drake")
        
        self.bioLabel.text = "Bio"
        
        let gradientColorScheme = UIColor.init(gradientStyle: .TopToBottom, withFrame: self.view.frame, andColors: Constants.orangeToYellowColorArray)
        self.artistBioTextView.selectable = false
        self.artistBioTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        self.artistBioTextView.backgroundColor = gradientColorScheme
        self.artistBioTextView.text = self.artistDataStore.artistBio
        self.artistBioTextView.textColor = Constants.primaryTextColor
        self.artistBioTextView.scrollEnabled = false
        self.view.backgroundColor = Constants.mainColor
        self.setStatusBarStyle(UIStatusBarStyleContrast)
        if let navController = self.navigationController {
            navController.hidesNavigationBarHairline = true
            if let style = UIContentStyle(rawValue: 500) {
                navController.setThemeUsingPrimaryColor(Constants.mainColor, withSecondaryColor: UIColor.flatYellowColor(), usingFontName: "Artist Info", andContentStyle: style)
            }
        }
        
        self.expandButton.setTitle("Expand", forState: UIControlState.Normal)
        self.expandButton.addTarget(self, action: #selector(self.expandButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
        self.expandButton.backgroundColor = UIColor.flatForestGreenColor()
        
        self.discographyLabel.text = "Discography"
        
        self.artistDiscographyStackView.axis = UILayoutConstraintAxis.Horizontal
        self.artistDiscographyStackView.backgroundColor = UIColor.flatForestGreenColor()
        
        self.similarArtistsLabel.text = "Similar Artists"
        
        self.viewConstraints()
        
    }
    
    func viewConstraints() {
        
        self.artistScrollView.snp_makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(self.view)
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view)
        }
        
        self.artistImage.snp_makeConstraints { (make) in
            make.width.equalTo(self.artistScrollView).dividedBy(1.5)
            make.height.equalTo(self.artistScrollView).dividedBy(2.5)
            make.centerX.equalTo(self.artistScrollView)
            make.top.equalTo(self.artistScrollView)
            
        }
        
        self.bioLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.artistImage.snp_bottom)
            make.bottom.equalTo(self.artistBioTextView.snp_top)
            make.width.equalTo(self.artistScrollView).dividedBy(4)
            make.height.equalTo(self.artistScrollView).dividedBy(18)
        }
        
        self.artistBioTextView.translatesAutoresizingMaskIntoConstraints = false
        self.artistBioTextView.widthAnchor.constraintEqualToAnchor(self.artistScrollView.widthAnchor).active = true
        self.artistBioTextView.centerXAnchor.constraintEqualToAnchor(self.artistScrollView.centerXAnchor).active = true
        self.artistBioTextView.topAnchor.constraintEqualToAnchor(self.bioLabel.bottomAnchor).active = true
        self.artistBioTextViewHeightConstraint = self.artistBioTextView.heightAnchor.constraintEqualToAnchor(self.artistScrollView.heightAnchor, multiplier: 1/4)
        self.artistBioTextViewHeightConstraint.active = true
        
        self.expandButton.snp_makeConstraints { (make) in
            make.top.equalTo(self.artistBioTextView.snp_bottom).offset(10)
            make.centerX.equalTo(self.artistScrollView).offset(150)
        }
        
        self.discographyLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.expandButton)
            make.width.equalTo(self.artistScrollView).dividedBy(2)
            make.height.equalTo(self.artistScrollView).dividedBy(18)
        }
        
        self.artistDiscographyStackView.snp_makeConstraints { (make) in
            make.top.equalTo(self.discographyLabel.snp_bottom)
            // make.bottom.equalTo(self.artistScrollView)
            make.width.equalTo(self.artistScrollView)
            make.height.equalTo(self.view).dividedBy(4)
            // make.centerX.equalTo(self.artistScrollView)
            //make.centerY.equalTo(self.artistScrollView)
        }
        
        self.similarArtistsLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.artistDiscographyStackView.snp_bottom)
            make.width.equalTo(self.artistScrollView).dividedBy(2)
            make.height.equalTo(self.artistScrollView).dividedBy(18)
        }
        
        self.similarArtistsStackView.snp_makeConstraints { (make) in
            make.top.equalTo(self.similarArtistsLabel.snp_bottom)
            make.width.equalTo(self.artistScrollView)
            make.height.equalTo(self.view).dividedBy(4)
        }
    
        let viewsHeights = self.artistImage.frame.height + self.bioLabel.frame.height + self.artistBioTextView.frame.height + self.discographyLabel.frame.height + self.artistDiscographyStackView.frame.height + self.similarArtistsLabel.frame.height + self.similarArtistsStackView.frame.height
        
        let viewsWidths = self.artistImage.frame.width + self.bioLabel.frame.width + self.artistBioTextView.frame.width + self.discographyLabel.frame.width + self.artistDiscographyStackView.frame.width + self.similarArtistsLabel.frame.width + self.similarArtistsStackView.frame.width
        
        self.artistScrollView.contentSize = CGSize(width: viewsWidths, height: viewsHeights)
        
    }
    
    func expandButtonTapped(sender: UIButton) {
        
        print("Expand button tapped!")
        
        // if self.artistBioTextViewHeightConstraint === self.artistBioTextView.heightAnchor.constraintEqualToAnchor(self.artistScrollView.heightAnchor, multiplier: 1/4) {
        
        self.artistBioTextViewHeightConstraint.active = false
        self.artistBioTextView.scrollEnabled = true
        
        UIView.animateWithDuration(0.3) {
            
            self.artistBioTextViewHeightConstraint = self.artistBioTextView.heightAnchor.constraintEqualToAnchor(self.artistScrollView.heightAnchor, multiplier: 1/2)
            self.artistBioTextViewHeightConstraint.active = true
            self.view.layoutIfNeeded()
            //    }
            
        }
        //else {
        //
        //            self.artistBioTextViewHeightConstraint.active = false
        //            self.artistBioTextView.scrollEnabled = false
        //
        //            UIView.animateWithDuration(0.3) {
        //
        //                self.artistBioTextViewHeightConstraint = self.artistBioTextView.heightAnchor.constraintEqualToAnchor(self.artistScrollView.heightAnchor, multiplier: 1/4)
        //                self.artistBioTextViewHeightConstraint.active = true
        //                self.view.layoutIfNeeded()
        //            }
        //  }
        
    }
}