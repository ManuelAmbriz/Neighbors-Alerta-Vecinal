
//
//  UsuarioRedUICollectionView.swift
//  Neighbors Alerta Vecinal Neighbors Alerta Vecinal Neighbors
//
//  Created by Manuel Ambriz on 20/11/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import UIKit

class UsuarioRedUICollectionView: UICollectionView {
    var bandera: Int = 0;
    var idredcamaras = [String]()
    override func numberOfItems(inSection section: Int) -> Int {
        let redcamarascount = FabricaDeRedCamaras.shared.redcamaras.count
        if(redcamarascount > 0){
            if(bandera==0){
                    for index in 0...redcamarascount-1 {
                        let redcamaras = FabricaDeRedCamaras.shared.getRedCamaras(with: index)
                        idredcamaras.append(redcamaras.id)
                    }
                
                bandera=1
            }
            
            let usuariosllenado = FabricaDeUsuarios.init(idredcamara: idredcamaras[0])
            let count = usuariosllenado.usuarios.count
            
            return count
        }
        else {return 0}
    }
}
