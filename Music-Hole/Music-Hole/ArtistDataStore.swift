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
    var artistBio = ""
    var artistImage: UIImage!
    var userSearchText = ""
    var similarArtistImages = [String]()
    var similarArtistsNames = [String]()
    
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
    
    func getSimilarArtistsWithCompletion(_ artistName: String, completion: () -> ()) {
        
        LastFMApiClient.getSimilarArtistsWityhCompletion(artistName) { (artistDict) in
            
            guard
                let artistInfo = artistDict["artist"] as? NSDictionary,
                let similarArtistsDict = artistInfo["similar"] as? NSDictionary,
                let similarArtists = similarArtistsDict["artist"] as? [NSDictionary] else {
                    fatalError("There was an error unwrapping the similar artists information in the data store.")
            }
            
            for artists in similarArtists {
                
                if let artistNames = artists["name"] as? String {
                    self.similarArtistsNames.append(artistNames)
                } else {
                    print("There was an error unwrapping the similar artists Name in the data store.")
                }
                
               // if let artistImageDict = artists["image"] as? [NSDictionary] {
                    
                  //  for images in artistImageDict {
                        
//                        guard let imageSize = images[3] as? NSDictionary else {
//                            fatalError("There was a problem unwrapping image size")
//                        }
//                        guard let imageAsString = imageSize["#text"] as? String else {
//                            fatalError("There was a problem unwrapping similar artists images in the data store.")
//                        }
//                        
//                        self.similarArtistsNames.append(imageAsString)
                        
                 //   }
                }
          //  }
            
            //  self.similarArtistImages = artistImageAsURL
            //    self.similarArtistsNames = similarArtistNames
            
            // }
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
