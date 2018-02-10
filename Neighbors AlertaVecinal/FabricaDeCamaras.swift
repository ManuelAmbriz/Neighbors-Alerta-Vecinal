//
//  FabricaDeCamaras.swift
//  Neighbors Alerta Vecinal Neighbors Alerta Vecinal Neighbors
//
//  Created by Manuel Ambriz on 27/10/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import Foundation
import Alamofire

class FabricaDeCamaras{
    var idredcamara: [String]
    static let shared : FabricaDeCamaras = {
        let shared = FabricaDeCamaras(idredcamara: [""])
        return shared
    }()
    
    init(idredcamara: [String]) {
        self.idredcamara = idredcamara
        
        
       // print("ID de la red de Camaras que llegua a la fabrica de Camara \(idredcamara)")
        let idredcamarascount = idredcamara.count
        //print(idredcamarascount)
        for i in 0..<idredcamarascount{
            print("ID de la red de camaras \(idredcamara[i]) y el index \(i)")
            let urlcompleto = "https://neighbors-alertavecinal.herokuapp.com/appmovil/camaras/" + idredcamara[i]
            let url = NSURL (string : urlcompleto)
            let datos = NSData (contentsOf : url! as URL)
            do{
                
                let json1 = try JSONSerialization.jsonObject(with: datos! as Data, options: JSONSerialization.ReadingOptions.mutableLeaves)
                // print("Json1 \(json1)")
                let dico1 = json1 as! NSDictionary
                
                let dico2 = dico1["camaras"] as! [NSDictionary]
                //print ("Dico 2 \(dico2) con index \(i)")
                var contador: Int = 0
                for _ in dico2{
                    
                    let jsonuser = dico2[contador]["user_id"] as! NSDictionary
                    let jsonredcamaras = dico2[contador]["redcamaras_id"] as! NSDictionary
                    
                    let propietario = jsonuser["correo"] as? String ?? ""
                    let calle = jsonredcamaras["calle"] as? String ?? ""
                    
                    let numeroex =  dico2[contador]["numeroex"] as? String ?? ""
                    let id = dico2[contador]["_id"] as? String ?? ""
                    let ip = dico2[contador]["ip"] as? String ?? ""
                    print("Camara:{ id= \(id) Propietario= \(propietario) Calle= \(calle) Número= \(numeroex) IP= \(ip)}")
                    let Camara = Camaras(id: id, numeroex: numeroex, calle: calle,propietario: propietario, ip:ip)
                    self.camaras.append(Camara)
                    contador = contador+1
                }
                
            }
            catch _ {
                
            }
        }
        
    }
    var camaras : [Camaras] = []
    
    func getCamaras(with CamarasId: Int) -> Camaras {
        print("Count en fabrica \(camaras.count)")
        return self.camaras[CamarasId]
    }
}

