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

    @IBOutlet weak var ccModos: UICollectionView!
    
    @IBOutlet weak var svContent: UIScrollView!
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
        
        log.info("tamano sv: \(svContent.contentSize)")
        
    }
    
    override func viewDidLayoutSubviews() {
        self.svContent.translatesAutoresizingMaskIntoConstraints = true
        svContent.contentSize = CGSize(width: svContent.frame.width, height: 100.0)
        
        
    }
    
    // override
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        log.error("CELL ES: \(indexPath.row)")
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
    
    // TODO: anadir scrollview dentro lde las vistas de cada archivo xib
    @IBAction func touchTitle(_ sender: Any) {
        
        let btn: UIButton = sender as! UIButton
        
        let areaBtn = btn.superview!
        // Recogemos el height de todas las views
        //log.error("total views(4?): \(areaBtn.superview?.subviews.count)")

        
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
        log.error("Tu height es: \(newScrollViewSize)")

        newScrollViewSize += Float(svContent.frame.height)
        
        svContent.contentSize = CGSize(width: svContent.frame.width, height: CGFloat(newScrollViewSize))

    }
    

}
