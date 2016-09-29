//
//  ArtistInfoViewController.swift
//  Music-Hole
//
//  Created by Lloyd W. Sykes on 7/30/16.
//  Copyright © 2016 Lloyd W. Sykes. All rights reserved.
//

import UIKit
//import ChameleonFramework

class ArtistInfoViewController: UIViewController, UIScrollViewDelegate {
    
    let artistDataStore = ArtistDataStore.sharedArtistData
    var artistScrollView = UIScrollView()
    var contentView = UIView()
    var artistBioTextView = UITextView()
    var artistBioTextViewHeightConstraint = NSLayoutConstraint()
    var artistImage = UIImageView()
    var bioLabel = UILabel()
    var expandButton = UIButton()
    var discographyLabel = UILabel()
    var artistDiscographyStackView = UIStackView()
    var discogButton1 = UIButton()
    var discogButton2 = UIButton()
    var discogButton3 = UIButton()
    var discogButton4 = UIButton()
    var discogButton5 = UIButton()
    var discographyLabelsStackView = UIStackView()
    var discogLabel1 = UILabel()
    var discogLabel2 = UILabel()
    var discogLabel3 = UILabel()
    var discogLabel4 = UILabel()
    var discogLabel5 = UILabel()
    // var artistDiscographyImage = UIImageView()
    // var artistDiscographyLabel = UILabel()
    var similarArtistsLabel = UILabel()
    var similarArtistsImagesStackView = UIStackView()
    let similarButton1 = UIButton()
    let similarButton2 = UIButton()
    let similarButton3 = UIButton()
    let similarButton4 = UIButton()
    let similarButton5 = UIButton()
    var similarArtistsLabelsStackView = UIStackView()
    let similarArtist1 = UILabel()
    let similarArtist2 = UILabel()
    let similarArtist3 = UILabel()
    let similarArtist4 = UILabel()
    let similarArtist5 = UILabel()
    
    //var similarArtistsImages = UIImageView()
    // var similarArtistsNames = [UILabel]()
    //var testImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.createViews()
        
