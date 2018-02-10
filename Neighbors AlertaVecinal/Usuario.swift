//
//  Usuario.swift
//  Neighbors Alerta Vecinal Neighbors Alerta Vecinal Neighbors
//
//  Created by Manuel Ambriz on 20/11/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import Foundation
class Usuario {
    var id: String
    var correo: String
    var direccion: String
    var nombre: String
    var apellidomaterno: String
    var apellidopaterno: String
    init(id: String, correo: String, direccion: String, nombre: String, apellidomaterno: String, apellidopaterno: String  ) {
        self.id = id
        self.correo = correo
        self.direccion = direccion
        self.nombre = nombre
        self.apellidopaterno = apellidopaterno
        self.apellidomaterno = apellidomaterno
    }
}
