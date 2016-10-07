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
    var selectedArtist = String()
    var artist = Artist(name: "", spotifyID: "")
    
    var artistScrollView = UIScrollView()
    var contentView = UIView()
    var artistBioTextView = UITextView()
    var artistBioTextViewHeightConstraint = NSLayoutConstraint()
    var artistImage = UIImageView()
    var bioLabel = UILabel()
    var expandButton = UIButton()
    var discographyLabel = UILabel()
    var seeAllDiscogButton = UIButton()
    var artistDiscogImageLabelStackView = UIStackView()
    var artistDiscographyImageStackView = UIStackView()
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
    var similarArtistsLabel = UILabel()
    var similarArtistImageLabelStackView = UIStackView()
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
    //var testImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.createViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getArtistDiscographyWithCompletion(artistName: selectedArtist) {
            print("CALLED DISCOGRAPHY FUNCTION FOR \(self.selectedArtist)")
            
            for testArtist in self.artistDataStore.testArtistAndDiscography {
                if testArtist.name == self.selectedArtist {
                    self.artist = testArtist
                }
            }
            print("populating \(self.artist) images")
            self.artistDiscographyImages(discographyForArtist: self.artist)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createViews() {
        
        self.contentView.frame = CGRect(x: 0.0, y: 0.0, width: self.view.bounds.width, height: self.view.bounds.height + 350)
        self.contentView.backgroundColor = UIColor.clear //this is for debugging purposes
        
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
        
        self.seeAllDiscogButton.setTitle("See all", for: .normal)
        self.seeAllDiscogButton.setTitleColor(UIColor.black, for: .normal)
        self.seeAllDiscogButton.addTarget(self, action: #selector(self.seeAllDiscogButtonTapped), for: .touchUpInside)
        self.seeAllDiscogButton.backgroundColor = UIColor.red
        self.seeAllDiscogButton.layer.cornerRadius = 7
        
        self.discogButton1.addTarget(self, action: #selector(self.discogButtonTapped), for: .touchUpInside)
        self.discogButton2.addTarget(self, action: #selector(self.discogButtonTapped), for: .touchUpInside)
        self.discogButton3.addTarget(self, action: #selector(self.discogButtonTapped), for: .touchUpInside)
        self.discogButton4.addTarget(self, action: #selector(self.discogButtonTapped), for: .touchUpInside)
        self.discogButton5.addTarget(self, action: #selector(self.discogButtonTapped), for: .touchUpInside)
        
        self.artistDiscogImageLabelStackView.addArrangedSubview(self.artistDiscographyImageStackView)
        self.artistDiscogImageLabelStackView.addArrangedSubview(self.discographyLabelsStackView)
        
        self.artistDiscographyImageStackView.addArrangedSubview(self.discogButton1)
        self.artistDiscographyImageStackView.addArrangedSubview(self.discogButton2)
        self.artistDiscographyImageStackView.addArrangedSubview(self.discogButton3)
        self.artistDiscographyImageStackView.addArrangedSubview(self.discogButton4)
        self.artistDiscographyImageStackView.addArrangedSubview(self.discogButton5)
        
        self.discogLabel1.textColor = UIColor.white
        self.discogLabel2.textColor = UIColor.white
        self.discogLabel3.textColor = UIColor.white
        self.discogLabel4.textColor = UIColor.white
        self.discogLabel5.textColor = UIColor.white
        
        self.discographyLabelsStackView.addArrangedSubview(self.discogLabel1)
        self.discographyLabelsStackView.addArrangedSubview(self.discogLabel2)
        self.discographyLabelsStackView.addArrangedSubview(self.discogLabel3)
        self.discographyLabelsStackView.addArrangedSubview(self.discogLabel4)
        self.discographyLabelsStackView.addArrangedSubview(self.discogLabel5)
        
        self.similarImageButtonSetup()
        
        self.similarArtist1.text = self.artistDataStore.similarArtistsNames[0]
        self.similarArtist2.text = self.artistDataStore.similarArtistsNames[1]
        self.similarArtist3.text = self.artistDataStore.similarArtistsNames[2]
        self.similarArtist4.text = self.artistDataStore.similarArtistsNames[3]
        self.similarArtist5.text = self.artistDataStore.similarArtistsNames[4]
        
        self.similarArtist1.textColor = UIColor.white
        self.similarArtist2.textColor = UIColor.white
        self.similarArtist3.textColor = UIColor.white
        self.similarArtist4.textColor = UIColor.white
        self.similarArtist5.textColor = UIColor.white
        
        self.similarArtist1.textAlignment = .center
        self.similarArtist2.textAlignment = .center
        self.similarArtist3.textAlignment = .center
        self.similarArtist4.textAlignment = .center
        self.similarArtist5.textAlignment = .center
        
        self.similarArtistImageLabelStackView.addArrangedSubview(self.similarArtistsImagesStackView)
        self.similarArtistImageLabelStackView.addArrangedSubview(self.similarArtistsLabelsStackView)
        
        self.similarArtistsImagesStackView.addArrangedSubview(similarButton1)
        self.similarArtistsImagesStackView.addArrangedSubview(similarButton2)
        self.similarArtistsImagesStackView.addArrangedSubview(similarButton3)
        self.similarArtistsImagesStackView.addArrangedSubview(similarButton4)
        self.similarArtistsImagesStackView.addArrangedSubview(similarButton5)
        
        self.similarArtistsLabelsStackView.addArrangedSubview(self.similarArtist1)
        self.similarArtistsLabelsStackView.addArrangedSubview(self.similarArtist2)
        self.similarArtistsLabelsStackView.addArrangedSubview(self.similarArtist3)
        self.similarArtistsLabelsStackView.addArrangedSubview(self.similarArtist4)
        self.similarArtistsLabelsStackView.addArrangedSubview(self.similarArtist5)
        
        self.view.addSubview(self.artistScrollView)
        self.artistScrollView.addSubview(self.contentView)
        
        self.contentView.addSubview(self.artistImage)
        self.contentView.addSubview(self.bioLabel)
        self.contentView.addSubview(self.artistBioTextView)
        self.contentView.addSubview(self.expandButton)
        self.contentView.addSubview(self.discographyLabel)
        self.contentView.addSubview(self.seeAllDiscogButton)
        self.contentView.addSubview(self.artistDiscogImageLabelStackView)
        self.contentView.addSubview(self.similarArtistsLabel)
        self.contentView.addSubview(self.similarArtistImageLabelStackView)
        
        self.setUpSegues()
        
        self.viewConstraints()
    }
    
    func setUpSegues() {
        
        self.shouldPerformSegue(withIdentifier: "similarArtist1", sender: self)
        self.shouldPerformSegue(withIdentifier: "similarArtist2", sender: self)
        self.shouldPerformSegue(withIdentifier: "similarArtist3", sender: self)
        self.shouldPerformSegue(withIdentifier: "similarArtist4", sender: self)
        self.shouldPerformSegue(withIdentifier: "similarArtist5", sender: self)
    }
    
    func viewConstraints() {
        
        //    let viewsHeights = self.artistImage.frame.height + self.bioLabel.frame.height + self.artistBioTextView.frame.height + self.discographyLabel.frame.height + self.artistDiscographyImageStackView.frame.height + self.similarArtistsLabel.frame.height + self.similarArtistsImagesStackView.frame.height
        
        self.artistScrollView.translatesAutoresizingMaskIntoConstraints = false
        self.artistScrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.artistScrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.artistScrollView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.artistScrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        
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
        self.expandButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 150).isActive = true
        
        self.discographyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.discographyLabel.topAnchor.constraint(equalTo: self.expandButton.bottomAnchor, constant: 20).isActive = true
        self.discographyLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/2).isActive = true
        self.discographyLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/18).isActive = true
        
        self.seeAllDiscogButton.translatesAutoresizingMaskIntoConstraints = false
        self.seeAllDiscogButton.topAnchor.constraint(equalTo: self.expandButton.bottomAnchor, constant: 20).isActive = true
        self.seeAllDiscogButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 150).isActive = true
        self.seeAllDiscogButton.widthAnchor.constraint(equalTo: self.expandButton.widthAnchor).isActive = true
        self.seeAllDiscogButton.heightAnchor.constraint(equalTo: self.expandButton.heightAnchor).isActive = true
        
        self.artistDiscogImageLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        self.artistDiscogImageLabelStackView.topAnchor.constraint(equalTo: self.discographyLabel.bottomAnchor).isActive = true
        self.artistDiscogImageLabelStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.artistDiscogImageLabelStackView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/6).isActive = true
        
        self.artistDiscographyImageStackView.translatesAutoresizingMaskIntoConstraints = false
        self.artistDiscographyImageStackView.topAnchor.constraint(equalTo: self.artistDiscogImageLabelStackView.topAnchor).isActive = true
        self.artistDiscographyImageStackView.widthAnchor.constraint(equalTo: self.artistDiscogImageLabelStackView.widthAnchor).isActive = true
        self.artistDiscographyImageStackView.heightAnchor.constraint(equalTo: self.artistDiscogImageLabelStackView.heightAnchor, multiplier: 3/4).isActive = true
        
        self.discogButton1.translatesAutoresizingMaskIntoConstraints = false
        self.discogButton1.widthAnchor.constraint(equalTo: self.artistDiscographyImageStackView.widthAnchor, multiplier: 1/5).isActive = true
        self.discogButton1.heightAnchor.constraint(equalTo: self.artistDiscographyImageStackView.heightAnchor).isActive = true
        self.discogButton1.leftAnchor.constraint(equalTo: self.artistDiscographyImageStackView.leftAnchor).isActive = true
        
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
        self.discogButton5.rightAnchor.constraint(equalTo: self.artistDiscographyImageStackView.rightAnchor).isActive = true
        
        self.discographyLabelsStackView.translatesAutoresizingMaskIntoConstraints = false
        self.discographyLabelsStackView.bottomAnchor.constraint(equalTo: self.artistDiscogImageLabelStackView.bottomAnchor).isActive = true
        self.discographyLabelsStackView.widthAnchor.constraint(equalTo: self.artistDiscogImageLabelStackView.widthAnchor).isActive = true
        self.discographyLabelsStackView.heightAnchor.constraint(equalTo: self.artistDiscogImageLabelStackView.heightAnchor, multiplier: 1/4).isActive = true
        
        self.discogLabel1.translatesAutoresizingMaskIntoConstraints = false
        self.discogLabel1.leftAnchor.constraint(equalTo: self.discographyLabelsStackView.leftAnchor).isActive = true
        self.discogLabel1.widthAnchor.constraint(equalTo: self.discogButton1.widthAnchor).isActive = true
        self.discogLabel1.heightAnchor.constraint(equalTo: self.discographyLabelsStackView.heightAnchor).isActive = true
        
        self.discogLabel2.translatesAutoresizingMaskIntoConstraints = false
        self.discogLabel2.leftAnchor.constraint(equalTo: self.discogLabel1.rightAnchor).isActive = true
        self.discogLabel2.widthAnchor.constraint(equalTo: self.discogLabel1.widthAnchor).isActive = true
        self.discogLabel2.heightAnchor.constraint(equalTo: self.discogLabel1.heightAnchor).isActive = true
        
        self.discogLabel3.translatesAutoresizingMaskIntoConstraints = false
        self.discogLabel3.leftAnchor.constraint(equalTo: self.discogLabel2.rightAnchor).isActive = true
        self.discogLabel3.widthAnchor.constraint(equalTo: self.discogLabel1.widthAnchor).isActive = true
        self.discogLabel3.heightAnchor.constraint(equalTo: self.discogLabel1.heightAnchor).isActive = true
        
        self.discogLabel4.translatesAutoresizingMaskIntoConstraints = false
        self.discogLabel4.leftAnchor.constraint(equalTo: self.discogLabel3.rightAnchor).isActive = true
        self.discogLabel4.widthAnchor.constraint(equalTo: self.discogLabel1.widthAnchor).isActive = true
        self.discogLabel4.heightAnchor.constraint(equalTo: self.discogLabel1.heightAnchor).isActive = true
        
        self.discogLabel5.translatesAutoresizingMaskIntoConstraints = false
        self.discogLabel5.rightAnchor.constraint(equalTo: self.discographyLabelsStackView.rightAnchor).isActive = true
        self.discogLabel5.widthAnchor.constraint(equalTo: self.discogLabel1.widthAnchor).isActive = true
        self.discogLabel5.heightAnchor.constraint(equalTo: self.discogLabel1.heightAnchor).isActive = true
        
        self.similarArtistsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.similarArtistsLabel.topAnchor.constraint(equalTo: self.artistDiscogImageLabelStackView.bottomAnchor, constant: 5).isActive = true
        self.similarArtistsLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/2).isActive = true
        self.similarArtistsLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/18).isActive = true
        
        self.similarArtistImageLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        self.similarArtistImageLabelStackView.topAnchor.constraint(equalTo: self.similarArtistsLabel.bottomAnchor).isActive = true
        self.similarArtistImageLabelStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.similarArtistImageLabelStackView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/6).isActive = true
        
        self.similarArtistsImagesStackView.translatesAutoresizingMaskIntoConstraints = false
        self.similarArtistsImagesStackView.topAnchor.constraint(equalTo: self.similarArtistImageLabelStackView.topAnchor).isActive = true
        self.similarArtistsImagesStackView.widthAnchor.constraint(equalTo: self.similarArtistImageLabelStackView.widthAnchor).isActive = true
        self.similarArtistsImagesStackView.heightAnchor.constraint(equalTo: self.similarArtistImageLabelStackView.heightAnchor, multiplier: 3/4).isActive = true
        
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
        self.similarArtistsLabelsStackView.bottomAnchor.constraint(equalTo: self.similarArtistImageLabelStackView.bottomAnchor).isActive = true
        self.similarArtistsLabelsStackView.widthAnchor.constraint(equalTo: self.similarArtistImageLabelStackView.widthAnchor).isActive = true
        self.similarArtistsLabelsStackView.heightAnchor.constraint(equalTo: self.similarArtistImageLabelStackView.heightAnchor, multiplier: 1/4).isActive = true
        
        self.similarArtist1.translatesAutoresizingMaskIntoConstraints = false
        self.similarArtist1.leftAnchor.constraint(equalTo: self.similarArtistsLabelsStackView.leftAnchor).isActive = true
        self.similarArtist1.widthAnchor.constraint(equalTo: self.similarArtistsLabelsStackView.widthAnchor, multiplier: 1/5).isActive = true
        self.similarArtist1.heightAnchor.constraint(equalTo: self.similarArtistsLabelsStackView.heightAnchor).isActive = true
        
        self.similarArtist2.translatesAutoresizingMaskIntoConstraints = false
        self.similarArtist2.leftAnchor.constraint(equalTo: self.similarArtist1.rightAnchor).isActive = true
        self.similarArtist2.widthAnchor.constraint(equalTo: self.similarArtist1.widthAnchor).isActive = true
        self.similarArtist2.heightAnchor.constraint(equalTo: self.similarArtist1.heightAnchor).isActive = true
        
        self.similarArtist3.translatesAutoresizingMaskIntoConstraints = false
        self.similarArtist3.leftAnchor.constraint(equalTo: self.similarArtist2.rightAnchor).isActive = true
        self.similarArtist3.widthAnchor.constraint(equalTo: self.similarArtist1.widthAnchor).isActive = true
        self.similarArtist3.heightAnchor.constraint(equalTo: self.similarArtist1.heightAnchor).isActive = true
        
        self.similarArtist4.translatesAutoresizingMaskIntoConstraints = false
        self.similarArtist4.leftAnchor.constraint(equalTo: self.similarArtist3.rightAnchor).isActive = true
        self.similarArtist4.widthAnchor.constraint(equalTo: self.similarArtist1.widthAnchor).isActive = true
        self.similarArtist4.heightAnchor.constraint(equalTo: self.similarArtist1.heightAnchor).isActive = true
        
        self.similarArtist5.translatesAutoresizingMaskIntoConstraints = false
        self.similarArtist5.rightAnchor.constraint(equalTo: self.similarArtistsLabelsStackView.rightAnchor).isActive = true
        self.similarArtist5.widthAnchor.constraint(equalTo: self.similarArtist1.widthAnchor).isActive = true
        self.similarArtist5.heightAnchor.constraint(equalTo: self.similarArtist1.heightAnchor).isActive = true
        
        self.artistDiscogImageLabelStackView.axis = .vertical
        self.artistDiscographyImageStackView.axis = .horizontal
        self.discographyLabelsStackView.axis = .horizontal
        
        self.similarArtistImageLabelStackView.axis = .vertical
        self.similarArtistsImagesStackView.axis = .horizontal
        self.similarArtistsLabelsStackView.axis = .horizontal
    }
    
    func similarImageButtonSetup() {
        
        guard
            let url1 = URL(string: self.artistDataStore.similarArtistImages[0]),
            let url2 = URL(string: self.artistDataStore.similarArtistImages[1]),
            let url3 = URL(string: self.artistDataStore.similarArtistImages[2]),
            let url4 = URL(string: self.artistDataStore.similarArtistImages[3]),
            let url5 = URL(string: self.artistDataStore.similarArtistImages[4]) else {
                fatalError("There was an issue unwrapping the image URLs from ArtistInfoVC")
        }
        
        do {
            
            let data1 = try Data(contentsOf: url1)
            let data2 = try Data(contentsOf: url2)
            let data3 = try Data(contentsOf: url3)
            let data4 = try Data(contentsOf: url4)
            let data5 = try Data(contentsOf: url5)
            
            let similarImage1 = UIImage(data: data1)
            let similarImage2 = UIImage(data: data2)
            let similarImage3 = UIImage(data: data3)
            let similarImage4 = UIImage(data: data4)
            let similarImage5 = UIImage(data: data5)
            
            self.similarButton1.setBackgroundImage(similarImage1, for: .normal)
            self.similarButton2.setBackgroundImage(similarImage2, for: .normal)
            self.similarButton3.setBackgroundImage(similarImage3, for: .normal)
            self.similarButton4.setBackgroundImage(similarImage4, for: .normal)
            self.similarButton5.setBackgroundImage(similarImage5, for: .normal)
            
            
        } catch {
            
            print("There was an issue unwrapping the Data for the images in ArtistInfoVC")
        }
        
        self.similarButton1.addTarget(self, action: #selector(self.similarArtistButtonTapped), for: .touchUpInside)
        self.similarButton2.addTarget(self, action: #selector(self.similarArtistButtonTapped), for: .touchUpInside)
        self.similarButton3.addTarget(self, action: #selector(self.similarArtistButtonTapped), for: .touchUpInside)
        self.similarButton4.addTarget(self, action: #selector(self.similarArtistButtonTapped), for: .touchUpInside)
        self.similarButton5.addTarget(self, action: #selector(self.similarArtistButtonTapped), for: .touchUpInside)
    }
    
    func displayDiscographyImagesSetup(artist: Artist) {
        let artistDiscography = artist.discography
        
    }
    
    @IBAction func expandButtonTapped() {
        
        if self.isBioBig() {
            
            self.makeBioSmaller()
            
        } else {
            
            self.expandBio()
        }
    }
    
    @IBAction func seeAllDiscogButtonTapped() {
        
        print("See all Discography button tapped!")
    }
    
    @IBAction func discogButtonTapped() {
        
        print("Discography button tapped!")
        
    }
    
    @IBAction func similarArtistButtonTapped() {
        
        print("Similar artists button tapped!")
        
        let destination = SimilarArtistViewController()
        self.navigationController?.show(destination, sender: self)
        
        // Refresh this VC to reflect the info for the similar artist that was selected.
        
        //        for artist in self.artistDataStore.similarArtistsNames {
        //
        //            let formattedArtistName = ArtistInfo.formatArtistName(selectedArtistName: artist)
        //            let selectedArtistForURL = formattedArtistName.replacingOccurrences(of: " ", with: "+")
        //
        //            self.artistDataStore.getArtistBioWithCompletion(artistName: selectedArtistForURL) {
        //
        //                self.navigationController?.show(destination, sender: self)
        //            }
        //        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "similarArtist1" {
            if let destination = segue.destination as? SimilarArtistViewController {
                
                let formattedArtistName = ArtistInfo.formatArtistName(selectedArtistName: self.similarArtist1.text!)
                let selectedArtistForURL = formattedArtistName.replacingOccurrences(of: " ", with: "+")
                
                self.artistDataStore.getArtistBioWithCompletion(artistName: selectedArtistForURL) {
                    
                    self.navigationController?.show(destination, sender: self)
                }
                
                destination.artistImage = UIImageView(image: self.artistDataStore.artistImage)
                destination.artistBioTextView.text = self.artistDataStore.artistBio
            }
        } else if segue.identifier == "similarArtist2" {
            
            if let destination = segue.destination as? SimilarArtistViewController {
                
                let formattedArtistName = ArtistInfo.formatArtistName(selectedArtistName: self.similarArtist2.text!)
                let selectedArtistForURL = formattedArtistName.replacingOccurrences(of: " ", with: "+")
                
                self.artistDataStore.getArtistBioWithCompletion(artistName: selectedArtistForURL) {
                    
                }
            }
            
        } else if segue.identifier == "similarArtist3" {
            
            if let destination = segue.destination as? SimilarArtistViewController {
                
                let formattedArtistName = ArtistInfo.formatArtistName(selectedArtistName: self.similarArtist3.text!)
                let selectedArtistForURL = formattedArtistName.replacingOccurrences(of: " ", with: "+")
                
                self.artistDataStore.getArtistBioWithCompletion(artistName: selectedArtistForURL) {
                    
                }
            }
            
        } else if segue.identifier == "similarArtist4" {
            
            if let destination = segue.destination as? SimilarArtistViewController {
                
                let formattedArtistName = ArtistInfo.formatArtistName(selectedArtistName: self.similarArtist4.text!)
                let selectedArtistForURL = formattedArtistName.replacingOccurrences(of: " ", with: "+")
                
                self.artistDataStore.getArtistBioWithCompletion(artistName: selectedArtistForURL) {
                    
                }
            }
            
        } else if segue.identifier == "similarArtist5" {
            
            if let destination = segue.destination as? SimilarArtistViewController {
                
                let formattedArtistName = ArtistInfo.formatArtistName(selectedArtistName: self.similarArtist5.text!)
                let selectedArtistForURL = formattedArtistName.replacingOccurrences(of: " ", with: "+")
                
                self.artistDataStore.getArtistBioWithCompletion(artistName: selectedArtistForURL) {
                    
                }
            }
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
        self.expandButton.setTitle("Collapse", for: .normal)
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.artistBioTextViewHeightConstraint.constant += 125
            self.view.layoutIfNeeded()
        })
    }
    
    func makeBioSmaller() {
        
        self.artistBioTextView.isScrollEnabled = false
        self.expandButton.setTitle("Expand", for: .normal)
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.artistBioTextViewHeightConstraint.constant -= 125
            self.view.layoutIfNeeded()
        })
    }
    
    func getArtistDiscographyWithCompletion(artistName: String, completion: @escaping () -> ()) {
        
        var listOfAlbums = [Album]()
        var listOfAlbumNames = [String]()
        
    
        //need to get artistID before getting their discography info
        SpotifyAPIClient.getArtistIDWithCompletion(artistName: artistName) { (ArtistID) in
            
            SpotifyAPIClient.getArtistDiscographyWithCompletion(artistID: ArtistID) { (allArtistAlbums) in
                
                print("ArtistName: \(artistName)\nArtistID: \(ArtistID)")
                
                guard let allAlbums = allArtistAlbums["items"] as? [[String:AnyObject]]
                    else {
                        print("could not get list of albums")
                        return }
                
                for album in allAlbums {
                    print("SPECIFIC ALBUM IN ALBUM RESULTS: \(album)")
                    print("album name: \(album["name"])")
                    print("album images: \(album["images"]?.lastObject)")
                    guard
                        let albumName = album["name"] as? String,
                        let albumImageInfo = album["images"]?.lastObject as? [String:AnyObject],
                        let albumImageURLString = albumImageInfo["url"] as? String
                        else {
                            print("could not get specific album info")
                            return
                    }
                    
                    let albumImageURL = URL(string: albumImageURLString)
                    let albumImageData = try? Data(contentsOf: albumImageURL!)
                    let albumImage = UIImage(data: albumImageData!)
                    let addArtistAlbum = Album(albumArtist: artistName, albumName: albumName, albumImage: albumImage!)
                    
                    
                    let checkDuplicateAlbumName = addArtistAlbum.albumName
                    if !listOfAlbumNames.contains(checkDuplicateAlbumName) {
                        listOfAlbumNames.append(checkDuplicateAlbumName)
                        listOfAlbums.append(addArtistAlbum)
                    }
                }
                
                
                for artist in self.artistDataStore.testArtistAndDiscography {
                    print ("checking to add album for artist \(artist.name)")
                    print("number of albums to add: \(listOfAlbums.count)")
                    if artist.name == artistName {
                        print("found a match! \(artistName) == \(artist.name)")
                        print("current artist info: \(artist.discography?.count)")
                        artist.discography!.append(contentsOf: listOfAlbums)
                        print("after adding album: \(artist.discography?.count)")
                    }
                }
                
                print("******** ARTIST & DISCOGRAPHY INFORMATION ********")
                for artist in self.artistDataStore.testArtistAndDiscography {
                    print("artist name: \(artist.name)")
                    print("artist id: \(artist.spotifyID)")
                    for album in artist.discography! {
                        print("\(album.albumName)")
                    }
                }
                print("***************************************************")
                
                completion()
            } // end discography call
            completion()
        } // end artist id call
    }
    
    func artistDiscographyImages(discographyForArtist: Artist) {
        
        print("INSIDE FUNCTION -- obtaining discography images for \(discographyForArtist)")
        
        guard let artistDiscography = discographyForArtist.discography else {
            print("could not unwrap artist discography to populate images")
            return
        }
        var discographyButtons = [self.discogButton1, self.discogButton2, self.discogButton3, self.discogButton4, self.discogButton5]
        var discographyTextLabels = [self.discogLabel1, self.discogLabel2, self.discogLabel3, self.discogLabel4, self.discogLabel5]
        
        
        var artistDiscographyInfoDisplay = [(UILabel, UIButton)]()
        for (index, label) in discographyTextLabels.enumerated() {
            artistDiscographyInfoDisplay.append((label, discographyButtons[index]))
        }
        
        
        for (index, album) in artistDiscography.enumerated() {
            var currentLabel = UILabel()
            var currentButton = UIButton()
            
            if index < artistDiscographyInfoDisplay.count-1 {
                currentLabel = discographyTextLabels[index]
                currentButton = discographyButtons[index]
                
                currentLabel.text = album.albumName
                currentButton.setBackgroundImage(album.albumImage, for: .normal)
                artistDiscographyInfoDisplay[index] = (currentLabel, currentButton)
            } else {
                currentButton = discographyButtons[index]
                currentButton.backgroundColor = UIColor.clear
                break
            }
        }
        
        print("***** CHECKING DISCOG INFO *****")
        for info in artistDiscographyInfoDisplay {
            print("album name: \(info.0.text), album image: \(info.1.description)")
        }
        
    }
    
}
