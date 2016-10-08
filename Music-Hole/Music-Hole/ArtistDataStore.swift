//
//  ArtistDataStore.swift
//  Music-Hole
//
//  Created by Lloyd W. Sykes on 7/30/16.
//  Copyright © 2016 Lloyd W. Sykes. All rights reserved.
//

import UIKit

class ArtistDataStore {
    
    static let sharedArtistData = ArtistDataStore()
    var topArtists: [String] = []
    var artistSearchResults: [String] = []
    var artistName = ""
    var artistBio = ""
    var artistImage: UIImage!
    var userSearchText = ""
    var similarArtistImages = [String]()
    var similarArtistsNames = [String]()
    var testArtistAndDiscography = [Artist]() //I am testing the use of custom Artist and Album classes here to clean up code and make things more organized :)
    
    func getArtistNamesWithCompletion(_ completion: @escaping () -> ()) {
        
        LastFMApiClient.getArtistNamesWithCompletion { (artistsDict) in
            self.topArtists.removeAll()
            let artist = ArtistInfo.init(topArtistsDictionary: artistsDict)
            
            for artistName in artist.artistNames {
                self.topArtists.append(artistName)
            }
            
            completion()
        }
    }
    
    func getArtistBioWithCompletion(artistName: String, _ completion: @escaping () -> ()) {
        
        self.similarArtistsNames.removeAll()
        self.similarArtistImages.removeAll()
        
        LastFMApiClient.getArtistBioWithCompletion(artistName) { (artistInfo) in
            
            guard
                let info = artistInfo["artist"] as? NSDictionary,
                let bioInfo = info["bio"] as? NSDictionary,
                let bio = bioInfo["content"] as? String,
                let imageInfo = info["image"] as? [NSDictionary] else {
                    fatalError("Couldn't pull the CONTENT from the Artist Info ArtistNameViewController")
            }
            
            let imageSize = imageInfo[3]
            guard
                let imageURLasString = imageSize["#text"] as? String,
                let imageURL = URL(string: imageURLasString),
                let imageData = try? Data(contentsOf: imageURL) else {
                    fatalError("Couldn't pull the CONTENT from the Artist Info ArtistNameViewController")
            }
            
            self.artistBio = bio
            
            print("This is the artist bio: \(self.artistBio)")
            self.artistImage = UIImage(data: imageData)
            
            guard
                let artistDict = artistInfo["artist"] as? NSDictionary,
                let similarArtistsDict = artistDict["similar"] as? NSDictionary,
                let similarArtists = similarArtistsDict["artist"] as? [NSDictionary] else {
                    fatalError("There was an error unwrapping the similar artists information in the ArtistNameViewController.")
            }
            
            for artists in similarArtists {
                
                if let artistNames = artists["name"] as? String {
                    
                    self.similarArtistsNames.append(artistNames)
                    print("These are the similar artist names: \(self.similarArtistsNames)")
                } else {
                    print("There was an error unwrapping the similar artists Name in the data store.")
                }
                
                if let artistImageDict = artists["image"] as? [NSDictionary] {
                    
                    for images in artistImageDict {
                        
                        if images["size"] as? String == "large" {
                            
                            guard let imageAsString = images["#text"] as? String else {
                                fatalError("There was a problem unwrapping similar artists images in the data store.")
                            }
                            
                            self.similarArtistImages.append(imageAsString)
                            print("These are the similar artist URL Strings: \(self.similarArtistImages)")
                        }
                    }
                }
            }
        }
    }
    
    func searchArtistsWithCompletion(_ userText: String, completion: @escaping () -> ()) {
        
        LastFMApiClient.searchArtistsWithCompletion(userText, completion:  { (userSearchDictionary) in
            
            guard
                let userSearchResults = userSearchDictionary["results"] as? NSDictionary,
                let artistMatches = userSearchResults["artistmatches"] as? NSDictionary,
                let artistArray = artistMatches["artist"] as? [NSDictionary] else {
                    print("There was a problem pulling the user search results from the Data Store.")
                    return
            }
            
            for searchArtist in artistArray {
                guard let artistName = searchArtist["name"] as? String else {
                    print("There was a problem getting the artist name out of the user search results in the Data Store.")
                    return
                }
                
                self.artistSearchResults.append(artistName)
                print("These are the names of the user search result: \(self.artistSearchResults)")
                completion()
            }
        })
    }
}
