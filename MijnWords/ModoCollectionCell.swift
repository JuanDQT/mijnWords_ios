//
//  ModoCollectionCell.swift
//  MijnWords
//
//  Created by Juan Daniel on 8/9/17.
//  Copyright © 2017 Juan Daniel. All rights reserved.
//

import UIKit

class ModoCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var vPresente: UIView!
    
    @IBAction func touchTiempo(_ sender: Any) {
        
        let btn: UIButton = sender as! UIButton
        
        let areaBtn = btn.superview
        log.info("Presionado el: \(btn.tag)")
        
        for item in areaBtn!.constraints {
            
            if let x = item.identifier {
                
                if x == "expandable" {
                    log.error("TAGG: \(x)")
                    
                    
                    if item.constant == 220 {
                        item.constant = 40
                    } else {
                        item.constant = 220
                    }
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        self.layoutIfNeeded()
                    })            }
            }
            
        }
        
    }
    
}
