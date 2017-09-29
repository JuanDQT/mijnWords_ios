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
            //log.error("[ServerAPI] ERROR: \(String(describing: response.request?.url)) : \(String(describing: response.result.error))")
            var mapErros: [String: Any] = [:]
            
            // No tienes internet
            if response.result.error?._code == NSURLErrorNotConnectedToInternet {
                mapErros["title"] = NSLocalizedString("NO_INTERNET_TITLE", comment: "NO_INTERNET_TITLE")
                mapErros["description"] = NSLocalizedString("NO_INTERNET_DESCRIPTION", comment: "NO_INTERNET_DESCRIPTION")
                mapErros["btnDescription"] = NSLocalizedString("NO_INTERNET_BUTTON", comment: "TRY_AGAIN")
                mapErros["image"] = UIImage(named: "no_network.png")
            }
            
            // El servidor esta off
            if response.result.error?._code == NSURLErrorCannotConnectToHost {
                mapErros["title"] = NSLocalizedString("SERVER_NO_RESPONSE_TITLE", comment: "SERVER_NO_RESPONSE_TITLE")
                mapErros["description"] = NSLocalizedString("SERVER_NO_RESPONSE_DESCRIPTION", comment: "SERVER_NO_RESPONSE_DESCRIPTION")
                mapErros["btnDescription"] = NSLocalizedString("SERVER_NO_RESPONSE_BUTTON", comment: "TRY_AGAIN")
                mapErros["image"] = UIImage(named: "server_error.png")
            }
            
            // Tiempo de espera
            if response.result.error?._code == NSURLErrorTimedOut {
                mapErros["title"] = NSLocalizedString("SLOW_INTERNET_CONNECTION_TITLE", comment: "SLOW_INTERNET_CONNECTION_TITLE")
                mapErros["description"] = NSLocalizedString("SLOW_INTERNET_CONNECTION_DESCRIPTION", comment: "SLOW_INTERNET_CONNECTION_DESCRIPTION")
                mapErros["btnDescription"] = NSLocalizedString("SLOW_INTERNET_CONNECTION_BUTTON", comment: "TRY_AGAIN")
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
        params["lng_base"] = "ES"
        params["app_version"] = "1"

        // Peticion al servidor, json model
        NetworkManager.sharedIntance.manager.request(Common.getJSONAccessData(field: "host"), method: .post, parameters: params).responseString {
            response in
            
            var jsonResponse: JSON = [:]
            
            log.error(response)
            
            if self.checkCommonErrors(response, json: &jsonResponse) {
                
                log.error(jsonResponse["updated"].bool!)
                
                if !jsonResponse["updated"].bool! {
                    log.error("Decimos de upd")
                    var mapUpdate: [String: Any] = [:]
                
                    mapUpdate["title"] = NSLocalizedString("UPDATE_AVAILABLE_TITLE", comment: "UPDATE_AVAILABLE_TITLE")
                    mapUpdate["description"] = NSLocalizedString("UPDATE_AVAILABLE_DESCRIPTION", comment: "UPDATE_AVAILABLE_DESCRIPTION")
                    mapUpdate["btnDescription"] = NSLocalizedString("UPDATE_AVAILABLE_BUTTON", comment: "UPDATE_AVAILABLE_BUTTON")
                    mapUpdate["image"] = UIImage(named: "update_app.png")
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "UPDATE"), object: nil, userInfo: mapUpdate)
                    return
                }
                                
                var palabra: Palabra = Palabra()
                self.getData(json: jsonResponse, palabra: &palabra)
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "PALABRA"), object: nil, userInfo: ["data": palabra, "palabraId": Int(id)])
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
        palabra.modoIndicativo?.tiempo = "Modo indicativo"
        var list: [String] = []
        for index in json["modo_indicativo"]["presente"].arrayValue {
            list.append(index.stringValue)
        }
        palabra.modoIndicativo?.setPresente(modo: list)
        list.removeAll()
        for index in json["modo_indicativo"]["preterito_imperfecto"].arrayValue {
            list.append(index.stringValue)
        }
        palabra.modoIndicativo?.setPreteritoImperfecto(modo: list)
        list.removeAll()
        for index in json["modo_indicativo"]["preterito_indefinido"].arrayValue {
            list.append(index.stringValue)
        }
        palabra.modoIndicativo?.setPreteritoIndefinido(modo: list)
        list.removeAll()
        for index in json["modo_indicativo"]["futuro"].arrayValue {
            list.append(index.stringValue)
        }
        palabra.modoIndicativo?.setFuturo(modo: list)
        list.removeAll()
        /// Modo Subjuntivo
        palabra.modoSubjuntivo?.tiempo = "Modo Subjuntivo"
        for index in json["modo_subjuntivo"]["presente"].arrayValue {
            list.append(index.stringValue)
        }
        palabra.modoSubjuntivo?.setPresente(modo: list)
        list.removeAll()
        for index in json["modo_subjuntivo"]["preterito_imperfecto"].arrayValue {
            list.append(index.stringValue)
        }
        palabra.modoSubjuntivo?.setPreteritoImperfecto(modo: list)
        list.removeAll()
        for index in json["modo_subjuntivo"]["futuro"].arrayValue {
            list.append(index.stringValue)
        }
        palabra.modoSubjuntivo?.setFuturo(modo: list)
        list.removeAll()
        /// Modo Condicional
        palabra.modoCondicional?.tiempo = "Modo condicional"
        for index in json["modo_condicional"]["condicional"].arrayValue {
            list.append(index.stringValue)
        }
        palabra.modoCondicional?.setCondicional(modo: list)
        list.removeAll()
        /// Modo Imperativo
        palabra.modoImperativo?.tiempo = "Modo imperativo"
        for index in json["modo_imperativo"]["afirmativo"].arrayValue {
            list.append(index.stringValue)
        }
        palabra.modoImperativo?.setAfirmativo(modo: list)
        list.removeAll()
        for index in json["modo_imperativo"]["negativo"].arrayValue {
            list.append(index.stringValue)
        }
        palabra.modoImperativo?.setNegativo(modo: list)
    }
}
