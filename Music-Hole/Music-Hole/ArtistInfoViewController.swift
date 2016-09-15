//
//  ArtistInfoViewController.swift
//  Music-Hole
//
//  Created by Lloyd W. Sykes on 7/30/16.
//  Copyright © 2016 Lloyd W. Sykes. All rights reserved.
//

import UIKit
//import SnapKit
//import ChameleonFramework

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
    var artistDiscographyLabel = UILabel()
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
        //        self.edgesForExtendedLayout = UIRectEdge.None
        self.artistScrollView.delegate = self
        self.artistScrollView.autoresizingMask = UIViewAutoresizing.flexibleHeight
        self.artistScrollView.isUserInteractionEnabled = true
        self.artistScrollView.isScrollEnabled = true
        self.artistScrollView.backgroundColor = UIColor.blue
        self.artistScrollView.alwaysBounceVertical = true
        
        self.artistImage.layer.masksToBounds = true
        self.artistImage.layer.cornerRadius = 8
        self.artistImage.backgroundColor = UIColor.gray
        self.artistImage.image = self.artistDataStore.artistImage
        //   self.testImage.image = UIImage(named: "drake")
        
        self.bioLabel.text = "Bio"
        
        //   let gradientColorScheme = UIColor.init(gradientStyle: .topToBottom, withFrame: self.view.frame, andColors: Constants.orangeToYellowColorArray)
        self.artistBioTextView.isSelectable = false
        self.artistBioTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        // self.artistBioTextView.backgroundColor = gradientColorScheme
        self.artistBioTextView.text = self.artistDataStore.artistBio
        self.artistBioTextView.textColor = Constants.primaryTextColor
        self.artistBioTextView.isScrollEnabled = false
        self.view.backgroundColor = Constants.mainColor
        //      self.setStatusBarStyle(UIStatusBarStyleContrast)
        //    if let navController = self.navigationController {
        //      navController.hidesNavigationBarHairline = true
        //    if let style = UIContentStyle(rawValue: 500) {
        //      navController.setThemeUsingPrimaryColor(Constants.mainColor, withSecondaryColor: UIColor.flatYellow(), usingFontName: "Artist Info", andContentStyle: style)
        // }
        // }
        
        self.expandButton.setTitle("Expand", for: UIControlState())
        self.expandButton.addTarget(self, action: #selector(self.expandButtonTapped), for: UIControlEvents.touchUpInside)
        // self.expandButton.backgroundColor = UIColor.flatRedColorDark()
        self.expandButton.backgroundColor = UIColor.red
        self.expandButton.layer.cornerRadius = 7
        
        self.discographyLabel.text = "Discography"
        
        self.artistDiscographyStackView.axis = UILayoutConstraintAxis.horizontal
        //  self.artistDiscographyStackView.backgroundColor = UIColor.flatForestGreen()
        self.artistDiscographyStackView.backgroundColor = UIColor.green
        
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
        self.artistDiscographyStackView.addArrangedSubview(self.artistDiscographyImage)
        self.artistDiscographyStackView.addArrangedSubview(self.artistDiscographyLabel)
        self.similarArtistsStackView.addArrangedSubview(self.similarArtistImage)
        self.similarArtistsStackView.addArrangedSubview(self.similarArtistName)
        
        self.viewConstraints()
        
    }
    
    func viewConstraints() {
        
        //  let viewsHeights = self.artistImage.frame.height + self.bioLabel.frame.height + self.artistBioTextView.frame.height + self.discographyLabel.frame.height + self.artistDiscographyStackView.frame.height + self.similarArtistsLabel.frame.height + self.similarArtistsStackView.frame.height
        
        
        // CGRect.infinite
        self.artistScrollView.translatesAutoresizingMaskIntoConstraints = false
        self.artistScrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.artistScrollView.bottomAnchor.constraint(equalTo: self.similarArtistsStackView.bottomAnchor, constant: 30).isActive = true
        self.artistScrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.artistScrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.artistScrollView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        self.artistImage.translatesAutoresizingMaskIntoConstraints = false
        self.artistImage.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/1.5).isActive = true
        self.artistImage.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/2.5).isActive = true
        self.artistImage.centerXAnchor.constraint(equalTo: self.artistScrollView.centerXAnchor).isActive = true
        self.artistImage.topAnchor.constraint(equalTo: self.artistScrollView.topAnchor).isActive = true
        
        self.bioLabel.translatesAutoresizingMaskIntoConstraints = false
        self.bioLabel.topAnchor.constraint(equalTo: self.artistImage.bottomAnchor).isActive = true
        self.bioLabel.bottomAnchor.constraint(equalTo: self.artistBioTextView.topAnchor).isActive = true
        self.bioLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/4).isActive = true
        self.bioLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/18).isActive = true
        
        self.artistBioTextView.translatesAutoresizingMaskIntoConstraints = false
        self.artistBioTextView.widthAnchor.constraint(equalTo: self.artistScrollView.widthAnchor).isActive = true
        self.artistBioTextView.centerXAnchor.constraint(equalTo: self.artistScrollView.centerXAnchor).isActive = true
        self.artistBioTextView.topAnchor.constraint(equalTo: self.bioLabel.bottomAnchor).isActive = true
        self.artistBioTextViewHeightConstraint = self.artistBioTextView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/4)
        self.artistBioTextViewHeightConstraint.isActive = true
        
        self.expandButton.translatesAutoresizingMaskIntoConstraints = false
        self.expandButton.topAnchor.constraint(equalTo: self.artistBioTextView.bottomAnchor, constant: 10).isActive = true
        self.expandButton.centerXAnchor.constraint(equalTo: self.artistScrollView.centerXAnchor, constant: 150).isActive = true
        
        self.discographyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.discographyLabel.topAnchor.constraint(equalTo: self.expandButton.bottomAnchor).isActive = true
        self.discographyLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/2).isActive = true
        self.discographyLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/18).isActive = true
        
        self.artistDiscographyStackView.translatesAutoresizingMaskIntoConstraints = false
        self.artistDiscographyStackView.topAnchor.constraint(equalTo: self.discographyLabel.bottomAnchor).isActive = true
        self.artistDiscographyStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.artistDiscographyStackView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/4).isActive = true
        
        self.similarArtistsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.similarArtistsLabel.topAnchor.constraint(equalTo: self.artistDiscographyStackView.bottomAnchor).isActive = true
        self.similarArtistsLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/2).isActive = true
        self.similarArtistsLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/18).isActive = true
        
        self.similarArtistsStackView.translatesAutoresizingMaskIntoConstraints = false
        self.similarArtistsStackView.topAnchor.constraint(equalTo: self.similarArtistsLabel.bottomAnchor)
        self.similarArtistsStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        self.similarArtistsStackView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/4)
        
        self.artistDiscographyStackView.alignment = UIStackViewAlignment.center
        self.artistDiscographyStackView.distribution = UIStackViewDistribution.equalSpacing
        self.similarArtistsStackView.alignment = UIStackViewAlignment.center
        self.similarArtistsStackView.distribution = UIStackViewDistribution.equalSpacing
        
        //  self.artistScrollView.contentSize = CGSize(width: self.view.frame.width, height: viewsHeights)
        // self.artistScrollView.contentSize = CGSize(width: viewsWidths, height: viewsHeights)
    }
    
    @IBAction func expandButtonTapped(_ sender: UIButton) {
        
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
        
        self.artistBioTextView.isScrollEnabled = true
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.artistBioTextViewHeightConstraint.constant += 125
            self.view.layoutIfNeeded()
            
        })
    }
    
    func makeBioSmaller() {
        
        self.artistBioTextView.isScrollEnabled = false
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.artistBioTextViewHeightConstraint.constant -= 125
            self.view.layoutIfNeeded()
            
        })
    }
}
