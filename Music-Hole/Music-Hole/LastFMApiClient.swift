//
//  LastFMApiClient.swift
//  Music-Hole
//
//  Created by Lloyd W. Sykes on 7/30/16.
//  Copyright © 2016 Lloyd W. Sykes. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LastFMApiClient: NSObject {
    
    class func getArtistNamesWithCompletion(completion: (NSDictionary) -> ()) {
        
        let urlString = "\(Secrets.topArtistsAPIURL)&api_key=\(Secrets.lastFMAPIKey)&format=json"
        
        Alamofire.request(.GET, urlString, parameters: [:], encoding: .URL, headers: [:]).responseJSON { (topArtistResponse) in
            if let JSON = topArtistResponse.result.value {
                guard let topArtists = JSON as? NSDictionary else {
                    print("Unable to pull JSON Dictionary for Artist names: \(topArtistResponse.result.value?.error??.localizedDescription)")
                    return
                }
                completion(topArtists)
            }
        }
    }
    
    class func getArtistBioWithCompletion(artistName: String, completion: (NSDictionary) -> ()) {
        
        let urlString = "\(Secrets.artistBioURL)&artist=\(artistName)&api_key=\(Secrets.lastFMAPIKey)&format=json"
        
        Alamofire.request(.GET, urlString, parameters: [:], encoding: .URL, headers: [:]).responseJSON { (bioResponse) in
            if let JSON = bioResponse.result.value {
                guard let bios = JSON as? NSDictionary else {
                    print("Unable to pull JSON Dictionary for Artist Bios: \(bioResponse.result.value?.error??.localizedDescription)")
                    return
                }
                completion(bios)
            }
        }
    }
    
    class func searchArtistsWithCompletion(artistName: String, completion: (NSDictionary) -> ()) {
        
        let urlString = "\(Secrets.searchArtistURL)&artist=\(artistName)&api_key=\(Secrets.lastFMAPIKey)&format=json"
        
        Alamofire.request(.GET, urlString, parameters: [:], encoding: .URL, headers: [:]).responseJSON { (searchResponse) in
            if let JSON = searchResponse.result.value {
                guard let userSearch = JSON as? NSDictionary else {
                    print("Unable to get usearch search results: \(searchResponse.result.error?.localizedDescription)")
                    return
                }
                completion(userSearch)
            }
        }
    }
}