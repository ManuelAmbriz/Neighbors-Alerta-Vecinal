//
//  CamarasCollectionViewCell.swift
//  Neighbors Alerta Vecinal Neighbors Alerta Vecinal Neighbors
//
//  Created by Manuel Ambriz on 01/11/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CamarasCell"

class CamarasCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var Propietario: UILabel!
    @IBOutlet weak var Calle: UILabel!
    @IBOutlet weak var Casa: UILabel!
    @IBOutlet weak var CameraImage: UIImageView!
    @IBOutlet weak var web: UIWebView!
    
}
