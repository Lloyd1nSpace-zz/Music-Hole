//
//  URLEncoding.swift
//  Music-Hole
//
//  Created by Betty Fung on 10/7/16.
//  Copyright © 2016 Lloyd W. Sykes. All rights reserved.
//

import Foundation

class URLEncoding {
    
    static let encodingDictionary = [
        " " : "%20",
       "\"" : "%22",
        "#" : "%23",
        "$"	: "%24",
        "%" : "%25",
        "&" : "%26",
        "'"	: "%27",
        "("	: "%28",
        ")" : "%29",
        "*" : "%2A",
        "+" : "%2B",
        "," : "%2C",
        "-" : "%2D",
        "." : "%2E",
        "/"	: "%2F",
        "0" : "%30",
        "1"	: "%31",
        "2" : "%32",
        "3" : "%33",
        "4"	: "%34",
        "5" : "%35",
        "6" : "%36",
        "7" : "%37",
        "8" : "%38",
        "9" : "%39",
        ":" : "%3A",
        ";" : "%3B",
        "<" : "%3C",
        "=" : "%3D",
        ">" : "%3E",
        "?" : "%3F",
        "@" : "%40",
        "[" : "%5B",
       "\\" : "%5C",
        "]" : "%5D",
        "^" : "%5E",
        "_" : "%5F",
        "`" : "%60",
        "{" : "%7B",
        "|" : "%7C",
        "}" : "%7D",
        "~" : "%7E",
        "ƒ" : "%C6%92",
        "„" : "%E2%80%9E",
        "…" : "%E2%80%A6",
        "†" : "%E2%80%A0",
        "‡" : "%E2%80%A1",
        "‰" : "%E2%80%B0",
        "Š" : "%C5%A0",
        "Œ" : "%C5%92",
        "Ž" : "%C5%BD",
        "•" : "%E2%80%A2",
        "–" : "%E2%80%93",
        "—" : "%E2%80%94",
        "˜" : "%CB%9C",
        "™" : "%E2%84",
        "š" : "%C5%A1",
        "œ" : "%C5%93",
        "ž" : "%C5%BE",
        "Ÿ" : "%C5%B",
        "¡" : "%C2%A1",
        "¢" : "%C2%A2",
        "£" : "%C2%A3",
        "¤" : "%C2%A4",
        "¥" : "%C2%A5",
        "¦" : "%C2%A6",
        "§" : "%C2%A7",
        "©" : "%C2%A9",
        "ª" : "%C2%AA",
        "«" : "%C2%AB",
        "¬" : "%C2%AC",
        "®" : "%C2%AE",
        "¯" : "%C2%AF",
        "°" : "%C2%B0",
        "±" : "%C2%B1",
        "²" : "%C2%B2",
        "³" : "%C2%B3",
        "µ" : "%C2%B5",
        "¶" : "%C2%B6",
        "·" : "%C2%B7",
        "¸" : "%C2%B8",
        "¹" : "%C2%B9",
        "º" : "%C2%BA",
        "»" : "%C2%BB",
        "¼" : "%C2%BC",
        "½" : "%C2%BD",
        "¾" : "%C2%BE",
        "¿" : "%C2%BF",
        "À" : "%C3%80",
        "Á" : "%C3%81",
        "Â" : "%C3%82",
        "Ã" : "%C3%83",
        "Ä" : "%C3%84",
        "Å" : "%C3%85",
        "Æ" : "%C3%86",
        "Ç" : "%C3%87",
        "È" : "%C3%88",
        "É" : "%C3%89",
        "Ê" : "%C3%8A",
        "Ë" : "%C3%8B",
        "Ì" : "%C3%8C",
        "Í" : "%C3%8D",
        "Î" : "%C3%8E",
        "Ï" : "%C3%8F",
        "Ð" : "%C3%90",
        "Ñ" : "%C3%91",
        "Ò" : "%C3%92",
        "Ó" : "%C3%93",
        "Ô" : "%C3%94",
        "Õ" : "%C3%95",
        "Ö" : "%C3%96",
        "×" : "%C3%97",
        "Ø" : "%C3%98",
        "Ù" : "%C3%99",
        "Ú" : "%C3%9A",
        "Û" : "%C3%9B",
        "Ü" : "%C3%9C",
        "Ý" : "%C3%9D",
        "Þ" : "%C3%9E",
        "ß" : "%C3%9F",
        "à" : "%C3%A0",
        "á" : "%C3%A1",
        "â" : "%C3%A2",
        "ã" : "%C3%A3",
        "ä" : "%C3%A4",
        "å" : "%C3%A5",
        "æ" : "%C3%A6",
        "ç" : "%C3%A7",
        "è" : "%C3%A8",
        "é" : "%C3%A9",
        "ê" : "%C3%AA",
        "ë" : "%C3%AB",
        "ì" : "%C3%AC",
        "í" : "%C3%AD",
        "î" : "%C3%AE",
        "ï" : "%C3%AF",
        "ð" : "%C3%B0",
        "ñ" : "%C3%B1",
        "ò" : "%C3%B2",
        "ó" : "%C3%B3",
        "ô" : "%C3%B4",
        "õ" : "%C3%B5",
        "ö" : "%C3%B6",
        "÷" : "%C3%B7",
        "ø" : "%C3%B8",
        "ù" : "%C3%B9",
        "ú" : "%C3%BA",
        "û" : "%C3%BB",
        "ü" : "%C3%BC",
        "ý" : "%C3%BD",
        "þ" : "%C3%BE",
        "ÿ" : "%C3%BF"
    ]
    
    class func encodeArtistName(selectedArtistName: String) -> String {
        var encodedArtistName = ""
        
        let encodingDictionaryKeys = self.encodingDictionary.keys
        let selectedArtistNameArray = Array(selectedArtistName.characters)
        let selectedArtistNameStringArray = selectedArtistNameArray.map {
            (char) -> String in
            return String(char)
        }
        
        print("-- TESTING ENCODING FUNCTION --")
        print("DICTIONARY KEYS: \(encodingDictionaryKeys)")
        print("ARTIST NAME ARRAY: \(selectedArtistNameArray)")
        print("STRING MAP ARTIST NAME: \(selectedArtistNameStringArray)")
        print("-------------------------------")
//
//        for letter in selectedArtistNameStringArray {
//            if encodingDictionaryKeys.contains(letter) {
//                encodedArtistName = selectedArtistName.replacingOccurrences(of: letter, with: encodingDictionary[letter]!)
//            }
//        }
//        
//        if encodedArtistName.characters.count == 0 {
//            encodedArtistName = selectedArtistName
//        }
        
        if selectedArtistName.contains("+") {
            encodedArtistName = selectedArtistName.replacingOccurrences(of: "+", with: "%2B")
        } else if selectedArtistName.contains("é") {
            encodedArtistName = selectedArtistName.replacingOccurrences(of: "é", with: "%C3%A9")
        } else {
            encodedArtistName = selectedArtistName
        }
        
        return encodedArtistName
    }
}

//encoding reference obtained from: http://www.w3schools.com/tags/ref_urlencode.asp
