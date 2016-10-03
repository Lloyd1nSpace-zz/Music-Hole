//
//  Album.swift
//  Music-Hole
//
//  Created by Betty Fung on 9/20/16.
//  Copyright © 2016 Lloyd W. Sykes. All rights reserved.
//

import Foundation

class Album: Hashable, Equatable {
    
    let albumArtist : String //not sure if we need this if this is required in API parameter
    let albumName : String
    let albumImage : UIImage
    
    var hashValue: Int { get { return albumName.hashValue } }
    
    
    init(albumArtist: String, albumName: String, albumImage: UIImage) {
        self.albumArtist = albumArtist
        self.albumName = albumName
        self.albumImage = albumImage
    }
}

func ==(lhs: Album, rhs: Album) -> Bool {
    return lhs.albumName == rhs.albumName
}
