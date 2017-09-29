//
//  ViewController.swift
//  MijnWords
//
//  Created by Juan Daniel on 26/8/17.
//  Copyright © 2017 Juan Daniel. All rights reserved.
//

import UIKit

class HomeController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var ivFocusLanguage: UIImageView!
    @IBOutlet weak var tfInput: UITextField!
    @IBOutlet weak var btnError: UIButton!
    
    var btnEnabled: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        tfInput.delegate = self
        tfInput.inputAccessoryView = UIView()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationErrorNetwork(_:)), name: Notification.Name(rawValue: "ERROR_NETWORK"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notificationSuccess(_:)), name: Notification.Name(rawValue: "PALABRA"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notificationUpdate(_:)), name: Notification.Name(rawValue: "UPDATE"), object: nil)
    }

    @IBAction func loginAction(_ sender: Any) {
        
        if (tfInput.text?.trimmingCharacters(in: .whitespacesAndNewlines).characters.count)! > 0 {
            
            let palabra = Common.getPalabraIdFromJSON(palabra: tfInput.text!.lowercased())
            if palabra.0.isEmpty {
                //log.info(NSLocalizedString("NO_WORD_EXIST", comment: "NO_WORD_EXIST"))
            } else {
                toggleStatusButton()
                API().getResultados(id: palabra.0, palabra: palabra.1)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "MijnWords"
        ivFocusLanguage.image = UIImage(named: "\(Common.getFocusLanguage().lowercased())_lang.png")
    }

    @IBAction func openConfig(_ sender: Any) {
        let configController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CONFIG_CONTROLLER") as! UINavigationController
        self.present(configController, animated: true)
    }
    
    // MARK - : OBSERVERS, network
    
    func notificationErrorNetwork(_ notification: Notification) {
        var extras: [String: Any] = notification.userInfo as! [String: Any]
        toggleStatusButton()
        let errorView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ERROR_CONTROLLER") as! ErrorController
        errorView.titleError = extras["title"] as? String
        errorView.descriptionError = extras["description"] as? String
        errorView.btnErrorDescription = extras["btnDescription"] as? String
        errorView.imageError = extras["image"] as? UIImage
        self.present(errorView, animated: true, completion: nil)
    }
    
    func notificationUpdate(_ notification: Notification) {
        var extras: [String: Any] = notification.userInfo as! [String: Any]
        toggleStatusButton()
        let errorView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ERROR_CONTROLLER") as! ErrorController
        errorView.titleError = extras["title"] as? String
        errorView.descriptionError = extras["description"] as? String
        errorView.btnErrorDescription = extras["btnDescription"] as? String
        errorView.imageError = extras["image"] as? UIImage
        errorView.goUpdate = true
        self.present(errorView, animated: true, completion: nil)
    }
    
    func notificationSuccess(_ notification: Notification) {
        toggleStatusButton()
        
        let result: [String: Any] = (notification.userInfo as? [String: Any])!
        self.performSegue(withIdentifier: "DETAILS_CONTROLLER", sender: result)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DETAILS_CONTROLLER" {
            
            if let afterSegue: DetailsController = segue.destination as? DetailsController {
                let result = sender as! [String: Any]
                afterSegue.palabra = result["data"] as? Palabra
                afterSegue.palabraString = self.tfInput.text
                afterSegue.palabraId = result["palabraId"] as? Int
                tfInput.text = ""
            }
        }
        if segue.identifier == "HISTORIC_CONTROLLER" {
            let view = segue.destination as? HistoricController
            
            view?.wordSelected = {
                response in
                self.tfInput.text = response
                self.loginAction(self)
            }
        }
        
    }
    
    // MARK - : OTHERS
    
    func toggleStatusButton() {
        btnEnabled = !btnEnabled
        
        if !btnEnabled {
            btnError.isEnabled = false
        } else {
            btnError.isEnabled = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        loginAction(self)
        return true
    }

    @IBAction func creditsAction(_ sender: Any) {
        let viewCredits: CreditsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CREDITS_CONTROLLER") as! CreditsController
        
        present(viewCredits, animated: true, completion: nil)
    }
    
    
    
}

