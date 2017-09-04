//
//  HomeController.swift
//  MijnWords
//
//  Created by Juan Daniel on 26/8/17.
//  Copyright © 2017 Juan Daniel. All rights reserved.
//

import UIKit

class DetailsController: UIViewController {

    var allEntries: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector( recibirPalabra(_:)), name: NSNotification.Name(rawValue:"PALABRA"), object: nil)
                // Do any additional setup after loading the view.
        
    }
    
    func recibirPalabra(_: NotificationCenter) {
        log.info("sape")
    }

}
