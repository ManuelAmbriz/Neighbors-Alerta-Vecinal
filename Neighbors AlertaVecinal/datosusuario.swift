//
//  FabricaDeSolicitudes.swift
//  Neighbors AlertaVecinal
//
//  Created by Manuel Ambriz on 15/12/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import Foundation
class datosusuario {
    static let shared: datosusuario = {
        let shared = datosusuario()
        return shared
    }()
    init() {

            let url = NSURL (string : "https://neighbors-alertavecinal.herokuapp.com/appmovil/usuario")
            let datos = NSData (contentsOf : url! as URL)
            do{
                let json1 = try JSONSerialization.jsonObject(with: datos! as Data, options: JSONSerialization.ReadingOptions.mutableLeaves)
                
                let dico1 = json1 as! NSDictionary
                let id = dico1["_id"] as? String ?? ""
                let nombre = dico1["nombre"] as? String ?? ""
                let correo = dico1["correo"] as? String ?? ""
                let apellidopaterno = dico1["apellidopaterno"] as? String ?? ""
                let apellidomaterno = dico1["apellidomaterno"] as? String ?? ""
                
                let Usuarios = Usuario(id: id, correo: correo, direccion: "", nombre: nombre, apellidomaterno: apellidomaterno, apellidopaterno: apellidopaterno)
                    //print("id antes de enviar \(id)")
                    self.usuarios.append(Usuarios)
                }
            
            catch _ {
                
            }
        
    }
    var usuarios : [Usuario] = []
    
    func getUsuario(with UsuarioId: Int) -> Usuario {
        return self.usuarios[UsuarioId]
    }
}



