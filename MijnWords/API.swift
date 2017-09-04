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
            log.info("E: \(response.result.error?._code)")
                        log.error("[ServerAPI] ERROR: \(String(describing: response.request?.url)) : \(String(describing: response.result.error))")
            var mapErros: [String: Any] = [:]
            
            // No tienes internet
            if response.result.error?._code == NSURLErrorNotConnectedToInternet {
                mapErros["title"] = "No hay conexión a internet"
                mapErros["image"] = UIImage(named: "no_network.png")
            }
            
            // El servidor esta off
            if response.result.error?._code == NSURLErrorCannotConnectToHost {
                mapErros["title"] = "El servidor no responde"
                mapErros["image"] = UIImage(named: "server_error.png")
            }
            
            // Tiempo de espera
            if response.result.error?._code == NSURLErrorTimedOut {
                mapErros["title"] = "Conexión a internet demasiado lenta"
                mapErros["image"] = UIImage(named: "slow_internet.png")
            }
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "ERROR_NETWORK"), object: nil, userInfo: mapErros)
            return false
        }

        //json = self.checkValidJSON(response.result.value)
        return true
    }
    
    func getResultados(id: String, palabra: String) {
        
        NetworkManager.sharedIntance.manager.request(Common.getServerURL(id)).responseString {
            response in
                var json: JSON = [:]
                
                if self.checkCommonErrors(response, json: &json) {
                    log.info("Continuamos y procesamos html")
                    log.error(response.result.value!)
                    
                    var params: [String: String] = [:]
                    params["id"] = id
                    params["palabra"] = palabra
                    params["content"] = response.result.value!
                    params["lng_focus"] = Common.getFocusLanguage()
                    params["lng_base"] = "ES"
                    params["app_version"] = "1"

                    // Peticion al servidor
                    NetworkManager.sharedIntance.manager.request(Common.getJSONAccessData(field: "host"), method: .post, parameters: params).responseString {
                        response in
                        log.error(response)
                    }
                    
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "PALABRA"), object: nil, userInfo: nil)
                }
            
            
        }
        
    }
}
