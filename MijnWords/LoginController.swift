//
//  ViewController.swift
//  MijnWords
//
//  Created by Juan Daniel on 26/8/17.
//  Copyright © 2017 Juan Daniel. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var ivFocusLanguage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginAction(_ sender: Any) {
        performSegue(withIdentifier: "SG_Home", sender: nil)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ivFocusLanguage.image = UIImage(named: "\(Common.getSystemLanguage())_lang.png")
    }

    @IBAction func openConfig(_ sender: Any) {
        let configController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CONFIG_CONTROLLER") as! UINavigationController
        self.present(configController, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

