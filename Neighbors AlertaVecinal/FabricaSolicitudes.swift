//
//  FabricaSolicitudes.swift
//  Neighbors Alerta Vecinal Neighbors Alerta Vecinal Neighbors
//
//  Created by Manuel Ambriz on 08/11/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import Foundation
import Alamofire

class FabricaSolicitudes {
    static let shared: FabricaSolicitudes = {
        let shared = FabricaSolicitudes()
        return shared
    }()
    
    init() {
        let url = NSURL (string : "https://neighbors-alertavecinal.herokuapp.com/appmovil/solicitud/new")
        let datos = NSData (contentsOf : url! as URL)
        do{
            
            let json1 = try JSONSerialization.jsonObject(with: datos! as Data, options: JSONSerialization.ReadingOptions.mutableLeaves)
            
            let dico1 = json1 as! NSDictionary
            let dico2 = dico1["redcamaras"] as! [NSDictionary]
            //print("Dico 2 \(dico2)")
            //print("Count \(dico2.count)")
            var contador: Int = 0
            
            for _ in dico2{
                
                let id = dico2[contador]["_id"] as? String ?? ""
                let calle = dico2[contador]["calle"] as? String ?? ""
                let colonia = dico2[contador]["colonia"] as? String ?? ""
                let ciudad = dico2[contador]["ciudad"] as? String ?? ""
                let estado = dico2[contador]["estado"] as? String ?? ""
                let user_id = dico2[contador]["user_id"] as? String ?? ""
                let jsonuser = dico2[contador]["user_id"] as! NSDictionary
                let propietario  = jsonuser["nombre"] as? String ?? ""
                let correopropietario = jsonuser["correo"] as? String ?? ""
               
                let Solicitudes = Solicitud(id: id, calle: calle, colonia: colonia, ciudad: ciudad, user_id: user_id, propietario: propietario,correopropietario: correopropietario, estado: estado)
                //print("id antes de enviar \(id)")
                
                self.solicitudes.append(Solicitudes)
                contador = contador+1
            }
            
        }
        catch _ {
            
        }
    }
    var solicitudes : [Solicitud] = []
    
    func getSolicitud(with SolicitudId: Int) -> Solicitud {
        return self.solicitudes[SolicitudId]
    }
}
