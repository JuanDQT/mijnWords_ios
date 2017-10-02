//
//  HomeController.swift
//  MijnWords
//
//  Created by Juan Daniel on 26/8/17.
//  Copyright © 2017 Juan Daniel. All rights reserved.
//

import UIKit
import RealmSwift

// Pass data between views: http://blog.xebia.com/understanding-the-sender-in-segues-and-use-it-to-pass-on-data-to-another-view-controller/
class DetailsController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // Views
    @IBOutlet weak var ccModos: UICollectionView!
    @IBOutlet weak var svEjemplos: UIStackView!
    @IBOutlet weak var svContent: UIScrollView!
    @IBOutlet weak var headerContent: UIView!
    @IBOutlet weak var lblBaseExample: UILabel!
    @IBOutlet weak var lblFocusExample: UILabel!
    @IBOutlet weak var ivBase: UIImageView!
    @IBOutlet weak var bbiSave: UIBarButtonItem!
    
    @IBOutlet weak var ivFocus: UIImageView!
    // Constraints
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    
    var palabra: Palabras?
    var palabraId: Int?
    var indexVerb = 0
    var palabraString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ccModos.delegate = self
        ccModos.dataSource = self
        self.navigationController?.navigationBar.topItem?.title = " "
        
        title = palabraString?.uppercased()
        ivFocus.image = UIImage(named: "\(Common.getFocusLanguage().lowercased())_lang.png")
        
        // Cargamos layouts
        //4 times
        for _ in 0..<palabra!.modos!.count {
            let nibView = UINib(nibName: "ModoView", bundle: nil)
            self.ccModos.register(nibView, forCellWithReuseIdentifier: "CC_MODO")
        }
        
        if let _ = palabra?.ejemplo {
            lblBaseExample.text = palabra!.ejemplo!.ejemploBase![indexVerb]
            lblFocusExample.text = palabra!.ejemplo!.ejemploFocus![indexVerb]
        } else {
            hideHeader()
        }
        
        let realm = try! Realm()
        
        if let _ = realm.objects(PalabraSearch.self).filter("id = %@", palabraId!).first {
            self.bbiSave.title = "Borrar"
        } else {
            self.bbiSave.title = "Guardar"
        }
        
    }
    
    @IBAction func touchRefresh(_ sender: Any) {
        
        self.indexVerb = self.indexVerb + 1 == self.palabra!.ejemplo!.ejemploBase!.count ? 0: self.indexVerb + 1
        
        self.lblBaseExample.text = self.palabra!.ejemplo!.ejemploBase![self.indexVerb]
        self.lblFocusExample.text = self.palabra!.ejemplo!.ejemploFocus![self.indexVerb]
        
    }
    
    // MARK: - overriding all UICollectionView methods
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CC_MODO", for: indexPath) as! ModoCell
        customCell.fillViews(palabra!.modos![indexPath.row])
        
        
        
        return customCell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ccModos.frame.width, height: ccModos.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
        //return palabra!.modos!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    // MARK: - Header examples functionality
    
    @IBAction func touchTitle(_ sender: Any) {
        
        let btn: UIButton = sender as! UIButton
        
        let areaBtn = btn.superview!
        // Recogemos el height de todas las views
        
        for item in areaBtn.constraints {
            
            if let x = item.identifier {
                
                if x == "expandable" {
                    
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
        headerHeightConstraint.constant = 0
        for view in headerContent.subviews {
            view.removeFromSuperview()
        }
    }
    
    @IBAction func guardarAction(_ sender: Any) {
        let realm = try! Realm()
        
        if let item = realm.objects(PalabraSearch.self).filter("id = %@", palabraId!).first {
            bbiSave.title = "Guardar"
            
            try! realm.write {
                realm.delete(item)
            }
        } else {
            bbiSave.title = "Borrar"
            try! realm.write {
                let itemToAdd: PalabraSearch = PalabraSearch()
                itemToAdd.id = palabraId!
                // TODO: revisar esto
                itemToAdd.languageCode = Common.getBaseLanguage()
                itemToAdd.name = palabraString
                realm.add(itemToAdd)
            }
        }
    }
    
}
