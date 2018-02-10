//
//  RedCamaras.swift
//  Neighbors Alerta Vecinal Neighbors Alerta Vecinal Neighbors
//
//  Created by Manuel Ambriz on 31/10/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import Foundation
class RedCamaras {
    
    var id: String
    var calle: String
    var numeromin: String
    var numeromax: String
    var colonia: String
    var ciudad: String
    var estado: String
    var cp: String
    var estatus: String
    var user_id: String
    var notificacion: String
    
    init(id: String, calle: String, numeromin: String, numeromax: String, colonia: String, ciudad: String, estado: String, cp: String, estatus: String, user_id: String , notificacion: String) {
        self.id = id
        self.calle = calle
        self.numeromax = numeromax
        self.numeromin = numeromin
        self.colonia = colonia
        self.ciudad = ciudad
        self.estado = estado
        self.cp = cp
        self.estatus = estatus
        self.user_id = user_id
        self.notificacion = notificacion
    }
}
