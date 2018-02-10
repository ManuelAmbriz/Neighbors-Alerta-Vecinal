//
//  QuintaViewController.swift
//  Neighbors Alerta Vecinal Neighbors Alerta Vecinal Neighbors
//
//  Created by Manuel Ambriz on 06/12/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import UIKit
import Alamofire
private let reuseIdentifier = "SolicitudesEmitidasCell"
private let reuseIdentifier2 = "SolicitudesRecibidasCell"
var idredcamaras1 = [String]()
class QuintaViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.SolcitudesEmitidas {return FabricaSolicitudes.shared.solicitudes.count}
        else {
            let redcamarascount = FabricaDeRedCamaras.shared.redcamaras.count
            if(bandera==0){
                if(redcamarascount > 0){
                    for index in 0...redcamarascount-1 {
                        let redcamaras = FabricaDeRedCamaras.shared.getRedCamaras(with: index)
                        idredcamaras.append(redcamaras.id)
                    }
                    bandera=1
                }
            }
            if idredcamaras.count > 0 {
                let camarasllenado = FabricaSolicitudesRecibidas.init(idredcamara: idredcamaras[0])
                let count = camarasllenado.solicitudes.count
                print("countcount \(count)")
                return count
            }
            else {return 0}
        }
    }
    
    
    
    @IBOutlet weak var Seleccion: UISegmentedControl!
    @IBOutlet weak var SolcitudesEmitidas: USolcitudesEnviarUICollectionView!
    @IBOutlet weak var SolicitudesRecibidas: SolicitudesRecibidasUICollectionView!
    

    override func viewDidLoad() {
        
        self.SolcitudesEmitidas.delegate = self
        self.SolcitudesEmitidas.dataSource = self
        self.SolicitudesRecibidas.delegate = self
        self.SolicitudesRecibidas.dataSource = self
         SolicitudesRecibidas.isHidden = true
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func selection(_ sender: Any) {
        if Seleccion.selectedSegmentIndex == 0{
            SolcitudesEmitidas.isHidden = false
            SolicitudesRecibidas.isHidden = true
        }
        if Seleccion.selectedSegmentIndex == 1{
            SolcitudesEmitidas.isHidden = true
            SolicitudesRecibidas.isHidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.SolcitudesEmitidas {
             print("Prueba alv")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SolicitudesEmitidasUICollectionViewCell
            
            let solicitudes = FabricaSolicitudesEmitidas.init().getSolicitud(with: indexPath.row)
           
            //print("Count \(count)")
            
            cell.direccion.text = solicitudes.estatus
            cell.Estatus.text = solicitudes.calle + ", " + solicitudes.colonia + ", " + solicitudes.ciudad + ", " + solicitudes.estado
            
            cell.Cancel.layer.setValue(solicitudes.id, forKey: "index")
            cell.Cancel.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: UIControlEvents.touchUpInside)
            
          //  if(FabricaSolicitudesEmitidas.shared.getUserIf() == solicitudes.u)
            
            return cell
        }
        else {
            print("Prueba alv")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier2, for: indexPath) as! SolicitudesRecibidasCollectionViewCell
            let redcamarascount = FabricaDeRedCamaras.shared.redcamaras.count
            if(bandera==0){
                if(redcamarascount > 0){
                    for index in 0...redcamarascount-1 {
                        let redcamaras = FabricaDeRedCamaras.shared.getRedCamaras(with: index)
                        idredcamaras.append(redcamaras.id)
                    }
                    bandera=1
                }
            }
            
            if(idredcamaras.count > 0){
                let solictudrllenado = FabricaSolicitudesRecibidas.init(idredcamara: idredcamaras[0])
                print("CountCountCount \(FabricaSolicitudesRecibidas.shared.solicitudes.count)")
                if(FabricaSolicitudesRecibidas.shared.solicitudes.count > 0){
                    let solicitudes = solictudrllenado.getSolicitud(with: indexPath.row)
                    //print("Count \(count)")
                    print("solirec2 \(solicitudes.propietario)")
                    cell.nombresol.text = solicitudes.propietario
                    cell.correo.text = solicitudes.correopropietario
                    
                    cell.cancel.layer.setValue(solicitudes.id, forKey: "index")
                    cell.cancel.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: UIControlEvents.touchUpInside)
                    
                    cell.aprobar.layer.setValue(solicitudes.id, forKey: "index")
                    cell.aprobar.addTarget(self, action: #selector(datePickerValueChanged2(_:)), for: UIControlEvents.touchUpInside)
                    
                }
                
            }
            return cell
        }
    }
    @objc func datePickerValueChanged2(_ sender: UIButton) {
        let i : String = (sender.layer.value(forKey: "index")) as! String
         Alamofire.request("https://neighbors-alertavecinal.herokuapp.com/appmovil/solicitud/"+i, method: .put
            , parameters: ["email": "correo", "contraseña": "contraseña" ]).responseString { response in
             print("String:\(String(describing: response.result.value))")
             switch(response.result) {
                 case .success(_):
                     if let data = response.result.value{
                         //print(data)
                         let alert = UIAlertController(title: "Solicitud", message: "\(data)", preferredStyle: .alert)
                         alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                         NSLog("The \"OK\" alert occured.")
                         }))
                         self.present(alert, animated: true, completion: nil)
                        self.SolcitudesEmitidas.reloadData()
                        self.SolicitudesRecibidas.reloadData()
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
    @objc func datePickerValueChanged(_ sender: UIButton) {
        let i : String = (sender.layer.value(forKey: "index")) as! String
        print("calcelnotif \(i)")
        Alamofire.request("https://neighbors-alertavecinal.herokuapp.com/appmovil/solicitudeliminar/"+i, method: .post, parameters: ["email": "correo", "contraseña": "contraseña" ]).responseString { response in
            print("String:\(String(describing: response.result.value))")
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    //print(data)
                    let alert = UIAlertController(title: "Solicitud Cancelada", message: "\(data)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                        NSLog("The \"OK\" alert occured.")
                    }))
                    self.present(alert, animated: true, completion: nil)
                    self.SolcitudesEmitidas.reloadData()
                    self.SolicitudesRecibidas.reloadData()
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
        SolcitudesEmitidas.reloadData()
        SolicitudesRecibidas.reloadData()
    }
}
