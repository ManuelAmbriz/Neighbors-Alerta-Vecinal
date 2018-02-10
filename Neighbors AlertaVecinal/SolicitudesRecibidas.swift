//
//  SolicitudesRecibidas.swift
//  Neighbors Alerta Vecinal Neighbors Alerta Vecinal Neighbors
//
//  Created by Manuel Ambriz on 07/12/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import Foundation
class SolicitudesRecibidas{
    var id: String
    var calle: String
    var colonia: String
    var ciudad: String
    var estado: String
    var estatus: String
    var user_id: String
    var propietario: String
    var correopropietario: String
    
    init(id: String, calle: String, colonia: String, ciudad: String, estado: String, estatus: String, user_id: String, propietario: String, correopropietario: String) {
        self.id = id
        self.calle = calle
        self.colonia = colonia
        self.ciudad = ciudad
        self.estado = estado
        self.estatus = estatus
        self.user_id = user_id
        self.propietario = propietario
        self.correopropietario = correopropietario
    }
}
