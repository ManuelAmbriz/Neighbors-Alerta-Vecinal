//
//  FabricaDeSolicitudes.swift
//  Neighbors AlertaVecinal
//
//  Created by Manuel Ambriz on 15/12/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import Foundation
class FabricaDeNotificaciones {
    static let shared: FabricaDeNotificaciones = {
        let shared = FabricaDeNotificaciones()
        return shared
    }()
    
    init() {
        print("Prueba de la fabrica de notificaciones")
        let url = NSURL (string : "https://neighbors-alertavecinal.herokuapp.com/appmovil/notificaciones")
        let datos = NSData (contentsOf : url! as URL)
        do{
            if (datos != nil){
            let json1 = try JSONSerialization.jsonObject(with: datos! as Data!, options: JSONSerialization.ReadingOptions.mutableLeaves)
            
            
            
            let dico1 = json1 as! NSDictionary
            let dico2 = dico1["notificaciones"] as! [NSDictionary]
            //print("dico1 \(dico1)")
            //print("Count \(dico2.count)")
            var contador: Int = 0
            
            for _ in dico2{
                let id = dico2[contador]["id"] as? String ?? ""
                let titulo = dico2[contador]["titulo"] as? String ?? ""
                let mensaje = dico2[contador]["mensaje"] as? String ?? ""
                let fecha = dico2[contador]["fecha"] as? String ?? ""
                let redcamaras = dico2[contador]["redcamaras_id"] as! NSDictionary
                    let redcamara_id = redcamaras["_id"] as? String ?? ""
                
                let json = dico2[contador]["user_id"] as! NSDictionary
                contador = contador+1
                    let user_id = json["_id"] as? String ?? ""
                    let nombre = json["nombre"] as? String ?? ""
                    let apellidopaterno = json["apellidopaterno"] as? String ?? ""
                    let apellidomaterno = json["apellidomaterno"] as? String ?? ""
                
                let Notificacion = Notificaciones(id: id, titulo: titulo, mensaje: mensaje, user_id: user_id, nombre: nombre, apellidopaterno: apellidopaterno, apellidomaterno: apellidomaterno, redcamara_id: redcamara_id, fecha: fecha )
                self.notificaciones.append(Notificacion)
            }
            
            let dico12 = dico1["notificacionsensor"] as! [NSDictionary]
            var contador1: Int = 0
            
            for _ in dico12{
                let id = dico12[contador1]["id"] as? String ?? ""
                let titulo = dico12[contador1]["titulo"] as? String ?? ""
                let mensaje = dico12[contador1]["mensaje"] as? String ?? ""
                let fecha = dico12[contador1]["fechaver"] as? String ?? ""
                contador1 = contador1 + 1
                
                let Notificacion = Notificaciones(id: id, titulo: titulo, mensaje: mensaje, user_id: " ", nombre: " ", apellidopaterno: " ", apellidomaterno: " ", redcamara_id: " ", fecha: fecha )
                self.notificaciones.append(Notificacion)
            }
            }
        }
        catch _ {
            
        }
    }
    var notificaciones : [Notificaciones] = []
    
    func getNotificaciones(with NotificacionId: Int) -> Notificaciones {
        print("Notificcionesid \(NotificacionId) \(self.notificaciones.count)")
        return self.notificaciones[NotificacionId]
    }
}
