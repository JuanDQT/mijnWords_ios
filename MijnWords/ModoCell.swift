//
//  ModoCollectionCell.swift
//  MijnWords
//
//  Created by Juan Daniel on 8/9/17.
//  Copyright © 2017 Juan Daniel. All rights reserved.
//

import UIKit

class ModoCell: UICollectionViewCell {
    
    func fillViews(_ modo: ModoVerbo) {
        
        let allViews: [UIView] = contentView.subviews.filter({$0 is UILabel == false})
        
        for (index, baseView) in allViews.enumerated() {
            
            let stacksViews = baseView.subviews.filter({$0 is UIStackView})
            
            for (indexStackView, stackView) in stacksViews.enumerated() {
                let label: UILabel = stackView.subviews[1] as! UILabel
                label.text = modo.allTimes![index][indexStackView]
            }
        }
    }
    
}
