//
//  FabricaDeUsuarios.swift
//  Neighbors Alerta Vecinal Neighbors Alerta Vecinal Neighbors
//
//  Created by Manuel Ambriz on 20/11/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import Foundation
class FabricaDeUsuarios {
    var idredcamara: String
    static let shared: FabricaDeUsuarios = {
        let shared = FabricaDeUsuarios(idredcamara: "")
        return shared
    }()
    init(idredcamara: String) {
        self.idredcamara = idredcamara
        print("idredcamara \(idredcamara)")
        if (idredcamara != ""){
        let url = NSURL (string : "https://neighbors-alertavecinal.herokuapp.com/appmovil/redescamaras/" + idredcamara + "/users" )
        let datos = NSData (contentsOf : url! as URL)
        do{
            let json1 = try JSONSerialization.jsonObject(with: datos! as Data, options: JSONSerialization.ReadingOptions.mutableLeaves)
            let dico1 = json1 as! NSDictionary
            let dico2 = dico1["solicitudunirse"] as! [NSDictionary]
            //print("Dico 2 \(dico2)")
            //print("Count \(dico2.count)")
            var contador: Int = 0
            
            for _ in dico2{
                let json = dico2[contador]["user_id"] as! NSDictionary
                contador = contador+1
                let id = json["_id"] as? String ?? ""
                let nombre = json["nombre"] as? String ?? ""
                let correo = json["correo"] as? String ?? ""
                let apellidopaterno = json["apellidopaterno"] as? String ?? ""
                let apellidomaterno = json["apellidomaterno"] as? String ?? ""
                //let direccion = json["direccion"] as? String ?? ""
                let direccion = json["domicilio"] as? String ?? ""
                let Usuarios = Usuario(id: id, correo: correo, direccion: direccion, nombre: nombre, apellidomaterno: apellidomaterno, apellidopaterno: apellidopaterno)
                //print("id antes de enviar \(id)")
                self.usuarios.append(Usuarios)
            }
        }
        catch _ {
            
        }
        }
    }
    var usuarios : [Usuario] = []
    
    func getUsuario(with UsuarioId: Int) -> Usuario {
        return self.usuarios[UsuarioId]
    }
}
