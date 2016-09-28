//
//  SpotifyAPIClient.swift
//  Music-Hole
//
//  Created by Betty Fung on 9/20/16.
//  Copyright © 2016 Lloyd W. Sykes. All rights reserved.
//

import Foundation

class SpotifyAPIClient {
    
    static let baseURLString = "https://api.spotify.com/v1/"
    static let store = ArtistDataStore.sharedArtistData
    
    class func getArtistDiscographyWithCompletion(artistName: String, completion: @escaping (NSDictionary) ->() ) {
        
        let urlString = "https://api.spotify.com/v1/artists/\(Secrets.spotifyAPIClientID)/albums?album_type=album"
        guard let url = URL(string: urlString) else {
            fatalError("There was a problem unwrapping the URL when trying to get the artist discography from Spotify")
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if let data = data {
                if let responseDictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    if let responseDictionary = responseDictionary {
                        OperationQueue.main.addOperation({
                            completion(responseDictionary)
                            print("RESPONSE: \(responseDictionary)")
                        })
                    } else {
                        print("There was problem unwrapping the responseDictionary in the API Client.")
                    }
                } else {
                    print("There was a problem converting JSON to NSDictionary in API Client.")
                }
            } else if let error = error {
                print("There was a problem unwrapping the data in the API Client or a general networking error: \(error.localizedDescription)")
            }
        })
        
        task.resume()

    }
}
