//
//  ModoCollectionCell.swift
//  MijnWords
//
//  Created by Juan Daniel on 8/9/17.
//  Copyright © 2017 Juan Daniel. All rights reserved.
//

import UIKit

class ModoCell: UICollectionViewCell {
    
    @IBOutlet weak var titleModo: UILabel!
    var maxHeightScrollable = 320
    let defaultHeightScrollable = 40
    
    func fillViews(_ modo: Modo) {
        
        log.error("Hola fill!")
        
        for item in contentView.subviews {
            if let _ = item as? UILabel {
                
            } else {
                item.removeFromSuperview()
            }
        }
        
        titleModo.text = modo.title
        maxHeightScrollable = (modo.persons!.count * defaultHeightScrollable)
        for (index, tiempoItem) in modo.allVerbs!.enumerated() {
            
            let viewRow = UIView()
            contentView.addSubview(viewRow)
            viewRow.backgroundColor = UIColor.init(rgb: 0x4253AF)

            viewRow.translatesAutoresizingMaskIntoConstraints = false
            let heightViewRow = viewRow.heightAnchor.constraint(equalToConstant: (index == 0) ? CGFloat(maxHeightScrollable) : CGFloat(defaultHeightScrollable))
            heightViewRow.identifier = "expandable"
            let widthViewRow = viewRow.widthAnchor.constraint(equalTo: self.contentView.widthAnchor)
            let topViewRow = viewRow.topAnchor.constraint(equalTo: contentView.subviews[index].bottomAnchor, constant: 2)
            
            // Creamos los Labels con los tiempos
            
            let btnTiempo = UIButton()
            btnTiempo.addTarget(self, action: "tapTiempoEvent:", for: .touchUpInside)
            
            viewRow.addSubview(btnTiempo)
            btnTiempo.backgroundColor = UIColor.init(rgb: 0x4656A4)
            btnTiempo.setTitleColor(UIColor.white, for: .normal)
            btnTiempo.translatesAutoresizingMaskIntoConstraints = false
            btnTiempo.setTitle(tiempoItem.tiempo, for: .normal)
            //lblTiempo.text = tiempoItem.tiempo
            let tiempoHeightConstraint = btnTiempo.heightAnchor.constraint(equalToConstant: CGFloat(defaultHeightScrollable))
            let tiempoWidthConstraint = btnTiempo.widthAnchor.constraint(equalTo: viewRow.widthAnchor)
            let tiempoTopConstraint = btnTiempo.topAnchor.constraint(equalTo: viewRow.topAnchor)
            NSLayoutConstraint.activate([tiempoHeightConstraint, tiempoWidthConstraint, tiempoTopConstraint])
            // Creamos los StacksViews de los verbos
            for (k, _) in modo.allVerbs![index].verbs!.enumerated() {
                //log.error("sape \(articleItem)")
                let stackView = UIStackView()

                viewRow.addSubview(stackView)
                stackView.translatesAutoresizingMaskIntoConstraints = false
                stackView.axis = UILayoutConstraintAxis.horizontal
                stackView.alignment = UIStackViewAlignment.fill
                stackView.distribution = UIStackViewDistribution.fillEqually
                stackView.backgroundColor = UIColor.purple
                
                let stackViewLeftConstraint = stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor)
                let stackViewRightContraint = stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
                let stackViewHeightConstraint = stackView.heightAnchor.constraint(equalToConstant: CGFloat(20))
                let stackViewTopConstraint = stackView.topAnchor.constraint(equalTo: viewRow.subviews[k].bottomAnchor, constant: 8)
                
                // Label Person
                let lblPerson = UILabel()
                lblPerson.text = modo.persons![k]
                lblPerson.textColor = UIColor.white
                stackView.addArrangedSubview(lblPerson)
                
                let lblVerb = UILabel()
                lblVerb.text = modo.allVerbs![index].verbs![k]
                lblVerb.textColor = UIColor.white
                stackView.addArrangedSubview(lblVerb)
                
                NSLayoutConstraint.activate([stackViewRightContraint,stackViewLeftConstraint, stackViewRightContraint, stackViewHeightConstraint, stackViewTopConstraint])
            }
            
            // Constraints viewRow
            NSLayoutConstraint.activate([heightViewRow, widthViewRow, topViewRow])

        }
        
    }
    
    func tapTiempoEvent(_ sender: Any) {
        let btnTiempo: UIButton = sender as! UIButton
        
        log.error("clicked loko")
        
        let areaBtn = btnTiempo.superview!
        // Recogemos el height de todas las views
        
        for item in areaBtn.constraints {
            
            if let x = item.identifier {
                
                if x == "expandable" {
                    log.error("lokita")
//                    if item.constant == 220 {
//                        item.constant = 40
//                    } else {
//                        item.constant = 220
//                    }
                    
                    if item.constant > CGFloat(defaultHeightScrollable) {
                        item.constant = CGFloat(defaultHeightScrollable)
                    } else {
                        item.constant = CGFloat(maxHeightScrollable)
                    }
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        self.contentView.layoutIfNeeded()
                    })            }
            }
            
        }
        
        var newScrollViewSize: Float = 0.0
        
        for item in areaBtn.superview!.subviews {
            if let _ = item as? UILabel {
            } else {
                newScrollViewSize += Float(item.frame.height)
                
            }
        }
        
        newScrollViewSize += Float(40 * 5)
        
//        svContent.contentSize = CGSize(width: svContent.frame.width, height: CGFloat(newScrollViewSize))
    }
    
    
    
//    func fillViews(_ modo: Modo) {
//        
//        let allViews: [UIView] = contentView.subviews.filter({$0 is UILabel == false})
//        
//        for (index, baseView) in allViews.enumerated() {
//            
//            
//            
//            let stacksViews = baseView.subviews.filter({$0 is UIStackView})
//            
//            for (indexStackView, stackView) in stacksViews.enumerated() {
//                let label: UILabel = stackView.subviews[1] as! UILabel
//                label.text = modo.allVerbs![index].verbs![indexStackView]
//                //label.text = modo.allTimes![index][indexStackView]
//                
//                
//            }
//        }
//    }
    
}
