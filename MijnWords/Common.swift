//
//  Common.swift
//  MijnWords
//
//  Created by Juan Daniel on 26/8/17.
//  Copyright © 2017 Juan Daniel. All rights reserved.
//
import UIKit

class Common {
    
    static let allLanguages:[String] = [String](arrayLiteral: "EN", "NL")
    
    static func getSystemLanguage() -> String {
        
        
        if (UserDefaults.standard.string(forKey: "LN")) == nil {
            log.error("Language UserDefaults: default(EN)")
            return "EN"
        }
        
        log.info("Language UserDefaults: \(UserDefaults.standard.string(forKey: "LN")!)")
        return UserDefaults.standard.string(forKey: "LN")!
    }
}
