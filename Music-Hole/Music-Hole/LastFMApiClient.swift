//
//  LastFMApiClient.swift
//  Music-Hole
//
//  Created by Lloyd W. Sykes on 7/30/16.
//  Copyright © 2016 Lloyd W. Sykes. All rights reserved.
//

import Foundation

struct LastFMApiClient {
    
    static func getArtistNamesWithCompletion(_ completion: @escaping (NSDictionary) -> ()) {
        
        let urlString = "\(Secrets.topArtistsAPIURL)&api_key=\(Secrets.lastFMAPIKey)&format=json"
        guard let url = URL(string: urlString) else {
            fatalError("There was a problem unwrapping the URL when trying to get the top Artists in the API Client.")
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if let data = data {
                if let responseDictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    if let responseDictionary = responseDictionary {
                        OperationQueue.main.addOperation({
                            completion(responseDictionary)
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
    
    static func getArtistBioWithCompletion(_ artistName: String, completion: @escaping (NSDictionary) -> ()) {
        
        let urlString = "\(Secrets.artistBioURL)&artist=\(artistName)&api_key=\(Secrets.lastFMAPIKey)&format=json"
        guard let url = URL(string: urlString) else {
            fatalError("There was a problem unwrapping the URL when trying to get the Artist Bio in the API Client.")
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if let data = data {
                
                if let responseDictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    if let responseDictionary = responseDictionary {
                        OperationQueue.main.addOperation({
                            completion(responseDictionary)
                        })
                    } else {
                        print("There was a problem unwrapping the responseDictionary from the API Client.")
                    }
                } else {
                    print("There was a problem converting the JSON to NSDictionary.")
                }
            } else if let error = error {
                fatalError("There's been an error unwrapping the data or a general network error: \(error.localizedDescription)")
            }
        })
        
        task.resume()
    }
    
    static func searchArtistsWithCompletion(_ artistName: String, completion: @escaping (NSDictionary) -> ()) {
        
        let urlString = "\(Secrets.searchArtistURL)&artist=\(artistName)&api_key=\(Secrets.lastFMAPIKey)&format=json"
        guard let url = URL(string: urlString) else {
            fatalError("There was a problem unwrapping the URL in the API Client.")
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            if let data = data {
                if let responseDictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    if let responseDictionary = responseDictionary {
                        OperationQueue.main.addOperation({
                            completion(responseDictionary)
                        })
                    } else {
                        print("There was a problem unwrapping the responseDictionary in the API Client.")
                    }
                } else {
                    print("There was a problem converting JSON to NSDictionary in the API Client.")
                }
            } else if let error = error {
                fatalError("There was a problem unwrapping data or general network error: \(error.localizedDescription)")
            }
        })
        
        task.resume()
    }
}
