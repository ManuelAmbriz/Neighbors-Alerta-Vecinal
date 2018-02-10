//
//  Camaras.swift
//  Neighbors Alerta Vecinal Neighbors Alerta Vecinal Neighbors
//
//  Created by Manuel Ambriz on 27/10/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import Foundation


class Camaras: NSObject{
    var id : String
    var numeroex: String
    var calle:String
    var propietario:String
    var ip: String
    
    init (id: String, numeroex: String, calle: String, propietario: String, ip: String ){
        self.id=id
        self.numeroex = numeroex
        self.calle = calle
        self.propietario=propietario       
        self.ip = ip
   
    }
}
