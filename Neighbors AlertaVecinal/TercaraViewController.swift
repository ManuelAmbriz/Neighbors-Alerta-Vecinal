//
//  TercaraViewController.swift
//  Neighbors Alerta Vecinal Neighbors Alerta Vecinal Neighbors
//
//  Created by Manuel Ambriz on 05/10/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import UIKit
import  Alamofire
class TercaraViewController: UIViewController {
    @IBOutlet weak var Nombre: UILabel!
    @IBOutlet weak var localizacin: UILabel!
    @IBOutlet weak var contacto: UILabel!
    @IBOutlet weak var Nombres: UITextField!
    @IBOutlet weak var Apellidos: UITextField!
    @IBOutlet weak var correo: UILabel!
    @IBOutlet weak var direccion: UILabel!
    @IBOutlet weak var ApellidoMaterno: UITextField!
    @IBOutlet weak var notificacionessensores: UISwitch!
    
  
    
    override func viewDidLoad() {
        print("Estatusnotif \(estatusnotif())")
        if (estatusnotif() == "Activado"){
            notificacionessensores.setOn(true, animated: false)
        }else{notificacionessensores.setOn(false, animated: false)}
        if(estatusnotif() == "Error"){notificacionessensores.isEnabled = false }
        let url = NSURL (string: "https://neighbors-alertavecinal.herokuapp.com/appmovil/profile" )
        let datos = NSData (contentsOf : url! as URL)
        do {
            let json1 = try JSONSerialization.jsonObject(with: datos! as Data, options: JSONSerialization.ReadingOptions.mutableLeaves)
             print("Json1 \(json1)")
            let dico1 = json1 as! NSDictionary
            let nombre = dico1["nombre"] as? String ?? ""
            let apellidos = dico1["apellidopaterno"] as? String ?? ""
            self.Nombre.text = nombre + apellidos
            self.localizacin.text = "Mexico CDMX"
            self.contacto.text = dico1["correo"] as? String ?? ""
            self.Nombres.text = nombre
            self.Apellidos.text = dico1["apellidopaterno"] as? String ?? ""
            self.ApellidoMaterno.text = dico1["apellidomaterno"] as? String ?? ""
            self.correo.text = dico1["correo"] as? String ?? ""
            self.direccion.text = "Direccion"
            
        }
        catch _ {
            
        }
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deactivarnotificaciones(_ sender: Any) {
      
    }
    @IBAction func desactivarnotif(_ sender: UISwitch) {
        if(sender.isOn == true){
            enviarpost(Estatus: "Activado")
        }
        else{
            enviarpost(Estatus: "Desactivado")
        }
    }
    
    func estatusnotif() -> String {
        let url = NSURL (string : "https://neighbors-alertavecinal.herokuapp.com/userapp/estatusdesensores/" )
        let datos = NSData (contentsOf : url! as URL)
        var json1: String = ""
        do{
            if(datos != nil){
                json1 = NSString(data: datos! as Data, encoding: String.Encoding.utf8.rawValue)! as String!
            
            }
            else {
                notificacionessensores.isEnabled = false 
            }
        }
        catch _ {}
        return json1
    }
    func enviarpost(Estatus: String){
        Alamofire.request("https://neighbors-alertavecinal.herokuapp.com/userapp/quitarnotificacionessensores", method: .post, parameters: ["notificacion": "\(Estatus)"]).responseString { response in
            print("String:\(String(describing: response.result.value))")
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    let alert2 = UIAlertController(title: "Notificaciones de Sensores", message: "\(data)", preferredStyle: .alert)
                    alert2.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                        NSLog("The \"OK\" alert occured.")
                    }))
                    self.present(alert2, animated: true, completion: nil)
                }
            case .failure(_):
                let alert = UIAlertController(title: "Error", message: "Error con el servidor", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }

    }

}
