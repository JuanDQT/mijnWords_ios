//
//  Palabra.swift
//  MijnWords
//
//  Created by Juan Daniel on 9/9/17.
//  Copyright © 2017 Juan Daniel. All rights reserved.
//

class Palabra {
    
    var ejemplo: Ejemplo?
    
    var modoIndicativo: ModoVerbo?
    var modoSubjuntivo: ModoVerbo?
    var modoCondicional: ModoVerbo?
    var modoImperativo: ModoVerbo?
    
    init() {
        self.ejemplo = Ejemplo()
        self.modoIndicativo = ModoVerbo()
        self.modoSubjuntivo = ModoVerbo()
        self.modoCondicional = ModoVerbo()
        self.modoImperativo = ModoVerbo()
    }
}
