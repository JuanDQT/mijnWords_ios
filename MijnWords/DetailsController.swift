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
    
    var allEntries: [String] = ["juan", "sape", "lokita", "xdxd"]
    var palabra: Palabra?

    override func viewDidLoad() {
        super.viewDidLoad()
        ccModos.delegate = self
        ccModos.dataSource = self
        
        // Cargamos layouts
        let nibModoIndicativo: UINib = UINib(nibName: "ModoIndicativoView", bundle: nil)
        self.ccModos.register(nibModoIndicativo, forCellWithReuseIdentifier: "CC_MODO_INDICATIVO")
        let nibModoSubjuntivo: UINib = UINib(nibName: "ModoSubjuntivoView", bundle: nil)
        self.ccModos.register(nibModoSubjuntivo, forCellWithReuseIdentifier: "CC_MODO_SUBJUNTIVO")
    }
    
    // override
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        log.error("CELL ES: \(indexPath.row)")
        switch indexPath.row {
        case 0:
            return collectionView.dequeueReusableCell(withReuseIdentifier: "CC_MODO_INDICATIVO", for: indexPath) as! ModoIndicativoCell
        case 1:
            return collectionView.dequeueReusableCell(withReuseIdentifier: "CC_MODO_SUBJUNTIVO", for: indexPath) as! ModoSubjuntivoCell
            
        default:
            return UICollectionViewCell()
        }
        // OK
        //cell.titleModo.text = palabra?.allModos?[indexPath.row].tiempo
        // Cuantos tiempos tenemos en la palabra, debug
        ///cell.titleModo.text = "\(palabra?.allModos?[indexPath.row].allTimes?.count)"
        // Cuantos tiempos UIVIEW tenemos
        //cell.titleModo.text = "\(ccModos.subviews[0].subviews.count)"
        
        
        

        // Rellenar resto
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        
//        var tiemposView: [UIView] = []
//        for view in ccModos.subviews[0].subviews[0].subviews {
//            
//            if view.tag == 2 {
//                log.info("Una vista!")
//                tiemposView.append(view)
//            }
//        }
//        
//        self.ccModos.subviews[0].subviews[0].subviews.last?.removeFromSuperview()
//        
//        //tiemposView[0].backgroundColor = UIColor.red
//        
//        
//        
//        var limit = 4 - (palabra?.allModos?[indexPath.row].allTimes?.count)!
//        //tiemposView.removeLast(limit)
//        
//        for item in tiemposView{
//            item.backgroundColor = UIColor.brown
//            log.info("pintamos")
//            
//            //item.backgroundColor = UIColor.black
//        }
//        
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ccModos.frame.width, height: ccModos.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    
}
