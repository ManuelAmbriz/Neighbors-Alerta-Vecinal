//
//  LoadViewController.swift
//  Neighbors Alerta Vecinal Neighbors Alerta Vecinal Neighbors
//
//  Created by Manuel Ambriz on 05/10/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import UIKit
import Firebase
import Alamofire

class LoadViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var password: RoundTextField!
    @IBOutlet weak var user: RoundTextField!
    @IBOutlet weak var usuario: UITextField!
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    @IBOutlet weak var InicioSesion: Round!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let usuario :String? = "man"
        guard usuario != nil else {
            performSegue(withIdentifier: "loginVC", sender: nil)
            return
        }
    }
    
    @IBAction func iniciarSesion(_ sender: Any) {
        let Autentificar = AuthService()
        showActivityIndicator(uiView: self.view)
        if let email = self.usuario.text,
            let contraseña = self.password.text, (email.characters.count > 0 && contraseña.characters.count > 0){
        Autentificar.Auth(correo: email , contraseña: contraseña) {
            (Auth: Int, user_id: String) in
            print("got back: \(Auth)")
            
            print("UserAuth \(Auth)")
            switch Auth{
                case 1: self.performSegue(withIdentifier: "loginVC", sender: nil)
                self.hideActivityIndicator(uiView: self.view)
                if(FabricaDeRedCamaras.shared.redcamaras.count > 0){
                    let redcamara = FabricaDeRedCamaras.shared.getRedCamaras(with: 0)
                    self.subirtoken(redcamara: redcamara.id)
                    if (redcamara.notificacion != "true"){
                        self.cambiarEstadoDeNotificacionRed(id: redcamara.id)
                    }
                }
                else{
                    self.subirtoken(redcamara: "")
                }
                    return
            case 2:
                self.hideActivityIndicator(uiView: self.view)
                let alert = UIAlertController(title: "Error", message: "Usario o Contraseña Incorrectos", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
                
            default:
                self.hideActivityIndicator(uiView: self.view)
                
                let alert = UIAlertController(title: "Error", message: "Usario o Contraseña Incorrectos", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
            }
            
            
        }
    }//fin del else
        else {
            self.hideActivityIndicator(uiView: self.view)
            let alert = UIAlertController(title: "Error", message: "No deje campos vacios", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func subirtoken(redcamara: String) {
    let token = Messaging.messaging().fcmToken!
        Alamofire.request("https://neighbors-alertavecinal.herokuapp.com/appmovil/token", method: .post, parameters: ["token": "\(token)", "redcamaras_id" : "\(redcamara)" ]).responseString { response in
            print("String:\(String(describing: response.result.value))")
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    print("Token Enviado \(data)")
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
    
    
    func cambiarEstadoDeNotificacionRed(id: String) {
        Alamofire.request("https://neighbors-alertavecinal.herokuapp.com/appmovil/redcamaranoti/\(id)", method: .post, parameters: ["token": "d", "contraseña": "contraseña" ]).responseString { response in
            print("String:\(String(describing: response.result.value))")
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    
                    print("RedCamara con registro para notificaciones \(data)")
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
    @IBAction func handleLogTokenTouch(_ sender: UIButton) {
        // [START log_fcm_reg_token]
        let token = Messaging.messaging().fcmToken
        print("FCMLoad token: \(token ?? "")")
        // [END log_fcm_reg_token]
    }
    
    @IBAction func handleSubscribeTouch(_ sender: UIButton) {
        // [START subscribe_topic]
        Messaging.messaging().subscribe(toTopic: "news")
        print("Subscribed to news topic")
        // [END subscribe_topic]
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func showActivityIndicator(uiView: UIView) {
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColorFromHex(rgbValue: 0xffffff, alpha: 0.3)
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColorFromHex(rgbValue: 0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2);
        
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        activityIndicator.startAnimating()
    }
    func hideActivityIndicator(uiView: UIView) {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
 
}

