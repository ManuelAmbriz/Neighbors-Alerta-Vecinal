//
//  Notificaciones.swift
//  Neighbors AlertaVecinal
//
//  Created by Manuel Ambriz on 15/12/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import Foundation
class Notificaciones {
    var id: String
    var titulo: String
    var mensaje: String
    var user_id: String
        var nombre: String
        var apellidopaterno: String
        var apellidomaterno: String
    
    var redcamara_id: String
    var fecha : String
    init(id: String, titulo: String, mensaje: String, user_id: String, nombre: String, apellidopaterno: String, apellidomaterno: String, redcamara_id: String, fecha: String) {
        self.id = id
        self.titulo = titulo
        self.mensaje = mensaje
        self.user_id = user_id
        self.nombre = nombre
        self.apellidomaterno = apellidomaterno
        self.apellidopaterno = apellidopaterno
        self.redcamara_id = redcamara_id
        self.fecha = fecha
    }
}
