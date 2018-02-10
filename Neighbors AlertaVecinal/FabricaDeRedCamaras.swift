//
//  FabricaDeRedCamaras.swift
//  Neighbors Alerta Vecinal Neighbors Alerta Vecinal Neighbors
//
//  Created by Manuel Ambriz on 31/10/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import Foundation
import Alamofire

class FabricaDeRedCamaras {
    static let shared: FabricaDeRedCamaras = {
        let shared = FabricaDeRedCamaras()
        return shared
    }()
    
    init() {
        let url = NSURL (string : "https://neighbors-alertavecinal.herokuapp.com/appmovil/redescamaras")
        let datos = NSData (contentsOf : url! as URL)
        do{
            
            let json1 = try JSONSerialization.jsonObject(with: datos! as Data, options: JSONSerialization.ReadingOptions.mutableLeaves)
            
            let dico1 = json1 as! NSDictionary
             let dico2 = dico1["solicitudunirse"] as! [NSDictionary]
            //print("Dico 2 \(dico2)")
            //print("Count \(dico2.count)")
            var contador: Int = 0
            
            for _ in dico2{
            let json = dico2[contador]["redcamaras_id"] as! NSDictionary
            contador = contador+1
            let id = json["_id"] as? String ?? ""
            let calle = json["calle"] as? String ?? ""
            let numeromax = json["numeromax"] as? String ?? ""
            let numeromin = json["numeromin"] as? String ?? ""
            let colonia = json["colonia"] as? String ?? ""
            let ciudad = json["ciudad"] as? String ?? ""
            let estado = json["estado"] as? String ?? ""
            let cp = json["cp"] as? String ?? ""
            let estatus = json["estatus"] as? String ?? ""
            let user_id = json["user_id"] as? String ?? ""
            let notificacion = json["notificaiones"] as? String ?? ""
                let RedCamara = RedCamaras(id: id, calle: calle,numeromin: numeromin, numeromax:numeromax, colonia:colonia, ciudad:ciudad, estado:estado, cp:cp , estatus:estatus , user_id:user_id, notificacion: notificacion)
            //print("id antes de enviar \(id)")
            self.redcamaras.append(RedCamara)
            }
            
        }
        catch _ {
            
        }
    }
    var redcamaras : [RedCamaras] = []
    
    func getRedCamaras(with RedCamarasId: Int) -> RedCamaras {
        return self.redcamaras[RedCamarasId]
    }
}
