//
//  CamaraViewController.swift
//  Neighbors Alerta Vecinal Neighbors Alerta Vecinal Neighbors
//
//  Created by Manuel Ambriz on 10/11/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import UIKit
import Alamofire
import WebKit

class CamaraViewController: UIViewController, UIWebViewDelegate,WKUIDelegate, WKNavigationDelegate  {
    @IBOutlet weak var webView: WKWebView!
    var ipquellega:String = ""
    @IBOutlet weak var camaraIp: UILabel!
    @IBOutlet weak var camarasweb: UIWebView!
     var camara: Camaras? = nil
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
   // let bandera
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.uiDelegate = self
        webView.navigationDelegate = self
            }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        /*var url = URL(string: (camara?.ip)!)
       if (url == nil){url = URL(string: "https://www.google.com.mx")}
        let request  = URLRequest(url: url!)
        print("request \(request)")
        camarasweb.loadRequest(request)
        camarasweb.delegate = self
        camarasweb.frame = UIScreen.main.bounds
        camarasweb.center = self.view.center
        camaraIp.text = camara?.ip*/
        let webstring = camara!.ip
        var url = ""
    
        print ("WenString \(webstring)")
        if(webstring == "http://192.168.1.88"){url = webstring+"/video1.mjpg"}
        else if(webstring == "http://192.168.1.88/"){url = webstring+"/video1.mjpg"}
        else if(webstring == "http://148.204.86.35"){url = webstring+"/video1.mjpg"}
        else if(webstring == "http://148.204.86.35/"){url = webstring+"/video1.mjpg"}
        else {url = webstring}
         print ("URL \(url)")
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            webView.load(request)
            //webView.navigationDelegate = self
            //self.view.addSubview(webView)
            //self.view.sendSubview(toBack: webView)

        }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
        print(error.localizedDescription)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("IniciodeWebView")
        //showActivityIndicator(uiView: self.view)
        //sleep(400)
        //hideActivityIndicator(uiView: self.view)
    }
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        print("FindeWebView")
        //hideActivityIndicator(uiView: self.view)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
          print("IniciodeWebView")
        showActivityIndicator(uiView: self.view)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("FindeWebView")
        hideActivityIndicator(uiView: self.view)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func cancelpress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // open "target_blank" link
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
    
    // for basic auth
    func webView(_ webView: WKWebView, didReceive didReceiveAuthenticationChallenge: URLAuthenticationChallenge, completionHandler: @escaping(URLSession.AuthChallengeDisposition, URLCredential?) -> Void){
        let credential = URLCredential(user: "admin", password: "", persistence: URLCredential.Persistence.forSession)
        completionHandler(.useCredential, credential)
        
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }
    

    
    @IBAction func NuevaAlerta(_ sender: Any) {
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
        if let url = URL(string: "https://fcm.googleapis.com/fcm/send"){
            
            let key = "AAAA4Ei_-iI:APA91bFwpVGixDixIVwcQZwlbEavPuHW4Xci6dUmXnDBSOJ3YJpFyQG2agJ2KGQTNfR-ZOOHyUBJk2jBQ1P31YoD-4P8G8VGIs5YRcLV14shoBeSzEmHMfxzmrhfEl2LIrXJl_bDrL9p"
            var request = URLRequest(url: url)
            
            print("alvtoken: \(tokens)")
            
            request.allHTTPHeaderFields = ["Authorization": "key=\(key)", "Content-Type": "application/json", "project_id":"neighbors-alertavecinal2"]
            request.httpMethod = "POST"
            request.httpBody = "{\"to\" : \"\(tokens)\",\"notification\" : {\"body\" : \"\(mensaje)\", \"sound\" : \"default\"},\"data\" : {\"nombre\" : \"Manuel Ambriz\", \"edad\" : \"22\"}}".data(using: .utf8)
            
            URLSession.shared.dataTask(with: request, completionHandler:{( data, response, error) in
                print("Response \(String(describing: response))")
                if error == nil {
                    print ("Error \(String(describing: error))")}
                else {
                    print(data as Any)}
            }).resume()
        }
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
