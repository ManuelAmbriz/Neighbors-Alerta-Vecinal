//
//  AuthFuntion.swift
//  Neighbors Alerta Vecinal Neighbors Alerta Vecinal Neighbors
//
//  Created by Manuel Ambriz on 15/10/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import Foundation
import Alamofire

class AuthService {
    var id:String = ""
    var prueba:String = ""

    
    func Auth(correo: String, contraseña: String, completion: @escaping (_ Auth: Int, _ user_id: String) -> Void){
        //print("Entro a Auntentifcar ")
        Alamofire.request("https://neighbors-alertavecinal.herokuapp.com/sessionsapp", method: .post, parameters: ["email": correo, "contraseña": contraseña ]).responseJSON { response in
            //print("Request: \(String(describing: response.request))")   // original url request
            //print("Response: \(String(describing: response.response))") // https url response
            //print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value as? [String: Any] {
                print("JSON: \(json)")
                self.id = json["correo"] as? String ?? ""
                 print("ID \(self.id)")
                if(correo == self.id){
                    //print("ID \(self.id)")
                    completion(1, json["_id"] as? String ?? "")
                }
                else{
                    //print("ID \(self.id)")
                    completion(2, "")}
                
                
            }
            else {
                completion(3, "")
            }
        }
        print(self.Auth)
    }

}

