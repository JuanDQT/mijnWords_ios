//
//  ErrorController.swift
//  MijnWords
//
//  Created by Juan Daniel on 31/8/17.
//  Copyright © 2017 Juan Daniel. All rights reserved.
//

import UIKit

class ErrorController: UIViewController {

    @IBOutlet weak var ivError: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnError: UIButton!
    @IBOutlet weak var lblDescription: UILabel!
    
    var imageError: UIImage?
    var titleError: String?
    var descriptionError: String?
    var btnErrorDescription: String?
    var goUpdate: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()

        lblTitle.text = titleError!
        ivError.image = imageError!
        lblDescription.text = descriptionError!
        btnError.titleLabel?.text = btnErrorDescription!
        // Do any additional setup after loading the view.
    }

    @IBAction func tryAgain(_ sender: Any) {
        
        if let _ = goUpdate {
            
            guard let appStoreAppID = URL(string: "itms-apps://itunes.apple.com/app/bars/id706081574") else {
                return //be safe
            }

            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appStoreAppID, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(appStoreAppID)
            }
            
        } else {
            dismiss(animated: true, completion: nil)    
        }
        
    }
}
