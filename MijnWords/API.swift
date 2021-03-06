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
    
    func checkValidJSON(_ request: String?) -> JSON {
        if let data = request {
            if let dataFromString = data.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                let json = JSON(data: dataFromString)
                return json
            }
        }
        
        // Return empty JSON if any error
        return JSON([:])
    }
    
    func checkCommonErrors(_ response: DataResponse<String>, json: inout JSON) -> Bool {
//        
        if response.result.isFailure {
            //log.error("[ServerAPI] ERROR: \(String(describing: response.request?.url)) : \(String(describing: response.result.error))")
            var mapErros: [String: Any] = [:]
            
            // No tienes internet
            if response.result.error?._code == NSURLErrorNotConnectedToInternet {
                mapErros["title"] = "NO_INTERNET_TITLE".localized()
                mapErros["description"] = "NO_INTERNET_DESCRIPTION".localized()
                mapErros["btnDescription"] = "NO_INTERNET_BUTTON".localized()
                mapErros["image"] = UIImage(named: "no_network.png")
            }
            
            // El servidor esta off
            if response.result.error?._code == NSURLErrorCannotConnectToHost {
                mapErros["title"] = "SERVER_NO_RESPONSE_TITLE".localized()
                mapErros["description"] = "SERVER_NO_RESPONSE_DESCRIPTION".localized()
                mapErros["btnDescription"] = "SERVER_NO_RESPONSE_BUTTON".localized()
                mapErros["image"] = UIImage(named: "server_error.png")
            }
            
            // Tiempo de espera
            if response.result.error?._code == NSURLErrorTimedOut {
                mapErros["title"] = "SLOW_INTERNET_CONNECTION_TITLE".localized()
                mapErros["description"] = "SLOW_INTERNET_CONNECTION_DESCRIPTION".localized()
                mapErros["btnDescription"] = "SLOW_INTERNET_CONNECTION_BUTTON".localized()
                mapErros["image"] = UIImage(named: "slow_internet.png")
            }
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "ERROR_NETWORK"), object: nil, userInfo: mapErros)
            return false
        }
        
        json = self.checkValidJSON(response.result.value)
        return true
    }
    
    func getResultados(id: String, palabra: String) {


        var params: [String: String] = [:]
        params["id"] = id
        params["palabra"] = palabra
        params["lng_focus"] = Common.getFocusLanguage()
        params["lng_base"] = Common.getBaseLanguage()
        params["app_version"] = "3"

        // Peticion al servidor, json model
        NetworkManager.sharedIntance.manager.request(Common.getJSONAccessData(field: "host"), method: .post, parameters: params).responseString {
            response in
            
            var jsonResponse: JSON = [:]
                        
            if self.checkCommonErrors(response, json: &jsonResponse) {
                
                log.error(jsonResponse["updated"].bool!)
                
                if !jsonResponse["updated"].bool! {
                    log.error("Decimos de upd")
                    var mapUpdate: [String: Any] = [:]
                
                    mapUpdate["title"] = "UPDATE_AVAILABLE_TITLE".localized()
                    mapUpdate["description"] = "UPDATE_AVAILABLE_DESCRIPTION".localized()
                    mapUpdate["btnDescription"] = "UPDATE_AVAILABLE_BUTTON".localized()
                    mapUpdate["image"] = UIImage(named: "update_app.png")
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "UPDATE"), object: nil, userInfo: mapUpdate)
                    return
                }
                                
                var palabra: Palabras = Palabras()
                self.getData(json: jsonResponse, palabra: &palabra)
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "PALABRA"), object: nil, userInfo: ["data": palabra, "palabraId": Int(id)!])
            }
            
        }
        
        
        
    }
    
    func getData(json: JSON, palabra: inout Palabras) {
        
        // Get ejemplos
        if let _ = json["ejemplo"]["base"].array {
            // Hay ejemplos
            //log.error("tenemossss: \(json["ejemplo"]["base"].array!.count)")
            let ejemplo: Ejemplo = Ejemplo()
            for index in 0..<json["ejemplo"]["base"].array!.count {
                ejemplo.ejemploBase?.append(json["ejemplo"]["base"][index].stringValue)
                ejemplo.ejemploFocus?.append(json["ejemplo"]["focus"][index].stringValue)
            }
            palabra.ejemplo = ejemplo
            
        } else {
            palabra.ejemplo = nil // Es necesario?
            log.error("No hay ejemplos")
        }
        
        let jsonModos = json["modos"].arrayValue
        
        for modoJSON in jsonModos {
            
            let modo = Modo()
            
            let verbContainer = modoJSON["verbs"].arrayValue
            let title = modoJSON["title"].stringValue
            let times = modoJSON["times"].stringValue.components(separatedBy: ",")
            let persons = modoJSON["persons"].stringValue.components(separatedBy: ",")
            
            modo.title = title
            modo.persons = persons
            
            for (index, verbsJSON) in verbContainer.enumerated() {
                let verbo = Verbo()
                verbo.tiempo = times[index]
                
                for verbJSON in verbsJSON {
                    verbo.verbs?.append(verbJSON.1.stringValue)
                }
                
                modo.allVerbs?.append(verbo)
            }
            palabra.modos?.append(modo)
        }
    }
}
