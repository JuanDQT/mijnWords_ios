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
    
    var allEntries: String!
    var palabra: Palabra?

    override func viewDidLoad() {
        super.viewDidLoad()
        ccModos.delegate = self
        ccModos.dataSource = self
        
        log.info("Me llego: \(palabra?.modoIndicativo?.futuro)")
    }
    
    func recibirPalabra(_: NotificationCenter) {
        log.info("sape")
    }
    
    // override
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CC_MODO", for: indexPath) as! ModoCollectionCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ccModos.frame.width, height: ccModos.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    
}