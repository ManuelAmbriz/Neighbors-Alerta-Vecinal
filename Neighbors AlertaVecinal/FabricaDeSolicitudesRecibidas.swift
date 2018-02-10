
//
//  FabricaSolicitudes.swift
//  Neighbors Alerta Vecinal Neighbors Alerta Vecinal Neighbors
//
//  Created by Manuel Ambriz on 08/11/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import Foundation
import Alamofire

class FabricaSolicitudesRecibidas {
    var idredcamara: String
    static let shared: FabricaSolicitudesRecibidas = {
        let shared = FabricaSolicitudesRecibidas(idredcamara: "")
        return shared
    }()
    
    init(idredcamara: String) {
        self.idredcamara = idredcamara
        
        let url = NSURL (string : "https://neighbors-alertavecinal.herokuapp.com/appmovil/solicitud/\(idredcamara)")
        let datos = NSData (contentsOf : url! as URL)
        do{
            
            let json1 = try JSONSerialization.jsonObject(with: datos! as Data, options: JSONSerialization.ReadingOptions.mutableLeaves)
            
            let dico1 = json1 as! NSDictionary
            print("Dico1recibidas \(dico1)")
            let dico2 = dico1["solicitudunirse"] as! [NSDictionary]
            //print("Dico 2 \(dico2)")
            //print("Count \(dico2.count)")
            var contador: Int = 0
            
            for _ in dico2{
                
                let id = dico2[contador]["_id"] as? String ?? ""
                let estatus = dico2[contador]["estatus"] as? String ?? ""
                let user_id = dico2[contador]["user_id"] as? String ?? ""
                
                let jsonred = dico2[contador]["redcamaras_id"] as! NSDictionary
                let calle = jsonred["calle"] as? String ?? ""
                let colonia = jsonred["colonia"] as? String ?? ""
                let ciudad = jsonred["ciudad"] as? String ?? ""
                let estado = jsonred["estado"] as? String ?? ""
                
                
                let jsonuser = dico2[contador]["user_id"] as! NSDictionary
                let name  = jsonuser["nombre"] as? String ?? ""
                let appa = jsonuser["apellidopaterno"] as? String ?? ""
                let apma = jsonuser["apellidomaterno"] as? String ?? ""
                let propietario = "\(name) \(appa) \(apma)"
                let correopropietario = jsonuser["correo"] as? String ?? ""
                
                
                
                let Solicitudes = SolicitudesRecibidas(id: id, calle: calle, colonia: colonia, ciudad: ciudad, estado: estado, estatus: estatus, user_id: user_id, propietario: propietario,correopropietario: correopropietario)
                //print("id antes de enviar \(id)")
                self.solicitudes.append(Solicitudes)
                contador = contador+1
            }
            
        }
        catch _ {
            
        }
    }
    var solicitudes : [SolicitudesRecibidas] = []
    
    func getSolicitud(with SolicitudId: Int) -> SolicitudesRecibidas {
        print("countcount \(solicitudes.count) solicitudID \(SolicitudId)")
        return self.solicitudes[SolicitudId]
        
    }
}

