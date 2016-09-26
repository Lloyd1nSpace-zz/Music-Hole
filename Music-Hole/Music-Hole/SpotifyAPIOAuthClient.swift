//
//  SpotifyAPIOAuthClient.swift
//  Music-Hole
//
//  Created by Betty Fung on 9/20/16.
//  Copyright © 2016 Lloyd W. Sykes. All rights reserved.
//

import Foundation

struct SpotifyAPIOAuthClient {
    
    static let encodedRedirectURI = "musichole%3A%2F%2Fgetdata"
    
    enum URLRouter {
        static let token = "https://accounts.spotify.com/api/token"
        static let oauth = "https://accounts.spotify.com/authorize?client_id=\(Secrets.spotifyAPIClientID)&response_type=code&redirect_uri=\(SpotifyAPIOAuthClient.encodedRedirectURI)"
    }
    
    static func spotifyAccessTokenRequest(url: NSURL) {
        
    }
    
}
