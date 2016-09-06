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

class ArtistInfoViewController: UIViewController {
    
    let artistDataStore = ArtistDataStore.sharedArtistData
    var artistScrollView = UIScrollView()
    var artistBioTextView = UITextView()
    var artistBioTextViewHeightConstraint = NSLayoutConstraint()
    var artistDiscography = UIStackView()
    var artistImage = UIImageView()
    var expandButton = UIButton()
    var bioLabel = UILabel()
    var discographyLabel = UILabel()
    var similarArtistsLabel = UILabel()
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
        
        self.view.addSubview(self.artistScrollView)
        self.artistScrollView.addSubview(self.artistImage)
        self.artistScrollView.addSubview(self.bioLabel)
        self.artistScrollView.addSubview(self.artistBioTextView)
        self.artistScrollView.addSubview(self.expandButton)
        self.artistScrollView.addSubview(self.discographyLabel)
        
        self.artistScrollView.scrollEnabled = true
        
        self.artistImage.layer.masksToBounds = true
        self.artistImage.layer.cornerRadius = 8
        self.artistImage.backgroundColor = UIColor.grayColor()
        self.artistImage.image = self.artistDataStore.artistImage
        //   self.testImage.image = UIImage(named: "drake")
        
        self.bioLabel.text = "Bio"
        self.discographyLabel.text = "Discography"
        
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
        
        self.expandButton.snp_makeConstraints { (make) in
            make.top.equalTo(self.artistBioTextView.snp_bottom).offset(10)
            make.centerX.equalTo(self.artistScrollView).offset(150)
        }
        
        
        self.artistBioTextView.translatesAutoresizingMaskIntoConstraints = false
        self.artistBioTextView.widthAnchor.constraintEqualToAnchor(self.artistScrollView.widthAnchor).active = true
        self.artistBioTextView.centerXAnchor.constraintEqualToAnchor(self.artistScrollView.centerXAnchor).active = true
        self.artistBioTextView.topAnchor.constraintEqualToAnchor(self.bioLabel.bottomAnchor).active = true
        
        self.artistBioTextViewHeightConstraint = self.artistBioTextView.heightAnchor.constraintEqualToAnchor(self.artistScrollView.heightAnchor, multiplier: 1/4)
        self.artistBioTextViewHeightConstraint.active = true
        
        self.discographyLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.expandButton)
            make.bottom.equalTo(self.artistScrollView)
            make.width.equalTo(self.artistScrollView).dividedBy(2)
            make.height.equalTo(self.artistScrollView).dividedBy(18)
        }
        
        
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