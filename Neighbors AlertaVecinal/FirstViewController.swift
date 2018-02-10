//
//  FirstViewController.swift
//  Neighbors Alerta Vecinal Neighbors Alerta Vecinal Neighbors
//º
//  Created by Manuel Ambriz on 23/09/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import UIKit
private let reuseIdentifier = "CamarasCell"
private let reuseIdentifier2 = "UsuariosCell"
class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIWebViewDelegate {
    var ipaenviar: String = ""
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    //let camarasllenado
    @IBOutlet weak var SecondViewController: CamarasUICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1000
        
        
    }
    

    @IBOutlet weak var indicadora: UILabel!
    @IBOutlet weak var camaraimage: UIImageView!
    @IBOutlet weak var select: UISegmentedControl!
    @IBOutlet weak var web1: UIWebView!
    @IBOutlet weak var camarascollection: CamarasUICollectionView!
    @IBOutlet weak var UserRedcollection: UsuarioRedUICollectionView!
    var bandera: Int = 0;
    var bandera2: Int = 0;
    var idredcamaras = [String]()
    var refresh: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.camarascollection.delegate = self
        self.camarascollection.dataSource = self
        self.UserRedcollection.delegate = self
        self.UserRedcollection.dataSource = self
        
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(FirstViewController.pupulate), for: UIControlEvents.valueChanged)
        camarascollection.addSubview(refresh)
        UserRedcollection.addSubview(refresh)
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        if collectionView == self.camarascollection {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CamarasCollectionViewCell
            
            let redcamarascount = FabricaDeRedCamaras.shared.redcamaras.count
            if (redcamarascount>0){
            if(bandera==0 && redcamarascount>0){
                for index in 0...redcamarascount-1 {
                    let redcamaras = FabricaDeRedCamaras.shared.getRedCamaras(with: index)
                    idredcamaras.append(redcamaras.id)
                }
                bandera=1
            }
             let camarasllenado = FabricaDeCamaras.init(idredcamara: idredcamaras)
            let camaras = camarasllenado.getCamaras(with: indexPath.row)
            //print("Count \(count)")
                let url = URL(string: (camaras.ip))
            cell.Calle.text = camaras.calle
            cell.Casa.text = camaras.numeroex
            cell.Propietario.text = camaras.propietario
            cell.CameraImage.image = UIImage(named: "Untitled-1")
            //cell.web.loadRequest(URLRequest(url: url!))
            //
                cell.web.delegate = self
            cell.web.isHidden = true
            }
             return cell
        }
        else {
            print()
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier2, for: indexPath) as! UsuarioRedCollectionViewCell
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
            let camarasllenado = FabricaDeUsuarios.init(idredcamara: idredcamaras[0])
            let count = camarasllenado.usuarios.count
            
            if(count > 0) {
            let usuariosllenado = FabricaDeUsuarios.init(idredcamara: idredcamaras[0])
            let usuarios = usuariosllenado.getUsuario(with: indexPath.row)
            cell.correo.text = usuarios.correo
            cell.Nombre.text = usuarios.nombre
            cell.direccion.text = usuarios.direccion
            }
            return cell
        }
        
        
    }

    @objc func pupulate(){
        camarascollection.reloadData()
        UserRedcollection.reloadData()
        refresh.endRefreshing()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        /*guard (auth!=nil)  {
            performSegue(withIdentifier: showLoginVW, sender: nil)
            
        }*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        if collectionView == self.camarascollection{
        let redcamarascount = FabricaDeRedCamaras.shared.redcamaras.count
    
        if(bandera==0 && redcamarascount>0){
            for index in 0...redcamarascount-1 {
                let redcamaras = FabricaDeRedCamaras.shared.getRedCamaras(with: index)
                idredcamaras.append(redcamaras.id)
            }
            bandera=1
        }
        let camarasllenado = FabricaDeCamaras.init(idredcamara: idredcamaras)
        let camaras = camarasllenado.getCamaras(with: indexPath.row)
        print("CamaraNof \(camaras.ip)")
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotifyCamaras"), object: camaras)
      
        ipaenviar = camaras.ip
         print ("IPprepate1 \(ipaenviar)")
            
        }
    }
    
    @IBAction func refrescartodo(_ sender: UIButton) {
        camarascollection.reloadData() 
        UserRedcollection.reloadData()
    }
    @IBOutlet weak var refreshalv: UIButton!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let count = FabricaDeRedCamaras.shared.redcamaras.count
        guard count != 0  else {
            return
        }
        
        let nav = segue.destination as! UINavigationController
        let svc = nav.topViewController as! CamaraViewController
        let item = sender as? UICollectionViewCell
        let indexPath = camarascollection.indexPath(for: item!)
        let redcamarascount = FabricaDeRedCamaras.shared.redcamaras.count
        if(bandera==0 && redcamarascount>0){
            for index in 0...redcamarascount-1 {
                let redcamaras = FabricaDeRedCamaras.shared.getRedCamaras(with: index)
                idredcamaras.append(redcamaras.id)
            }
            bandera=1
        }
        let camarasllenado = FabricaDeCamaras.init(idredcamara: idredcamaras)
        let camaras = camarasllenado.getCamaras(with: (indexPath?.row)!)
        svc.camara = camaras
        
        
    }
    @IBAction func Selection(_ sender: Any) {
        if select.selectedSegmentIndex == 0{
            camarascollection.isHidden = false
            indicadora.text = "Ver Cámaras"

            
        }
        if select.selectedSegmentIndex == 1{
            camarascollection.isHidden = true
            indicadora.text = "Vecinos en tu Red"
            
            
            
        }
        if select.selectedSegmentIndex == 2{
            camarascollection.isHidden = true
        }
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("IniciodeWebView")
        showActivityIndicator(uiView: self.view)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("FindeWebView")
        hideActivityIndicator(uiView: self.view)
    
        
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

