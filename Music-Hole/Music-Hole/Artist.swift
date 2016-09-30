//
//  Artist.swift
//  Music-Hole
//
//  Created by Betty Fung on 9/30/16.
//  Copyright © 2016 Lloyd W. Sykes. All rights reserved.
//

import Foundation

class Artist {
    
    let name : String
    let spotifyID : String
    let discography : [Album]
//    let bio : String?
//    let similarArtists : String?
    
    init(name: String, spotifyID: String, discography: [Album]) {
        self.name = name
        self.spotifyID = spotifyID
        self.discography = discography
    }
}
