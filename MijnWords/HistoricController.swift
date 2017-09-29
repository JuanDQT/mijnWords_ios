//
//  HistoricController.swift
//  MijnWords
//
//  Created by Juan Daniel on 27/9/17.
//  Copyright © 2017 Juan Daniel. All rights reserved.
//

import UIKit
import RealmSwift

class HistoricController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    var result: [Palabras]?
    
    var wordSelected: (( _ response: String) -> Void)?
    var realm: Realm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        
        realm = try! Realm()
        result = Array(realm!.objects(Palabras.self))
        
        if result?.count == 0 {
            self.showNoVerbsSaved()
        }

        // Do any additional setup after loading the view.
    }

    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // UITABLE OVERRIDE METHOS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (result == nil) ? 0 : result!.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        log.error("ENVIAMOS DESDE HISTORIC: \(result![indexPath.row].name!)")
        wordSelected?(result![indexPath.row].name!)
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = result![indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }

    // Eliminar fila:
    //https://www.hackingwithswift.com/example-code/uikit/how-to-swipe-to-delete-uitableviewcells
    

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            realm = try! Realm()
            try! realm!.write {
                realm!.delete(result![indexPath.row])
            }
            result?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            if (result?.count == 0) {
                self.showNoVerbsSaved()
            }
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func showNoVerbsSaved() {
        table.removeFromSuperview()
        let title = UILabel()
        title.text = "No hay verbos guardados"
        title.sizeToFit()
        title.center = self.view.center
        view.addSubview(title)
    }
    
}
