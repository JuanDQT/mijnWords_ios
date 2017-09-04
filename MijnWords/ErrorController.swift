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
    
    var imageError: UIImage?
    var titleError: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        log.info("me pasaste: \(titleError!)")
        lblTitle.text = titleError!
        ivError.image = imageError
        // Do any additional setup after loading the view.
    }

    @IBAction func tryAgain(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
