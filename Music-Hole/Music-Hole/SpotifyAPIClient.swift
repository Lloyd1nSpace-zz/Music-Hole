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
    
    class func getArtistIDWithCompletion(artistName: String, completion: @escaping(String)->()){
        
        let formattedArtistName = URLEncoding.encodeArtistName(selectedArtistName: artistName)
        let formattedArtistForURL = formattedArtistName.replacingOccurrences(of: " ", with: "+")
        
        let artistURLString = "https://api.spotify.com/v1/search?q=\(formattedArtistForURL)&type=artist"
        guard let artistURL = URL(string: artistURLString) else {
            print("could not unwrap artist url string")
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: artistURL, completionHandler: { (data, response, error) in
            
            if let data = data {
                if let responseDictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {

                    if let responseDictionary = responseDictionary {
                        
                        guard let
                            artistSearchResults = responseDictionary["artists"] as? [String: AnyObject],
                            let spotifyArtistInfo = artistSearchResults["items"] as? [[String:AnyObject]],
                            let matchSpotifyArtistInfo = spotifyArtistInfo[0] as? [String:AnyObject],
                            let matchSpotifyArtistID = matchSpotifyArtistInfo["id"] as? String
                        else {
                            print("could not unwrap artist information from search")
                            return
                        }

                        print("ARTIST ID IN API CALL: \(matchSpotifyArtistID)")
                        
                        let artist = Artist(name: artistName, spotifyID: matchSpotifyArtistID)
                        self.store.testArtistAndDiscography.append(artist)
                            
                        completion(matchSpotifyArtistID)
                        
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
    
    class func getArtistDiscographyWithCompletion(artistID: String, completion: @escaping (NSDictionary) ->() ) {
        
        let urlString = "https://api.spotify.com/v1/artists/\(artistID)/albums?market=US&album_type=album"
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
