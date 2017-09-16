//
//  HomeController.swift
//  MijnWords
//
//  Created by Juan Daniel on 26/8/17.
//  Copyright © 2017 Juan Daniel. All rights reserved.
//

import UIKit

// Pass data between views: http://blog.xebia.com/understanding-the-sender-in-segues-and-use-it-to-pass-on-data-to-another-view-controller/
class DetailsController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // Views
    @IBOutlet weak var ccModos: UICollectionView!
    @IBOutlet weak var ibToggle: UIButton!
    @IBOutlet weak var ibRefresh: UIButton!
    @IBOutlet weak var svEjemplos: UIStackView!
    @IBOutlet weak var svContent: UIScrollView!
    
    // Constraints
    @IBOutlet weak var ibRefreshHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var ibToggleHeightRefreshConstraint: NSLayoutConstraint!
    @IBOutlet weak var svEjemplosHeightConstraint: NSLayoutConstraint!
    
    var allEntries: [String] = ["juan", "sape", "lokita", "xdxd"]
    var palabra: Palabra?
    //let defaultSizeScrollContent = 340

    override func viewDidLoad() {
        super.viewDidLoad()
        ccModos.delegate = self
        ccModos.dataSource = self
                
        // Cargamos layouts
        let nibModoIndicativo: UINib = UINib(nibName: "ModoIndicativoView", bundle: nil)
        self.ccModos.register(nibModoIndicativo, forCellWithReuseIdentifier: "CC_MODO_INDICATIVO")
        
        let nibModoSubjuntivo: UINib = UINib(nibName: "ModoSubjuntivoView", bundle: nil)
        self.ccModos.register(nibModoSubjuntivo, forCellWithReuseIdentifier: "CC_MODO_SUBJUNTIVO")

        log.info("Ejemplos: \(palabra!.ejemplo?.ejemploBase?.count)")
        
        if let _ = palabra?.ejemplo {
            
        } else {
            //hideHeader()
        }
        hideHeader()

    }
    
    // override
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        var customCell: UICollectionViewCell?
        switch indexPath.row {
        case 0:
            customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CC_MODO_INDICATIVO", for: indexPath) as! ModoIndicativoCell
        case 1:
            customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CC_MODO_SUBJUNTIVO", for: indexPath) as! ModoSubjuntivoCell
            
        default:
            customCell = UICollectionViewCell()
        }
        
//        customCell!.btnPresente.addTarget(self, action: Selector("action"), forControlEvents: UIControlEvents.TouchUpInside)
//        
        return customCell!
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ccModos.frame.width, height: ccModos.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    @IBAction func touchTitle(_ sender: Any) {

        let btn: UIButton = sender as! UIButton
        
        let areaBtn = btn.superview!
        // Recogemos el height de todas las views
        
        for item in areaBtn.constraints {
            
            if let x = item.identifier {
                
                if x == "expandable" {
                    log.error("TAGG: \(x)")
                    
                    if item.constant == 220 {
                        item.constant = 40
                    } else {
                        item.constant = 220
                    }
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        self.view.layoutIfNeeded()
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
        
        svContent.contentSize = CGSize(width: svContent.frame.width, height: CGFloat(newScrollViewSize))

    }
    
    func hideHeader() {
        ibToggleHeightRefreshConstraint.constant = 0
        ibRefreshHeightConstraint.constant = 0
        svEjemplosHeightConstraint.constant = 0
//

    }
    
    @IBAction func refreshAction(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.ibRefresh.transform = self.ibRefresh.transform.rotated(by: -180.0)
        })
    }
}
