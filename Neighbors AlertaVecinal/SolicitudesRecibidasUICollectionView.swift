//
//  SolicitudesRecibidasUICollectionView.swift
//  Neighbors Alerta Vecinal Neighbors Alerta Vecinal Neighbors
//
//  Created by Manuel Ambriz on 07/12/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import UIKit

class SolicitudesRecibidasUICollectionView: UICollectionView {
     override func numberOfItems(inSection section: Int) -> Int {
        let redcamarascount = FabricaDeRedCamaras.shared.redcamaras.count
        if(bandera==0){
            if(redcamarascount > 0){
                for index in 0...redcamarascount-1 {
                    let redcamaras = FabricaDeRedCamaras.shared.getRedCamaras(with: index)
                    idredcamaras.append(redcamaras.id)
                }
                bandera=1
            }
        }
        if idredcamaras.count > 0 {
            let camarasllenado = FabricaSolicitudesRecibidas.init(idredcamara: idredcamaras[0])
            let count = camarasllenado.solicitudes.count
            print("countcount \(count)")
            return count
        }
        else {return 0}
    }
    
}
