//
//  SolicitudesEmitidas.swift
//  Neighbors Alerta Vecinal Neighbors Alerta Vecinal Neighbors
//
//  Created by Manuel Ambriz on 06/12/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import Foundation

class SolicitudesEmitidas{
    var id: String
    var calle: String
    var colonia: String
    var ciudad: String
    var estado: String
    var estatus: String
    
    init(id: String, calle: String, colonia: String, ciudad: String, estado: String, estatus: String) {
        self.id = id
        self.calle = calle
        self.colonia = colonia
        self.ciudad = ciudad
        self.estado = estado
        self.estatus = estatus
    }
}

