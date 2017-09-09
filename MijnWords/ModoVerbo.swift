//
//  ModoVerbo.swift
//  MijnWords
//
//  Created by Juan Daniel on 9/9/17.
//  Copyright © 2017 Juan Daniel. All rights reserved.
//

class ModoVerbo {
    
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
    
}
