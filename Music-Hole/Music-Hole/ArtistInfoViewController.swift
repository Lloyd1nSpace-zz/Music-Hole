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
    var artistDiscographyImage = UIImageView()
    var similarArtistsLabel = UILabel()
    var similarArtistsStackView = UIStackView()
    var similarArtistImage = UIImageView()
    var similarArtistName = UILabel()
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
        
        
        //        self.extendedLayoutIncludesOpaqueBars = false
        //        self.artistScrollView = UIScrollView(frame: self.view.bounds)
        //  self.edgesForExtendedLayout = UIRectEdge.None
        self.artistScrollView.delegate = self
        //self.artistScrollView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        // self.artistScrollView.userInteractionEnabled = true
        //   self.artistScrollView.scrollEnabled = true
        
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
        self.expandButton.backgroundColor = UIColor.flatRedColorDark()
        self.expandButton.layer.cornerRadius = 7
        
        self.discographyLabel.text = "Discography"
        
        self.artistDiscographyStackView.axis = UILayoutConstraintAxis.Horizontal
        self.artistDiscographyStackView.backgroundColor = UIColor.flatForestGreenColor()
        
        self.similarArtistsLabel.text = "Similar Artists"
        
        for image in self.artistDataStore.similarArtistImages {
            
            self.similarArtistImage.image = UIImage(contentsOfFile: image)
            
        }
        
        for name in self.artistDataStore.similarArtistsNames {
            
            self.similarArtistName.text = name
            
        }
        
        self.view.addSubview(self.artistScrollView)
        self.artistScrollView.addSubview(self.artistImage)
        self.artistScrollView.addSubview(self.bioLabel)
        self.artistScrollView.addSubview(self.artistBioTextView)
        self.artistScrollView.addSubview(self.expandButton)
        self.artistScrollView.addSubview(self.discographyLabel)
        self.artistScrollView.addSubview(self.artistDiscographyStackView)
        self.artistScrollView.addSubview(self.similarArtistsLabel)
        self.artistScrollView.addSubview(self.similarArtistsStackView)
        self.similarArtistsStackView.addArrangedSubview(self.similarArtistImage)
        self.similarArtistsStackView.addArrangedSubview(self.similarArtistName)
        
        self.viewConstraints()
        
    }
    
    func viewConstraints() {
        
        
        self.artistScrollView.snp_makeConstraints { (make) in
            //    make.top.equalTo(self.view)
            make.width.equalTo(self.view)
            make.height.equalTo(self.view)
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view)
        }
        
        self.artistImage.snp_makeConstraints { (make) in
            make.width.equalTo(self.view).dividedBy(1.5)
            make.height.equalTo(self.view).dividedBy(2.5)
            make.centerX.equalTo(self.artistScrollView)
            make.top.equalTo(self.artistScrollView)
            
        }
        
        self.bioLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.artistImage.snp_bottom)
            make.bottom.equalTo(self.artistBioTextView.snp_top)
            make.width.equalTo(self.view).dividedBy(4)
            make.height.equalTo(self.view).dividedBy(18)
        }
        
        self.artistBioTextView.translatesAutoresizingMaskIntoConstraints = false
        self.artistBioTextView.widthAnchor.constraintEqualToAnchor(self.artistScrollView.widthAnchor).active = true
        self.artistBioTextView.centerXAnchor.constraintEqualToAnchor(self.artistScrollView.centerXAnchor).active = true
        self.artistBioTextView.topAnchor.constraintEqualToAnchor(self.bioLabel.bottomAnchor).active = true
        self.artistBioTextViewHeightConstraint = self.artistBioTextView.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 1/4)
        self.artistBioTextViewHeightConstraint.active = true
        
        //  print("This is the constant for artistBioTextViewHeightConstraint: \(self.artistBioTextViewHeightConstraint.constant)")
        
        self.expandButton.snp_makeConstraints { (make) in
            make.top.equalTo(self.artistBioTextView.snp_bottom).offset(10)
            make.centerX.equalTo(self.artistScrollView).offset(150)
        }
        
        self.discographyLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.expandButton)
            make.width.equalTo(self.view).dividedBy(2)
            make.height.equalTo(self.view).dividedBy(18)
        }
        
        self.artistDiscographyStackView.snp_makeConstraints { (make) in
            make.top.equalTo(self.discographyLabel.snp_bottom)
            make.width.equalTo(self.view)
            make.height.equalTo(self.view).dividedBy(4)
            
        }
        
        self.similarArtistsLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.artistDiscographyStackView.snp_bottom)
            make.width.equalTo(self.view).dividedBy(2)
            make.height.equalTo(self.view).dividedBy(18)
        }
        
        self.similarArtistsStackView.snp_makeConstraints { (make) in
            make.top.equalTo(self.similarArtistsLabel.snp_bottom)
            make.width.equalTo(self.view)
            make.height.equalTo(self.view).dividedBy(4)
        }
        
        self.similarArtistsStackView.alignment = UIStackViewAlignment.Center
        self.similarArtistsStackView.distribution = UIStackViewDistribution.EqualSpacing
        
        //   let viewsWidths = self.artistImage.frame.width + self.bioLabel.frame.width + self.artistBioTextView.frame.width + self.discographyLabel.frame.width + self.artistDiscographyStackView.frame.width + self.similarArtistsLabel.frame.width + self.similarArtistsStackView.frame.width
        
        //  let viewsHeights = self.artistImage.frame.height + self.bioLabel.frame.height + self.artistBioTextView.frame.height + self.discographyLabel.frame.height + self.artistDiscographyStackView.frame.height + self.similarArtistsLabel.frame.height + self.similarArtistsStackView.frame.height
        
        //self.artistScrollView.contentSize.height = viewsHeights
        
        // self.artistScrollView.contentSize = CGSize(width: viewsWidths, height: viewsHeights)
    }
    
    @IBAction func expandButtonTapped(sender: UIButton) {
        
        print("Expand button tapped!")
        
        if self.isBioBig() {
            
            self.makeBioSmaller()
            
        } else {
            
            self.expandBio()
        }
    }
    
    func isBioBig() -> Bool {
        
        switch self.artistBioTextViewHeightConstraint.constant {
            
        case 125:
            return true
        default:
            return false
        }
    }
    
    func expandBio() {
        
        self.artistBioTextView.scrollEnabled = true
        
        UIView.animateWithDuration(0.3) {
            
            self.artistBioTextViewHeightConstraint.constant += 125
            self.view.layoutIfNeeded()
            
        }
    }
    
    func makeBioSmaller() {
        
        self.artistBioTextView.scrollEnabled = false
        
        UIView.animateWithDuration(0.3) {
            
            self.artistBioTextViewHeightConstraint.constant -= 125
            self.view.layoutIfNeeded()
            
        }
    }
}