//
//  ModoCollectionCell.swift
//  MijnWords
//
//  Created by Juan Daniel on 8/9/17.
//  Copyright © 2017 Juan Daniel. All rights reserved.
//

import UIKit
import AVFoundation

class ModoCell: UICollectionViewCell {
    
    @IBOutlet weak var titleModo: UILabel!
    var maxHeightScrollable = 0
    let defaultHeightMode = 40
    let defaultStackViewHeight = 20
    let marginTopBetweenVerbs = 8
    
    func fillViews(_ modo: Modo) {
        
        for item in contentView.subviews {
            if let _ = item as? UILabel {
                
            } else {
                item.removeFromSuperview()
            }
        }
        
        titleModo.text = modo.title
        maxHeightScrollable = defaultHeightMode + (modo.persons!.count * defaultStackViewHeight) + (modo.persons!.count * marginTopBetweenVerbs) + defaultStackViewHeight
        for (index, tiempoItem) in modo.allVerbs!.enumerated() {
            
            let viewRow = UIView()
            contentView.addSubview(viewRow)
            viewRow.backgroundColor = UIColor.init(rgb: 0x4253AF)

            viewRow.translatesAutoresizingMaskIntoConstraints = false
            let heightViewRow = viewRow.heightAnchor.constraint(equalToConstant: (index == 0) ? CGFloat(maxHeightScrollable) : CGFloat(defaultHeightMode))
            heightViewRow.identifier = "expandable"
            let widthViewRow = viewRow.widthAnchor.constraint(equalTo: self.contentView.widthAnchor)
            let topViewRow = viewRow.topAnchor.constraint(equalTo: contentView.subviews[index].bottomAnchor, constant: 2)
            
            // Creamos los Labels con los tiempos
            
            let btnTiempo = UIButton()
            btnTiempo.addTarget(self, action: #selector(tapTiempoEvent(_:)), for: .touchUpInside)
            
            viewRow.addSubview(btnTiempo)
            btnTiempo.backgroundColor = UIColor.init(rgb: 0x4656A4)
            btnTiempo.setTitleColor(UIColor.white, for: .normal)
            btnTiempo.translatesAutoresizingMaskIntoConstraints = false
            btnTiempo.setTitle(tiempoItem.tiempo, for: .normal)
            //lblTiempo.text = tiempoItem.tiempo
            let tiempoHeightConstraint = btnTiempo.heightAnchor.constraint(equalToConstant: CGFloat(defaultHeightMode))
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
                let stackViewHeightConstraint = stackView.heightAnchor.constraint(equalToConstant: CGFloat(defaultStackViewHeight))
                let stackViewTopConstraint = stackView.topAnchor.constraint(equalTo: viewRow.subviews[k].bottomAnchor, constant: CGFloat(marginTopBetweenVerbs))
                
                // Label Person
                let lblPerson = UILabel()
                lblPerson.text = modo.persons![k]
                lblPerson.textColor = UIColor.white
                stackView.addArrangedSubview(lblPerson)
                
                let btnVerb = UIButton()
                btnVerb.setTitle(modo.allVerbs![index].verbs![k], for: .normal)
                btnVerb.setTitleColor(UIColor.white, for: .normal)
                btnVerb.contentHorizontalAlignment = .left
                btnVerb.addTarget(self, action: #selector(tapVerb(_:)), for: .touchUpInside)
                
                stackView.addArrangedSubview(btnVerb)
                
                NSLayoutConstraint.activate([stackViewRightContraint,stackViewLeftConstraint, stackViewRightContraint, stackViewHeightConstraint, stackViewTopConstraint])
            }
            
            // Constraints viewRow
            NSLayoutConstraint.activate([heightViewRow, widthViewRow, topViewRow])

        }
        
    }
    
    func tapTiempoEvent(_ sender: Any) {
        let btnTiempo: UIButton = sender as! UIButton
        
        let areaBtn = btnTiempo.superview!
        // Recogemos el height de todas las views
        
        for item in areaBtn.constraints {
            
            if let x = item.identifier {
                
                if x == "expandable" {
                    
                    if item.constant > CGFloat(defaultHeightMode) {
                        item.constant = CGFloat(defaultHeightMode)
                    } else {
                        item.constant = CGFloat(maxHeightScrollable)
                    }
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        self.contentView.layoutIfNeeded()
                    })            }
            }
            
        }
    }

    func tapVerb(_ sender: Any) {
        
        let btnVerb = sender as! UIButton
        
        let lngCodeIOS = AVSpeechSynthesisVoice.speechVoices().filter({$0.language.components(separatedBy: "-")[0] == Common.getBaseLanguage().lowercased()}).first
        
        if let _ = lngCodeIOS {
            let speechSynthesizer = AVSpeechSynthesizer()
            let speechUtterance = AVSpeechUtterance(string: btnVerb.titleLabel!.text!)
            speechUtterance.voice = AVSpeechSynthesisVoice(language: lngCodeIOS?.language)
            speechSynthesizer.speak(speechUtterance)
        } else {
            // No existe esa voz para ese dispositivo
        }
    }
    
    // let allViews: [UIView] = contentView.subviews.filter({$0 is UILabel == false})

    
}
