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
        
        if response.result.isFailure {
            //log.info("E: \(response.result.error?._code)")
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

        json = self.checkValidJSON(response.result.value)
        return true
    }
    
    func getResultados(id: String, palabra: String) {
        
        // Primera recoge web data
        NetworkManager.sharedIntance.manager.request(Common.getServerURL(id)).responseString {
            response in
                var json: JSON = [:]
                
                if self.checkCommonErrors(response, json: &json) {
                    //log.info("Continuamos y procesamos html")
                    //log.error(response.result.value!)
                    
                    var params: [String: String] = [:]
                    params["id"] = id
                    params["palabra"] = palabra
                    params["content"] = response.result.value!
                    params["lng_focus"] = Common.getFocusLanguage()
                    params["lng_base"] = "ES"
                    params["app_version"] = "2"

                    // Peticion al servidor, json model
                    NetworkManager.sharedIntance.manager.request(Common.getJSONAccessData(field: "host"), method: .post, parameters: params).responseString {
                        response in
                        
                        
                        var jsonResponse: JSON = [:]
                        
                        if self.checkCommonErrors(response, json: &jsonResponse) {
                            
                            log.error(jsonResponse["updated"].bool!)
                            
                            if !jsonResponse["updated"].bool! {
                                NotificationCenter.default.post(name: Notification.Name(rawValue: "UPDATE"), object: nil, userInfo: nil)
                                return
                            }
                            
                            var palabra: Palabra = Palabra()
                            self.getData(json: jsonResponse, palabra: &palabra)
                            
                            NotificationCenter.default.post(name: Notification.Name(rawValue: "PALABRA"), object: nil, userInfo: ["data": palabra])
                        }

                    }
                }
        }
        
    }
    
    func getData(json: JSON, palabra: inout Palabra) {
        
        // Get ejemplos
        if let _ = json["ejemplo"]["base"].array {
            // Hay ejemplos
            
            for index in 0..<json["ejemplo"]["base"].array!.count {
                palabra.ejemplo?.ejemploBase?.append(json["ejemplo"]["base"][index].stringValue)
                palabra.ejemplo?.ejemploFocus?.append(json["ejemplo"]["focus"][index].stringValue)
            }
            
        } else {
            palabra.ejemplo = nil // Es necesario?
            log.error("No hay ejemplos")
        }
        
        /// Modo Indicativo
        
        for index in json["modo_indicativo"]["presente"].arrayValue {
            palabra.modoIndicativo?.presente?.append(index.stringValue)
        }
        for index in json["modo_indicativo"]["preterito_imperfecto"].arrayValue {
            palabra.modoIndicativo?.preteritoImperfecto?.append(index.stringValue)
        }
        for index in json["modo_indicativo"]["preterito_indefinido"].arrayValue {
            palabra.modoIndicativo?.preteritoIndefinido?.append(index.stringValue)
        }
        for index in json["modo_indicativo"]["futuro"].arrayValue {
            palabra.modoIndicativo?.futuro?.append(index.stringValue)
        }
        
        /// Modo Subjuntivo
        
        for index in json["modo_subjuntivo"]["presente"].arrayValue {
            palabra.modoSubjuntivo?.presente?.append(index.stringValue)
        }
        for index in json["modo_subjuntivo"]["preterito_imperfecto"].arrayValue {
            palabra.modoSubjuntivo?.preteritoImperfecto?.append(index.stringValue)
        }
        for index in json["modo_indicativo"]["futuro"].arrayValue {
            palabra.modoSubjuntivo?.futuro?.append(index.stringValue)
        }
        
        /// Modo Condicional
        
        for index in json["modo_condicional"]["condicional"].arrayValue {
            palabra.modoCondicional?.condicional?.append(index.stringValue)
        }
        
        /// Modo Imperativo
        for index in json["modo_imperativo"]["afirmativo"].arrayValue {
            palabra.modoImperativo?.afirmativo?.append(index.stringValue)
        }
        for index in json["modo_imperativo"]["negativo"].arrayValue {
            palabra.modoImperativo?.negativo?.append(index.stringValue)
        }

    }
}