        self.getArtistDiscographyWithCompletion(artistName: "Drake") {
            print("called discography function")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createViews() {
        
        self.contentView.frame = CGRect(x: 0.0, y: 0.0, width: self.view.bounds.width, height: self.view.bounds.height + 350)
        self.contentView.backgroundColor = UIColor.clear //this is for debugging purposes
        
        //        self.extendedLayoutIncludesOpaqueBars = false
        //        self.artistScrollView = UIScrollView(frame: self.view.bounds)
        //        self.edgesForExtendedLayout = UIRectEdge.None
        
        self.artistScrollView.delegate = self
        self.artistScrollView.backgroundColor = UIColor.blue
        self.artistScrollView.contentSize = self.contentView.bounds.size
        self.artistScrollView.delaysContentTouches = false
        
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
        self.artistBioTextView.backgroundColor = UIColor.yellow
        self.artistBioTextView.text = self.artistDataStore.artistBio
        self.artistBioTextView.textColor = Constants.primaryTextColor
        self.artistBioTextView.isScrollEnabled = false
        self.view.backgroundColor = Constants.mainColor
        
        self.expandButton.setTitle("Expand", for: .normal)
        self.expandButton.setTitleColor(UIColor.black, for: .normal)
        self.expandButton.addTarget(self, action: #selector(self.expandButtonTapped), for: .touchUpInside)
        // self.expandButton.backgroundColor = UIColor.flatRedColorDark()
        self.expandButton.backgroundColor = UIColor.red
        self.expandButton.layer.cornerRadius = 7
        
        self.discographyLabel.text = "Discography"
        self.similarArtistsLabel.text = "Similar Artists"
        
        //        self.artistDiscographyStackView.addArrangedSubview(self.artistDiscographyImage)
        //        self.artistDiscographyStackView.addArrangedSubview(self.artistDiscographyLabel)
        //  self.similarArtistsStackView.addArrangedSubview(self.similarArtistsImages)
        
        
        self.discogButton1.addTarget(self, action: #selector(self.discogButtonTapped), for: .touchUpInside)
        self.discogButton1.backgroundColor = UIColor.green
        
        self.discogButton2.addTarget(self, action: #selector(self.discogButtonTapped), for: .touchUpInside)
        self.discogButton2.backgroundColor = UIColor.green
        
        self.discogButton3.addTarget(self, action: #selector(self.discogButtonTapped), for: .touchUpInside)
        self.discogButton3.backgroundColor = UIColor.green
        
        self.discogButton4.addTarget(self, action: #selector(self.discogButtonTapped), for: .touchUpInside)
        self.discogButton4.backgroundColor = UIColor.green
        
        self.discogButton5.addTarget(self, action: #selector(self.discogButtonTapped), for: .touchUpInside)
        self.discogButton5.backgroundColor = UIColor.green
        
        self.artistDiscographyStackView.addArrangedSubview(self.discogButton1)
        self.artistDiscographyStackView.addArrangedSubview(self.discogButton2)
        self.artistDiscographyStackView.addArrangedSubview(self.discogButton3)
        self.artistDiscographyStackView.addArrangedSubview(self.discogButton4)
        self.artistDiscographyStackView.addArrangedSubview(self.discogButton5)
        self.artistDiscographyStackView.addArrangedSubview(self.discographyLabelsStackView)
        
        self.discogLabel1.text = "test"
        self.discogLabel2.text = "test"
        self.discogLabel3.text = "test"
        self.discogLabel4.text = "test"
        self.discogLabel5.text = "test"
        
        self.discographyLabelsStackView.addArrangedSubview(self.discogLabel1)
        self.discographyLabelsStackView.addArrangedSubview(self.discogLabel2)
        self.discographyLabelsStackView.addArrangedSubview(self.discogLabel3)
        self.discographyLabelsStackView.addArrangedSubview(self.discogLabel4)
        self.discographyLabelsStackView.addArrangedSubview(self.discogLabel5)
        
        let similarImage1 = UIImage(contentsOfFile: self.artistDataStore.similarArtistImages[0])
        let similarImage2 = UIImage(contentsOfFile: self.artistDataStore.similarArtistImages[1])
        let similarImage3 = UIImage(contentsOfFile: self.artistDataStore.similarArtistImages[2])
        let similarImage4 = UIImage(contentsOfFile: self.artistDataStore.similarArtistImages[3])
        let similarImage5 = UIImage(contentsOfFile: self.artistDataStore.similarArtistImages[4])
        
        self.similarButton1.setBackgroundImage(similarImage1, for: .normal)
        self.similarButton2.setBackgroundImage(similarImage2, for: .normal)
        self.similarButton3.setBackgroundImage(similarImage3, for: .normal)
        self.similarButton4.setBackgroundImage(similarImage4, for: .normal)
        self.similarButton5.setBackgroundImage(similarImage5, for: .normal)
        
        self.similarButton1.addTarget(self, action: #selector(self.similarArtistButtonTapped), for: .touchUpInside)
        self.similarButton1.backgroundColor = UIColor.green
        
        self.similarButton2.addTarget(self, action: #selector(self.similarArtistButtonTapped), for: .touchUpInside)
        self.similarButton2.backgroundColor = UIColor.green
        
        self.similarButton3.addTarget(self, action: #selector(self.similarArtistButtonTapped), for: .touchUpInside)
        self.similarButton3.backgroundColor = UIColor.green
        
        self.similarButton4.addTarget(self, action: #selector(self.similarArtistButtonTapped), for: .touchUpInside)
        self.similarButton4.backgroundColor = UIColor.green
        
        self.similarButton5.addTarget(self, action: #selector(self.similarArtistButtonTapped), for: .touchUpInside)
        self.similarButton5.backgroundColor = UIColor.green
        
        self.similarArtist1.text = self.artistDataStore.similarArtistsNames[0]
        self.similarArtist2.text = self.artistDataStore.similarArtistsNames[1]
        self.similarArtist3.text = self.artistDataStore.similarArtistsNames[2]
        self.similarArtist4.text = self.artistDataStore.similarArtistsNames[3]
        self.similarArtist5.text = self.artistDataStore.similarArtistsNames[4]
        
        self.similarArtistsImagesStackView.addArrangedSubview(similarButton1)
        self.similarArtistsImagesStackView.addArrangedSubview(similarButton2)
        self.similarArtistsImagesStackView.addArrangedSubview(similarButton3)
        self.similarArtistsImagesStackView.addArrangedSubview(similarButton4)
        self.similarArtistsImagesStackView.addArrangedSubview(similarButton5)
        self.similarArtistsImagesStackView.addArrangedSubview(self.similarArtistsLabelsStackView)
        
        self.similarArtistsLabelsStackView.addArrangedSubview(self.similarArtist1)
        self.similarArtistsLabelsStackView.addArrangedSubview(self.similarArtist2)
        self.similarArtistsLabelsStackView.addArrangedSubview(self.similarArtist3)
        self.similarArtistsLabelsStackView.addArrangedSubview(self.similarArtist4)
        self.similarArtistsLabelsStackView.addArrangedSubview(self.similarArtist5)
        self.similarArtistsLabelsStackView.addArrangedSubview(self.similarArtistsLabelsStackView)
        
        self.view.addSubview(self.artistScrollView)
        self.artistScrollView.addSubview(self.contentView)
        
        self.contentView.addSubview(self.artistImage)
        self.contentView.addSubview(self.bioLabel)
        self.contentView.addSubview(self.artistBioTextView)
        self.contentView.addSubview(self.expandButton)
        self.contentView.addSubview(self.discographyLabel)
        self.contentView.addSubview(self.artistDiscographyStackView)
        self.contentView.addSubview(self.similarArtistsLabel)
        self.contentView.addSubview(self.similarArtistsImagesStackView)
        
        self.viewConstraints()
    }
    
    func viewConstraints() {
        
        let viewsHeights = self.artistImage.frame.height + self.bioLabel.frame.height + self.artistBioTextView.frame.height + self.discographyLabel.frame.height + self.artistDiscographyStackView.frame.height + self.similarArtistsLabel.frame.height + self.similarArtistsImagesStackView.frame.height
        
        self.artistScrollView.translatesAutoresizingMaskIntoConstraints = false
        self.artistScrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.artistScrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.artistScrollView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.artistScrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0)
        self.artistScrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0)
        self.artistScrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.artistScrollView.heightAnchor.constraint(equalToConstant: viewsHeights)
        
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
        
        self.discogButton1.translatesAutoresizingMaskIntoConstraints = false
        self.discogButton1.widthAnchor.constraint(equalTo: self.artistDiscographyStackView.widthAnchor, multiplier: 1/5).isActive = true
        self.discogButton1.heightAnchor.constraint(equalTo: self.artistDiscographyStackView.heightAnchor, multiplier: 0.9).isActive = true
        self.discogButton1.leftAnchor.constraint(equalTo: self.artistDiscographyStackView.leftAnchor).isActive = true
        
        self.discogButton2.translatesAutoresizingMaskIntoConstraints = false
        self.discogButton2.widthAnchor.constraint(equalTo: self.discogButton1.widthAnchor).isActive = true
        self.discogButton2.heightAnchor.constraint(equalTo: self.discogButton1.heightAnchor).isActive = true
        self.discogButton2.leftAnchor.constraint(equalTo: self.discogButton1.rightAnchor).isActive = true
        
        self.discogButton3.translatesAutoresizingMaskIntoConstraints = false
        self.discogButton3.widthAnchor.constraint(equalTo: self.discogButton1.widthAnchor).isActive = true
        self.discogButton3.heightAnchor.constraint(equalTo: self.discogButton1.heightAnchor).isActive = true
        self.discogButton3.leftAnchor.constraint(equalTo: self.discogButton2.rightAnchor).isActive = true
        
        self.discogButton4.translatesAutoresizingMaskIntoConstraints = false
        self.discogButton4.widthAnchor.constraint(equalTo: self.discogButton1.widthAnchor).isActive = true
        self.discogButton4.heightAnchor.constraint(equalTo: self.discogButton1.heightAnchor).isActive = true
        self.discogButton4.leftAnchor.constraint(equalTo: self.discogButton3.rightAnchor).isActive = true
        
        self.discogButton5.translatesAutoresizingMaskIntoConstraints = false
        self.discogButton5.widthAnchor.constraint(equalTo: self.discogButton1.widthAnchor).isActive = true
        self.discogButton5.heightAnchor.constraint(equalTo: self.discogButton1.heightAnchor).isActive = true
        self.discogButton5.rightAnchor.constraint(equalTo: self.artistDiscographyStackView.rightAnchor).isActive = true
        
        self.discographyLabelsStackView.translatesAutoresizingMaskIntoConstraints = false
        self.discographyLabelsStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.discographyLabelsStackView.heightAnchor.constraint(equalTo: self.artistDiscographyStackView.heightAnchor, multiplier: 0.1).isActive = true
        
        self.discogLabel1.translatesAutoresizingMaskIntoConstraints = false
        self.discogLabel1.topAnchor.constraint(equalTo: self.discogButton1.bottomAnchor).isActive = true
        self.discogLabel1.widthAnchor.constraint(equalTo: self.discogButton1.widthAnchor).isActive = true
        self.discogLabel1.heightAnchor.constraint(equalTo: self.discographyLabelsStackView.heightAnchor).isActive = true
        
        self.discogLabel2.translatesAutoresizingMaskIntoConstraints = false
        self.discogLabel2.topAnchor.constraint(equalTo: self.discogButton2.bottomAnchor).isActive = true
        self.discogLabel2.widthAnchor.constraint(equalTo: self.discogButton1.widthAnchor).isActive = true
        self.discogLabel2.heightAnchor.constraint(equalTo: self.discographyLabelsStackView.heightAnchor).isActive = true
        
        self.discogLabel3.translatesAutoresizingMaskIntoConstraints = false
        self.discogLabel3.topAnchor.constraint(equalTo: self.discogButton3.bottomAnchor).isActive = true
        self.discogLabel3.widthAnchor.constraint(equalTo: self.discogButton1.widthAnchor).isActive = true
        self.discogLabel3.heightAnchor.constraint(equalTo: self.discographyLabelsStackView.heightAnchor).isActive = true
        
        self.discogLabel4.translatesAutoresizingMaskIntoConstraints = false
        self.discogLabel4.topAnchor.constraint(equalTo: self.discogButton4.bottomAnchor).isActive = true
        self.discogLabel4.widthAnchor.constraint(equalTo: self.discogButton1.widthAnchor).isActive = true
        self.discogLabel4.heightAnchor.constraint(equalTo: self.discographyLabelsStackView.heightAnchor).isActive = true
        
        self.discogLabel5.translatesAutoresizingMaskIntoConstraints = false
        self.discogLabel5.topAnchor.constraint(equalTo: self.discogButton5.bottomAnchor).isActive = true
        self.discogLabel5.widthAnchor.constraint(equalTo: self.discogButton1.widthAnchor).isActive = true
        self.discogLabel5.heightAnchor.constraint(equalTo: self.discographyLabelsStackView.heightAnchor).isActive = true
        
        self.similarArtistsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.similarArtistsLabel.topAnchor.constraint(equalTo: self.artistDiscographyStackView.bottomAnchor, constant: 20).isActive = true
        self.similarArtistsLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/2).isActive = true
        self.similarArtistsLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/18).isActive = true
        
        self.similarArtistsImagesStackView.translatesAutoresizingMaskIntoConstraints = false
        self.similarArtistsImagesStackView.topAnchor.constraint(equalTo: self.similarArtistsLabel.bottomAnchor).isActive = true
        self.similarArtistsImagesStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.similarArtistsImagesStackView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/4).isActive = true
        
        self.similarButton1.translatesAutoresizingMaskIntoConstraints = false
        self.similarButton1.widthAnchor.constraint(equalTo: self.similarArtistsImagesStackView.widthAnchor, multiplier: 1/5).isActive = true
        self.similarButton1.heightAnchor.constraint(equalTo: self.similarArtistsImagesStackView.heightAnchor, multiplier: 0.9).isActive = true
        self.similarButton1.leftAnchor.constraint(equalTo: self.similarArtistsImagesStackView.leftAnchor).isActive = true
        self.similarButton1.topAnchor.constraint(equalTo: self.similarArtistsImagesStackView.topAnchor).isActive = true
        
        self.similarButton2.translatesAutoresizingMaskIntoConstraints = false
        self.similarButton2.widthAnchor.constraint(equalTo: self.similarButton1.widthAnchor).isActive = true
        self.similarButton2.heightAnchor.constraint(equalTo: self.similarButton1.heightAnchor).isActive = true
        self.similarButton2.leftAnchor.constraint(equalTo: self.similarButton1.rightAnchor).isActive = true
        self.similarButton2.topAnchor.constraint(equalTo: self.similarArtistsImagesStackView.topAnchor).isActive = true
        
        self.similarButton3.translatesAutoresizingMaskIntoConstraints = false
        self.similarButton3.widthAnchor.constraint(equalTo: self.similarButton1.widthAnchor).isActive = true
        self.similarButton3.heightAnchor.constraint(equalTo: self.similarButton1.heightAnchor).isActive = true
        self.similarButton3.leftAnchor.constraint(equalTo: self.similarButton2.rightAnchor).isActive = true
        self.similarButton3.topAnchor.constraint(equalTo: self.similarArtistsImagesStackView.topAnchor).isActive = true
        
        self.similarButton4.translatesAutoresizingMaskIntoConstraints = false
        self.similarButton4.widthAnchor.constraint(equalTo: self.similarButton1.widthAnchor).isActive = true
        self.similarButton4.heightAnchor.constraint(equalTo: self.similarButton1.heightAnchor).isActive = true
        self.similarButton4.leftAnchor.constraint(equalTo: self.similarButton3.rightAnchor).isActive = true
        self.similarButton4.topAnchor.constraint(equalTo: self.similarArtistsImagesStackView.topAnchor).isActive = true
        
        self.similarButton5.translatesAutoresizingMaskIntoConstraints = false
        self.similarButton5.widthAnchor.constraint(equalTo: self.similarButton1.widthAnchor).isActive = true
        self.similarButton5.heightAnchor.constraint(equalTo: self.similarButton1.heightAnchor).isActive = true
        self.similarButton5.leftAnchor.constraint(equalTo: self.similarButton4.rightAnchor).isActive = true
        self.similarButton5.topAnchor.constraint(equalTo: self.similarArtistsImagesStackView.topAnchor).isActive = true
        
        self.similarArtistsLabelsStackView.translatesAutoresizingMaskIntoConstraints = false
        self.similarArtistsLabelsStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.similarArtistsLabelsStackView.heightAnchor.constraint(equalTo: self.similarArtistsImagesStackView.heightAnchor, multiplier: 0.1).isActive = true
        
        self.similarArtist1.translatesAutoresizingMaskIntoConstraints = false
        self.similarArtist1.topAnchor.constraint(equalTo: self.similarButton1.bottomAnchor).isActive = true
        self.similarArtist1.widthAnchor.constraint(equalTo: self.similarButton1.widthAnchor).isActive = true
        self.similarArtist1.heightAnchor.constraint(equalTo: self.similarArtistsImagesStackView.heightAnchor, multiplier: 0.1).isActive = true
        
        self.similarArtist2.translatesAutoresizingMaskIntoConstraints = false
        self.similarArtist2.topAnchor.constraint(equalTo: self.similarButton2.bottomAnchor).isActive = true
        self.similarArtist2.widthAnchor.constraint(equalTo: self.similarButton2.widthAnchor).isActive = true
        self.similarArtist2.heightAnchor.constraint(equalTo: self.similarArtistsImagesStackView.heightAnchor, multiplier: 0.1).isActive = true
        
        self.similarArtist3.translatesAutoresizingMaskIntoConstraints = false
        self.similarArtist3.topAnchor.constraint(equalTo: self.similarButton3.bottomAnchor).isActive = true
        self.similarArtist3.widthAnchor.constraint(equalTo: self.similarButton3.widthAnchor).isActive = true
        self.similarArtist3.heightAnchor.constraint(equalTo: self.similarArtistsImagesStackView.heightAnchor, multiplier: 0.1).isActive = true
        
        self.similarArtist4.translatesAutoresizingMaskIntoConstraints = false
        self.similarArtist4.topAnchor.constraint(equalTo: self.similarButton4.bottomAnchor).isActive = true
        self.similarArtist4.widthAnchor.constraint(equalTo: self.similarButton4.widthAnchor).isActive = true
        self.similarArtist4.heightAnchor.constraint(equalTo: self.similarArtistsImagesStackView.heightAnchor, multiplier: 0.1).isActive = true
        
        self.similarArtist5.translatesAutoresizingMaskIntoConstraints = false
        self.similarArtist5.topAnchor.constraint(equalTo: self.similarButton5.bottomAnchor).isActive = true
        self.similarArtist5.widthAnchor.constraint(equalTo: self.similarButton5.widthAnchor).isActive = true
        self.similarArtist5.heightAnchor.constraint(equalTo: self.similarArtistsImagesStackView.heightAnchor, multiplier: 0.1).isActive = true
        
        self.artistDiscographyStackView.axis = .horizontal
        self.discographyLabelsStackView.axis = .horizontal
        self.discographyLabelsStackView.distribution = .equalCentering
        //self.artistDiscographyStackView.alignment = .center
        self.artistDiscographyStackView.distribution = .equalSpacing
        self.similarArtistsImagesStackView.axis = .horizontal
        self.similarArtistsLabelsStackView.axis = .horizontal
        
        //self.similarArtistsStackView.alignment = .center
        //  self.similarArtistsStackView.distribution = .equalSpacing
    }
    
    @IBAction func expandButtonTapped() {
        
        print("Expand button tapped!")
        
        if self.isBioBig() {
            
            self.makeBioSmaller()
            
        } else {
            
            self.expandBio()
        }
    }
    
    @IBAction func discogButtonTapped() {
        
        print("Discography button tapped!")
        
    }
    
    @IBAction func similarArtistButtonTapped() {
        
        print("Similar artists button tapped!")
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
    
    func getArtistDiscographyWithCompletion(artistName: String, completion: @escaping () -> ()) {
        
        SpotifyAPIClient.getArtistDiscographyWithCompletion(artistName: artistName) { (allArtistAlbums) in
            
            guard let allAlbums = allArtistAlbums["items"] as? [[String:AnyObject]]
                else {
                    print("could not get list of albums")
                    return }
            
            for album in allAlbums {
                guard
                    let albumName = album["name"] as? String,
                    let albumImages = album["images"] as? [[String:String]],
                    let albumImageInfo = albumImages[albumImages.count-1] as? [String:String],
                    let albumImageURLString = albumImageInfo["url"]
                    else {
                        print("could not get specific album info")
                        return
                }
                
                let albumImageURL = URL(string: albumImageURLString)
                let albumImageData = try? Data(contentsOf: albumImageURL!)
                let finalAlbumImage = UIImage(data: albumImageData!)
                let addArtistAlbum = Album.init(albumArtist: artistName, albumName: albumName, albumImage: finalAlbumImage!)
                print("ADDED ALBUM: \(addArtistAlbum.albumName) FOR \(addArtistAlbum.albumArtist)")
                self.artistDataStore.artistDiscogphraphy.append(addArtistAlbum)
            }
        }
    }

}
