//
//  USolcitudesEnviarUICollectionView.swift
//  Neighbors Alerta Vecinal Neighbors Alerta Vecinal Neighbors
//
//  Created by Manuel Ambriz on 06/12/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import UIKit


class USolcitudesEnviarUICollectionView: UICollectionView {
    
    override func numberOfItems(inSection section: Int) -> Int {
        print("countcount2 \(FabricaSolicitudesEmitidas.shared.solicitudes.count)")
       return FabricaSolicitudesEmitidas.init().solicitudes.count
    }
    override func deselectItem(at indexPath: IndexPath, animated: Bool) {
        //let camaras
    }
}

