//
//  ArtistInfo.swift
//  Music-Hole
//
//  Created by Lloyd W. Sykes on 7/30/16.
//  Copyright © 2016 Lloyd W. Sykes. All rights reserved.
//

import Foundation

class ArtistInfo {
    
    let artistsDataStore = ArtistDataStore.sharedArtistData
    var artistNames: [String] = []
    var artistBio = ""
    
    init(topArtistsDictionary: NSDictionary) {
        
        guard
            let artistsDictionary = topArtistsDictionary["artists"] as? NSDictionary,
            let artistArrayOfDictionary = artistsDictionary["artist"] as? [NSDictionary] else {
                print("Couldn't pull Artist Array from API.")
                return
        }
        
        for artistInfo in artistArrayOfDictionary {
            guard let artistsName = artistInfo["name"] as? String else {
                print("Couldn't pull artists name.")
                return
            }
            self.artistNames.append(artistsName)
        }
    }
}