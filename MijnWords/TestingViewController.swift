//
//  TestingViewController.swift
//  MijnWords
//
//  Created by Juan Daniel on 6/9/17.
//  Copyright © 2017 Juan Daniel. All rights reserved.
//

import UIKit

class TestingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var ccPaginas: UICollectionView!
    
    var colores: [UIColor] = [UIColor.red, UIColor.black, UIColor.blue, UIColor.purple, UIColor.brown]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ccPaginas.delegate = self
        ccPaginas.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let ccItem = collectionView.dequeueReusableCell(withReuseIdentifier: "CC_CELL", for: indexPath)
        ccItem.backgroundColor = colores[indexPath.row]
        return ccItem
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: ccPaginas.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}
