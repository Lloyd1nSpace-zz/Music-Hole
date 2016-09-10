//
//  LastFMApiClient.swift
//  Music-Hole
//
//  Created by Lloyd W. Sykes on 7/30/16.
//  Copyright © 2016 Lloyd W. Sykes. All rights reserved.
//

import Foundation

class LastFMApiClient: NSObject {
    
    class func getArtistNamesWithCompletion(completion: (NSDictionary) -> ()) {
        
        let urlString = "\(Secrets.topArtistsAPIURL)&api_key=\(Secrets.lastFMAPIKey)&format=json"
        guard let url = NSURL(string: urlString) else {
            fatalError("There was a problem unwrapping the URL when trying to get the top Artists in the API Client.")
        }
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url) { (data, response, error) in
            
            if let data = data {
                if let responseDictionary = try? NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary {
                    if let responseDictionary = responseDictionary {
                        NSOperationQueue.mainQueue().addOperationWithBlock({
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
        }
        
        task.resume()
    }
    
    class func getArtistBioWithCompletion(artistName: String, completion: (NSDictionary) -> ()) {
        
        let urlString = "\(Secrets.artistBioURL)&artist=\(artistName)&api_key=\(Secrets.lastFMAPIKey)&format=json"
        guard let url = NSURL(string: urlString) else {
            fatalError("There was a problem unwrapping the URL when trying to get the Artist Bio in the API Client.")
        }
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url) { (data, response, error) in
            
            if let data = data {
                
                if let responseDictionary = try? NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary {
                    if let responseDictionary = responseDictionary {
                        NSOperationQueue.mainQueue().addOperationWithBlock({
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
        }
        
        task.resume()
    }
    
    class func getSimilarArtistsWityhCompletion(artistName: String, completion: (NSDictionary) -> ()) {
        
        let urlString = "\(Secrets.artistBioURL)&artist=\(artistName)&api_key=\(Secrets.lastFMAPIKey)&format=json"
        guard let url = NSURL(string: urlString) else {
            fatalError("Was unable to unwrap the URL when trying to pull similar artists.")
        }
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url) { (data, response, error) in
            
            if let data = data {
                if let responseDictionary = try? NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary {
                    if let responseDictionary = responseDictionary {
                        NSOperationQueue.mainQueue().addOperationWithBlock({
                            completion(responseDictionary)
                        })
                    }
                }
                
            } else if let error = error {
                fatalError("There was a network error when trying to get similar artists: \(error.localizedDescription)")
            }
            
        }
        
        task.resume()
    }
    
    class func searchArtistsWithCompletion(artistName: String, completion: (NSDictionary) -> ()) {
        
        let urlString = "\(Secrets.searchArtistURL)&artist=\(artistName)&api_key=\(Secrets.lastFMAPIKey)&format=json"
        guard let url = NSURL(string: urlString) else {
            fatalError("There was a problem unwrapping the URL in the API Client.")
        }
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url) { (data, response, error) in
            if let data = data {
                if let responseDictionary = try? NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary {
                    if let responseDictionary = responseDictionary {
                        NSOperationQueue.mainQueue().addOperationWithBlock({
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
        }
        
        task.resume()
    }
}