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
    var similarArtistsNames = [String]()
    var similarArtistImages = [String]()
    
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
                let similarArtists = artistInfo["similar"] as? [NSDictionary] else {
                    fatalError("There was an error unwrapping the similar artists information in the data store.")
            }
            
            for  index in 0..<similarArtists.count {
                
                guard
                    let similarArtistNames = similarArtists[index]["name"] as? [String],
                    let similarArtistsImages = similarArtists[index]["image"] as? [NSDictionary],
                    let artistImageAsURL = similarArtistsImages[3]["#text"] as? [String] else {
                        fatalError("There was an error unwrapping similar artists information in the data store.")
                }
                
                self.similarArtistsNames = similarArtistNames
                self.similarArtistImages = artistImageAsURL
            
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
