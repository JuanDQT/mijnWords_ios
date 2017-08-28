//
//  API.swift
//  MijnWords
//
//  Created by Juan Daniel on 26/8/17.
//  Copyright © 2017 Juan Daniel. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class API {
    // MARK: Validations
    
    func checkCommonErrors(_ response: DataResponse<String>, json: inout JSON) -> Bool {
        
        if response.result.isFailure {
            log.error("[ServerAPI] ERROR: \(String(describing: response.request?.url)) : \(String(describing: response.result.error))")
            NotificationCenter.default.post(name: Notification.Name(rawValue: "COMM_ERROR"), object: nil, userInfo: ["err": "#net"])
            return false
        }
        
        if let statusCode = response.response?.statusCode {
            //ignoreCommErrors = false; // Return back original value
            if statusCode != 200 {
                // Only 200 is allowed
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "COMM_ERROR"), object: nil, userInfo: ["err": "+\(statusCode)"])
                return false
            }
            
            //json = self.checkValidJSON(response.result.value)
            
            return true
        }
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "COMM_ERROR"), object: nil, userInfo: ["err": "#nil"])
        
        return false
    }
}
