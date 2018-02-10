//
//  NotificacionesUICollectionView.swift
//  Neighbors AlertaVecinal
//
//  Created by Manuel Ambriz on 15/12/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import UIKit


class NotificacionesUICollectionView: UICollectionView {
    override func numberOfItems(inSection section: Int) -> Int  {
        print("notificacionesprueba 2 \(FabricaDeNotificaciones.init().notificaciones.count)")
        return FabricaDeNotificaciones.init().notificaciones.count
    }
}
