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
    var artistBioTextView = UITextView()
    var artistDiscography = UIStackView()
    var artistImage = UIImageView()
    var testImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.createViews()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.bioConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bioConstraints() {
        
        self.createViews()
        self.artistBioTextView.snp_makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(self.view).dividedBy(1.1)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
        
        self.artistImage.snp_makeConstraints { (make) in
            make.width.equalTo(self.artistBioTextView).dividedBy(1.5)
            make.height.equalTo(self.artistBioTextView).dividedBy(2.5)
            make.centerX.equalTo(self.artistBioTextView)
            make.top.equalTo(self.artistBioTextView)
        }
    }
    
    func createViews() {
        
        let gradientColorScheme = UIColor.init(gradientStyle: .TopToBottom, withFrame: self.view.frame, andColors: Constants.orangeToYellowColorArray)
        self.artistBioTextView.selectable = false
        self.artistBioTextView.textContainerInset = UIEdgeInsets(top: 250, left: 10, bottom: 0, right: 10)
        self.artistBioTextView.backgroundColor = gradientColorScheme
        self.artistBioTextView.text = self.artistDataStore.artistBio
        self.artistBioTextView.textColor = Constants.primaryTextColor
        self.view.addSubview(self.artistBioTextView)
        
        self.artistImage.layer.masksToBounds = true
        self.artistImage.layer.cornerRadius = 8
        self.artistImage.backgroundColor = UIColor.grayColor()
        self.artistBioTextView.addSubview(self.artistImage)
        self.artistImage.image = self.artistDataStore.artistImage
        self.testImage.image = UIImage(named: "drake")
        self.view.backgroundColor = Constants.mainColor
        self.setStatusBarStyle(UIStatusBarStyleContrast)
        if let navController = self.navigationController {
            navController.hidesNavigationBarHairline = true
            if let style = UIContentStyle(rawValue: 500) {
                navController.setThemeUsingPrimaryColor(Constants.mainColor, withSecondaryColor: UIColor.flatYellowColor(), usingFontName: "Artist Info", andContentStyle: style)
            }
        }
        
//        self.artistDiscography.distribution = UIStackViewDistribution.EqualSpacing
//        self.artistDiscography.axis = UILayoutConstraintAxis.Horizontal
//        self.artistDiscography.alignment = UIStackViewAlignment.Center
//        self.artistDiscography.spacing = 2.0
//        self.artistDiscography.addArrangedSubview(self.testImage)
//        self.artistDiscography.backgroundColor = UIColor.flatLimeColor()
//        self.view.addSubview(self.artistDiscography)
//        self.view.snp_makeConstraints { (make) in
//           make.top.equalTo(self.artistBioTextView.snp_bottom)
//            make.bottom.equalTo(self.view)
//            make.height.equalTo(self.view).dividedBy(4)
//            make.width.equalTo(self.view)
//        }
    }

    
    
}