//
//  CamarasUICollectionView.swift
//  Neighbors Alerta Vecinal Neighbors Alerta Vecinal Neighbors
//
//  Created by Manuel Ambriz on 02/11/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import UIKit
private let reuseIdentifier = "CamarasCell"
var bandera: Int = 0;
var idredcamaras = [String]()
class CamarasUICollectionView: UICollectionView {
    
  

    override func numberOfItems(inSection section: Int) -> Int {
        //return FabricaDeRedCamaras.shared.redcamaras.count
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
        let camarasllenado = FabricaDeCamaras.init(idredcamara: idredcamaras)
        let count = camarasllenado.camaras.count
        return count
    }
    
 
    override func deselectItem(at indexPath: IndexPath, animated: Bool) {
        //let camaras 
    }


}
