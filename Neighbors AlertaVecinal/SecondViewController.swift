//
//  SecondViewController.swift
//  Neighbors Alerta Vecinal Neighbors Alerta Vecinal Neighbors
//
//  Created by Manuel Ambriz on 23/09/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import UIKit
import Alamofire

private let reuseIdentifier = "SolicitudesCell"
class SecondViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var ipaenviar: String = ""
    @IBOutlet weak var solicitudviewcell: SolicitudesUICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return FabricaSolicitudes.shared.solicitudes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SolcitudCollectionViewCell
        
        let solicitudes = FabricaSolicitudes.shared.getSolicitud(with: indexPath.row)

        
        cell.Calle.text = solicitudes.calle
        cell.Delegacion.text = solicitudes.ciudad
        cell.Colonia.text = solicitudes.colonia
        cell.Administrador.text = solicitudes.propietario
        cell.correo.text = solicitudes.correopropietario
        cell.Unirse2.layer.setValue(indexPath.row, forKey: "index")
        cell.Unirse2.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: UIControlEvents.touchUpInside)
        
        return cell
    }
    
    @IBAction func EnviarSolicitud(_ sender: Any) {
        
    
        
        /*let alert = UIAlertController(title: "My Alert", message: "This is an alert with indez path !", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)*/
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       /* let alert = UIAlertController(title: "My Alert", message: "This is an alert with indez path \(indexPath.row)!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.solicitudviewcell.delegate = self
        self.solicitudviewcell.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func datePickerValueChanged(_ sender: UIButton) {
        let i : Int = (sender.layer.value(forKey: "index")) as! Int
        let solicitudes = FabricaSolicitudes.shared.getSolicitud(with: i)
        
        /*let url = NSURL(string: "https://neighbors-alertavecinal.herokuapp.com/appmovil/solicitud/"+solicitudes.id);
        let datos:NSData? = NSData(contentsOf : url! as URL)
        let texto = NSString(data: datos! as Data, encoding: String.Encoding.utf8.rawValue)
        
        let alert = UIAlertController(title: "Solicitud Enviada", message: "\(texto)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)*/
        
        Alamofire.request("https://neighbors-alertavecinal.herokuapp.com/appmovil/solicitud/"+solicitudes.id, method: .post, parameters: ["email": "correo", "contraseña": "contraseña" ]).responseString { response in
            print("String:\(String(describing: response.result.value))")
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    print(data)
                    let alert = UIAlertController(title: "Solicitud Enviada", message: "\(data)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                        NSLog("The \"OK\" alert occured.")
                    }))
                    self.present(alert, animated: true, completion: nil)
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
    
    @IBAction func refresh(_ sender: UIButton) {
        solicitudviewcell.reloadData()
    }
}

