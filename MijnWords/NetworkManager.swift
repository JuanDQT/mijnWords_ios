//
//  NetworkManager.swift
//  MijnWords
//
//  Created by Juan Daniel on 1/9/17.
//  Copyright © 2017 Juan Daniel. All rights reserved.
//

import Foundation
import Alamofire

// Multiple instance: https://github.com/Alamofire/Alamofire/issues/1562#issuecomment-247960099
class NetworkManager {
    
    var manager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 5
        configuration.timeoutIntervalForRequest = 5
        
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    static let sharedIntance = NetworkManager()
}
