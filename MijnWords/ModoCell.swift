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
        
        titleModo.text = modo.title
        //maxHeightScrollable = (modo.persons!.count * defaultHeightScrollable)/2
        for (index, tiempoItem) in modo.allVerbs!.enumerated() {
            
            //log.error("Tiempo: \(tiempoItem.tiempo)")
            
            let viewRow = UIView()
            contentView.addSubview(viewRow)
            viewRow.backgroundColor = UIColor.init(rgb: 0x4253AF)

            viewRow.translatesAutoresizingMaskIntoConstraints = false
            let heightViewRow = viewRow.heightAnchor.constraint(equalToConstant: (index == 0) ? CGFloat(maxHeightScrollable) : CGFloat(defaultHeightScrollable))
            let widthViewRow = viewRow.widthAnchor.constraint(equalTo: self.contentView.widthAnchor)
            let topViewRow = viewRow.topAnchor.constraint(equalTo: contentView.subviews[index].bottomAnchor, constant: 2)
            
            // Creamos los Labels con los tiempos
            
            let lblTiempo = UILabel()
            viewRow.addSubview(lblTiempo)
            log.error("Tiempo: \(tiempoItem.tiempo)")
            lblTiempo.backgroundColor = UIColor.init(rgb: 0x4656A4)
            lblTiempo.textColor = UIColor.white
            lblTiempo.textAlignment = NSTextAlignment.center
            lblTiempo.translatesAutoresizingMaskIntoConstraints = false
            lblTiempo.text = tiempoItem.tiempo
            let tiempoHeightConstraint = lblTiempo.heightAnchor.constraint(equalToConstant: CGFloat(defaultHeightScrollable))
            let tiempoWidthConstraint = lblTiempo.widthAnchor.constraint(equalTo: viewRow.widthAnchor)
            let tiempoTopConstraint = lblTiempo.topAnchor.constraint(equalTo: viewRow.topAnchor)
            NSLayoutConstraint.activate([tiempoHeightConstraint, tiempoWidthConstraint, tiempoTopConstraint])
            
            // Creamos los StacksViews de los verbos
            for (k, articleItem) in modo.allVerbs![index].verbs!.enumerated() {
                //log.error("sape \(articleItem)")
                let stackView = UIStackView()

                viewRow.addSubview(stackView)
                stackView.translatesAutoresizingMaskIntoConstraints = false
                stackView.axis = UILayoutConstraintAxis.horizontal
                stackView.alignment = UIStackViewAlignment.fill
                stackView.distribution = UIStackViewDistribution.fillEqually
                stackView.backgroundColor = UIColor.purple
                //let stackViewLeftConstraint = stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor)
                
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
                
                //viewRow.sendSubview(toBack: stackView)
                NSLayoutConstraint.activate([stackViewRightContraint,stackViewLeftConstraint, stackViewRightContraint, stackViewHeightConstraint, stackViewTopConstraint])
            }
            
            // Constraints viewRow
            NSLayoutConstraint.activate([heightViewRow, widthViewRow, topViewRow])

        }
        
        log.info("Hijos: \(contentView.subviews.count)")
                
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
