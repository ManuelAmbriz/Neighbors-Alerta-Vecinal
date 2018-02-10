
//
//  FabricaSolicitudes.swift
//  Neighbors Alerta Vecinal Neighbors Alerta Vecinal Neighbors
//
//  Created by Manuel Ambriz on 08/11/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import Foundation
import Alamofire

class FabricaSolicitudesEmitidas {
    static let shared: FabricaSolicitudesEmitidas = {
        let shared = FabricaSolicitudesEmitidas()
        return shared
    }()
    
    init() {
        let url = NSURL (string : "https://neighbors-alertavecinal.herokuapp.com/appmovil/solicitud")
        let datos = NSData (contentsOf : url! as URL)
        do{
            
            let json1 = try JSONSerialization.jsonObject(with: datos! as Data, options: JSONSerialization.ReadingOptions.mutableLeaves)
            
            let dico1 = json1 as! NSDictionary
            print("Dico1emitidas \(dico1)")
            let dico2 = dico1["solicitudunirse"] as! [NSDictionary]
            userid = dico1["user_id"] as? String ?? ""
            //print("Dico 2 \(dico2)")
            //print("Count \(dico2.count)")
            var contador: Int = 0
            
            for _ in dico2{
                
                let id = dico2[contador]["_id"] as? String ?? ""
                let estatus = dico2[contador]["estatus"] as? String ?? ""
                
                let jsonred = dico2[contador]["redcamaras_id"] as! NSDictionary
                let calle = jsonred["calle"] as? String ?? ""
                let colonia = jsonred["colonia"] as? String ?? ""
                let ciudad = jsonred["ciudad"] as? String ?? ""
                let estado = jsonred["estado"] as? String ?? ""
                let user_idcamaras = jsonred["user_id"] as? String ?? ""
                
                let user_idarray = dico2[contador]["user_id"] as! NSDictionary
                let user_id = user_idarray["_id"] as? String ?? ""
                
                
                let Solicitudes = SolicitudesEmitidas(id: id, calle: calle, colonia: colonia, ciudad: ciudad, estado: estado, estatus: estatus)
                //print("id antes de enviar \(id)")
                print("UserId \(user_id) \(user_idcamaras)")
                if(user_idcamaras != userid && estatus != "Aprobado"){self.solicitudes.append(Solicitudes)}
                contador = contador+1
            }
            
        }
        catch _ {
            
        }
    }
    var solicitudes : [SolicitudesEmitidas] = []
    var userid: String = ""
    
    func getSolicitud(with SolicitudId: Int) -> SolicitudesEmitidas {
        return self.solicitudes[SolicitudId]
    }
    func getUserIf() -> String{
        return userid
    }
}
