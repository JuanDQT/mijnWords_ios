//
//  Common.swift
//  MijnWords
//
//  Created by Juan Daniel on 26/8/17.
//  Copyright © 2017 Juan Daniel. All rights reserved.
//
import UIKit
import SwiftyJSON

class Common {
    
    static let allLanguages:[String] = [String](arrayLiteral: "EN", "NL")
    
    static func getFocusLanguage() -> String {
        
        if (UserDefaults.standard.string(forKey: "LN")) == nil {
            log.error("Language UserDefaults: default(EN)")
            return "EN"
        }
        
        log.info("Language UserDefaults: \(UserDefaults.standard.string(forKey: "LN")!)")
        return UserDefaults.standard.string(forKey: "LN")!
    }
    
    static func getJSONAccessData(field: String) -> String {
        let path: String = Bundle.main.path(forResource: "access", ofType: "json") as String!
        
        //let jsonData: NSData = NSData.dataWithContentsOfMappedFile(path as String) as! NSData
        let url = URL(fileURLWithPath: path)
        let jsonData: NSData = try! NSData(contentsOf: url, options: NSData.ReadingOptions.mappedRead)

        let json = JSON(jsonData) // Note: data: parameter name
        
        return json[field].stringValue
    }
    
    static func getServerURL(_ idPalabra: String) -> String {
        return getJSONAccessData(field: "url").replacingOccurrences(of: "XXX", with: idPalabra)
    }
    
    static func getPalabraIdFromJSON(palabra: String)-> (String, String) {
        let path: String = Bundle.main.path(forResource: "palabras", ofType: "json")!
        let url = URL(fileURLWithPath: path)
        let jsonData: NSData = try! NSData(contentsOf: url, options: NSData.ReadingOptions.mappedRead)
        let json = JSON(jsonData)["\(palabra.uppercased().characters.first!)"]
        //let json = JSON(jsonData)["\(palabra.uppercased().characters.first!)"][0].dictionaryValue
        
        for(_, item) in json {
            if palabra == item.dictionaryValue.values.first?.stringValue {
                return (item.dictionaryValue.keys.first!,palabra)
            }
        }
        
        return ("","")
    }
    
}
