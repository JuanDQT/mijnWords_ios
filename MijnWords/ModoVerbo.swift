//
//  ModoVerbo.swift
//  MijnWords
//
//  Created by Juan Daniel on 9/9/17.
//  Copyright © 2017 Juan Daniel. All rights reserved.
//

class ModoVerbo {
    
    var tiempo: String?
    var presente: [String]?
    var preteritoImperfecto: [String]?
    var preteritoIndefinido: [String]?
    var futuro: [String]?
    var condicional: [String]?
    var afirmativo: [String]?
    var negativo: [String]?
    var allTimes: [[String]]?
    
    init() {
        self.presente = []
        self.preteritoImperfecto = []
        self.preteritoIndefinido = []
        self.futuro = []
        self.condicional = []
        self.afirmativo = []
        self.negativo = []
        self.allTimes = []
    }
    
    func setPresente(modo: [String]) {
        self.presente = modo
        allTimes?.append(modo)
    }
    func setPreteritoImperfecto(modo: [String]) {
        self.preteritoImperfecto = modo
        allTimes?.append(modo)
    }
    func setPreteritoIndefinido(modo: [String]) {
        self.preteritoIndefinido = modo
        allTimes?.append(modo)
    }
    func setFuturo(modo: [String]) {
        self.futuro = modo
        allTimes?.append(modo)
    }
    func setCondicional(modo: [String]) {
        self.condicional = modo
        allTimes?.append(modo)
    }
    func setAfirmativo(modo: [String]) {
        self.afirmativo = modo
        allTimes?.append(modo)
    }
    func setNegativo(modo: [String]) {
        self.negativo = modo
        allTimes?.append(modo)
    }
    
}
