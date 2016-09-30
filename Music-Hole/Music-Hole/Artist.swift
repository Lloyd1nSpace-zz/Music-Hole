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
    var discography : [Album] //this is var b/c there can always be more albums to add to this array 
//    let bio : String?
//    let similarArtists : String?
    
    init(name: String, spotifyID: String, discography: [Album]) {
        self.name = name
        self.spotifyID = spotifyID
        self.discography = discography
    }
    
    convenience init(name: String, spotifyID: String){
        self.init(name: name, spotifyID: spotifyID, discography: [Album]())
    }
}
