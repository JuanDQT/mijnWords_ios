//
//  ConfigController.swift
//  MijnWords
//
//  Created by Juan Daniel on 26/8/17.
//  Copyright © 2017 Juan Daniel. All rights reserved.
//

import UIKit

// https://peterwitham.com/swift-archives/how-to-use-a-uipickerview-as-input-for-a-uitextfield/ Open PickerView in TextField
class ConfigController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var tfFocusVerb: UITextField!
    @IBOutlet weak var tfBaseVerb: UITextField!
    let pickerFocusLanguage = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerFocusLanguage.delegate = self
        pickerFocusLanguage.dataSource = self
        tfBaseVerb.text = Common.getBaseLanguage()
        tfFocusVerb.text = Common.getFocusLanguage()
        tfFocusVerb.inputView = pickerFocusLanguage
        
        pickerFocusLanguage.selectRow(Common.allLanguages.index(of: Common.getFocusLanguage())!, inComponent: 0, animated: false)

    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Common.allLanguages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Common.allLanguages[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tfFocusVerb.text = Common.allLanguages[row]
    }
    

    @IBAction func saveAction(_ sender: Any) {
        UserDefaults.standard.set(tfFocusVerb.text, forKey: "LN")
        dismiss(animated: true, completion: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
