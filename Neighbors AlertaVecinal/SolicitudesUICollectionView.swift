//
//  SolicitudesUICollectionView.swift
//  Neighbors Alerta Vecinal Neighbors Alerta Vecinal Neighbors
//
//  Created by Manuel Ambriz on 08/11/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import UIKit

class SolicitudesUICollectionView: UICollectionView {

    override func numberOfItems(inSection section: Int) -> Int {
        return FabricaSolicitudes.init().solicitudes.count
    }
    override func deselectItem(at indexPath: IndexPath, animated: Bool) {
        //let camaras
    }
}
