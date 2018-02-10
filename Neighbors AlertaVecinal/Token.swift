//
//  Token.swift
//  Neighbors AlertaVecinal
//
//  Created by Manuel Ambriz on 19/12/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import Foundation
class Token {
    var Token : String
    var user_id: String
    init(token: String, user_id: String) {
        self.Token = token
        self.user_id = user_id
    }
}
