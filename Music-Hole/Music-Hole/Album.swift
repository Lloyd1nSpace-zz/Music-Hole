//
//  Album.swift
//  Music-Hole
//
//  Created by Betty Fung on 9/20/16.
//  Copyright © 2016 Lloyd W. Sykes. All rights reserved.
//

import Foundation

class Album {
    
    let albumArtist : String //not sure if we need this if this is required in API parameter
    let albumName : String
    let albumImage : UIImage
    
    // var hashValue: Int { get { return albumName.hashValue } }
    
    
    init(albumArtist: String, albumName: String, albumImage: UIImage) {
        self.albumArtist = albumArtist
        self.albumName = albumName
        self.albumImage = albumImage
    }
}

//extension Array where Element : Equatable {
//    
//    var unique: [Element] {
//        var uniqueValues: [Element] = []
//        forEach { item in
//            if !uniqueValues.contains(item) {
//                uniqueValues += [item]
//            }
//        }
//        return uniqueValues
//    }
//    
//}
//
//func ==(lhs: Album, rhs: Album) -> Bool {
//    return lhs.albumName == rhs.albumName
//}
