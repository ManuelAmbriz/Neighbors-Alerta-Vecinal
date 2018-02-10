//
//  Solicitud.swift
//  Neighbors Alerta Vecinal Neighbors Alerta Vecinal Neighbors
//
//  Created by Manuel Ambriz on 08/11/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import Foundation

class Solicitud{
    var id: String
    var calle: String
    var colonia: String
    var ciudad: String
    var estado: String
    var user_id: String
    var propietario: String
    var correopropietario: String
    
    init(id: String, calle: String, colonia: String, ciudad: String, user_id: String, propietario: String, correopropietario: String, estado: String) {
        self.id = id
        self.calle = calle
        self.colonia = colonia
        self.ciudad = ciudad
        self.estado = estado
        self.user_id = user_id
        self.propietario = propietario
        self.correopropietario = correopropietario
    }
}
