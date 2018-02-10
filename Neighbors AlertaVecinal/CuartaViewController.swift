//
//  CuartaViewController.swift
//  Neighbors Alerta Vecinal Neighbors Alerta Vecinal Neighbors
//
//  Created by Manuel Ambriz on 22/11/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import UIKit
import Firebase
import Alamofire
private let reuseIdentifier = "NotificationCell"
class CuartaViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var contador = FabricaDeNotificaciones.init().notificaciones.count
    @IBOutlet weak var notificacionesview: NotificacionesUICollectionView!
    var refresh: UIRefreshControl!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("notificacionesprueba 22 \(FabricaDeNotificaciones.init().notificaciones.count)")
        contador = FabricaDeNotificaciones.init().notificaciones.count
         return FabricaDeNotificaciones.init().notificaciones.count
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.notificacionesview.delegate = self
        self.notificacionesview.dataSource = self
        // Do any additional setup after loading the view.
        
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(CuartaViewController.pupulate), for: UIControlEvents.valueChanged)
        notificacionesview.addSubview(refresh)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NotificacionesCollectionViewCell
        var notificaciones = FabricaDeNotificaciones.shared.getNotificaciones(with: indexPath.row)
        //print("Contadores \(FabricaDeNotificaciones.shared.notificaciones.count) \(contador)")
        if(FabricaDeNotificaciones.shared.notificaciones.count < contador){
             notificaciones = FabricaDeNotificaciones.init().getNotificaciones(with: indexPath.row)}
            cell.titulo.text = notificaciones.titulo
            cell.fecha.text = notificaciones.fecha
            cell.mensaje.text = notificaciones.mensaje
            cell.nombre.text = "\(notificaciones.nombre) \(notificaciones.apellidopaterno) \(notificaciones.apellidomaterno)"
            
        
        return cell
    }
    @objc func pupulate(){
        
        notificacionesview.reloadData()
        refresh.endRefreshing()
    }
    
    @IBAction func refresh(_ sender: UIButton) {
        notificacionesview.reloadData()
    }
    @IBAction func refrescar(_ sender: UIButton) {
        notificacionesview.reloadData()
        print("Refreshnotificaciones")
    }
    
    @IBAction func NuevaNotificacion(_ sender: Any) {
        if(FabricaDeRedCamaras.shared.redcamaras.count > 0){
            let alert = UIAlertController(title: "Nuevo alerta vecinal a su Red" , message: "Describe a la comunidad que esta sucediendo", preferredStyle: .alert)
            
            // Login button
            let loginAction = UIAlertAction(title: "Enviar", style: .default, handler: { (action) -> Void in
                // Get TextFields text
                let Titulo = alert.textFields![0]
                let Mensaje = alert.textFields![1]
                if(Titulo.text != "" && Mensaje.text != "")
                {
                    print("Titulo: \(Titulo.text!) \nMensaje: \(Mensaje.text!)")
                    let redcamara = FabricaDeRedCamaras.shared.getRedCamaras(with: 0)
                    self.crearGrupoDeNotificaiones(id: redcamara.id, titulo: Titulo.text!, mensaje: Mensaje.text!)
                    self.subirNotificacionAlServidro(redcamara: redcamara.id, titulo: Titulo.text!, mensaje: Mensaje.text!)
                }
                    
                else {
                    let alert2 = UIAlertController(title: "Error", message: "No deje campos vacios", preferredStyle: .alert)
                    alert2.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                        NSLog("The \"OK\" alert occured.")
                    }))
                    self.present(alert2, animated: true, completion: nil)
                }
                
            })
            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
            alert.addTextField { (textField: UITextField) in
                textField.keyboardAppearance = .dark
                textField.keyboardType = .default
                textField.autocorrectionType = .default
                textField.placeholder = "Título de la Alerta"
                
            }
            alert.addTextField { (textField: UITextField) in
                textField.keyboardAppearance = .dark
                textField.keyboardType = .default
                textField.autocorrectionType = .default
                textField.placeholder = "Mensaje para los Vecinos"
                
                
            }
            alert.addAction(loginAction)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        
            
        }
        
        else{
            let alert = UIAlertController(title: "Error", message: "Debe pertencer a una Red Vecinal antes de emitir una Alerta ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func crearGrupoDeNotificaiones(id: String, titulo: String, mensaje: String) {
        var tokenes : [String] = [""]
        let token = FabricaDeTokens.init(redcamara: id)
        if(token.token.count > 0){
            for i in 0...token.token.count-1 {
                let onetoken = token.getToken(with: i)
                tokenes.append("\(onetoken.Token)")
                
            }
            if tokenes.count > 0 {
                for i in 0...tokenes.count-1{
                    enviarnoti(tokens: tokenes[i], titulo: titulo, mensaje: mensaje)
                }
            }
            
            
        }
    }
    
    func enviarnoti (tokens: String, titulo: String, mensaje: String) {
        if(tokens == ""){return;}
        let nombre = nombredeusuario();
        if let url = URL(string: "https://fcm.googleapis.com/fcm/send"){
            
            let key = "AAAA4Ei_-iI:APA91bFwpVGixDixIVwcQZwlbEavPuHW4Xci6dUmXnDBSOJ3YJpFyQG2agJ2KGQTNfR-ZOOHyUBJk2jBQ1P31YoD-4P8G8VGIs5YRcLV14shoBeSzEmHMfxzmrhfEl2LIrXJl_bDrL9p"
            var request = URLRequest(url: url)
            
            print("alvtoken: \(tokens)")
            
            request.allHTTPHeaderFields = ["Authorization": "key=\(key)", "Content-Type": "application/json", "project_id":"neighbors-alertavecinal2"]
            request.httpMethod = "POST"
            request.httpBody = "{\"to\" : \"\(tokens)\",\"notification\" : {\"body\" : \"\(nombre): \(mensaje)\", \"sound\" : \"default\"},\"data\" : {\"nombre\" : \"Manuel Ambriz\", \"edad\" : \"22\"}}".data(using: .utf8)
            
            URLSession.shared.dataTask(with: request, completionHandler:{( data, response, error) in
                print("Response \(String(describing: response))")
                if error == nil {
                    print ("Error \(String(describing: error))")}
                else {
                    print(data as Any)}
            }).resume()
        }
        notificacionesview.reloadData()
    }
    
    func subirNotificacionAlServidro(redcamara: String, titulo: String, mensaje: String){
        Alamofire.request("https://neighbors-alertavecinal.herokuapp.com/appmovil/notificaciones/\(redcamara)", method: .post, parameters: ["titulo": "\(titulo)", "mensaje" : "\(mensaje)" ]).responseString { response in
            print("String:\(String(describing: response.result.value))")
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    let alert2 = UIAlertController(title: "Enviada", message: "\(data)", preferredStyle: .alert)
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
   
    @IBAction func notificacionNueva(_ sender: UIButton) {
        if(FabricaDeRedCamaras.shared.redcamaras.count > 0){
            let alert = UIAlertController(title: "Nuevo alerta vecinal a su Red" , message: "Describe a la comunidad que esta sucediendo", preferredStyle: .alert)
            
            // Login button
            let loginAction = UIAlertAction(title: "Enviar", style: .default, handler: { (action) -> Void in
                // Get TextFields text
                let Titulo = alert.textFields![0]
                let Mensaje = alert.textFields![1]
                if(Titulo.text != "" && Mensaje.text != "")
                {
                    print("Titulo: \(Titulo.text!) \nMensaje: \(Mensaje.text!)")
                    let redcamara = FabricaDeRedCamaras.shared.getRedCamaras(with: 0)
                    self.crearGrupoDeNotificaiones(id: redcamara.id, titulo: Titulo.text!, mensaje: Mensaje.text!)
                    self.subirNotificacionAlServidro(redcamara: redcamara.id, titulo: Titulo.text!, mensaje: Mensaje.text!)
                }
                    
                else {
                    let alert2 = UIAlertController(title: "Error", message: "No deje campos vacios", preferredStyle: .alert)
                    alert2.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                        NSLog("The \"OK\" alert occured.")
                    }))
                    self.present(alert2, animated: true, completion: nil)
                }
                
            })
            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
            alert.addTextField { (textField: UITextField) in
                textField.keyboardAppearance = .dark
                textField.keyboardType = .default
                textField.autocorrectionType = .default
                textField.placeholder = "Título de la Alerta"
                
            }
            alert.addTextField { (textField: UITextField) in
                textField.keyboardAppearance = .dark
                textField.keyboardType = .default
                textField.autocorrectionType = .default
                textField.placeholder = "Mensaje para los Vecinos"
                
                
            }
            alert.addAction(loginAction)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
            
            
        }
            
        else{
            let alert = UIAlertController(title: "Error", message: "Debe pertencer a una Red Vecinal antes de emitir una Alerta ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func reloadview() {
        notificacionesview.reloadData()
    }
    
    func nombredeusuario() -> String {
        return datosusuario.shared.getUsuario(with: 0).nombre + " " + datosusuario.shared.getUsuario(with: 0).apellidopaterno;
    }
    
}
