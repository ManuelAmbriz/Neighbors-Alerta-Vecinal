//
//  FabricaDeTokens.swift
//  Neighbors AlertaVecinal
//
//  Created by Manuel Ambriz on 19/12/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import Foundation
import Alamofire

class FabricaDeTokens {
    let redcamara: String
    static let shared: FabricaDeTokens =  {
        let shared = FabricaDeTokens(redcamara: "")
        return shared
    }()
    init(redcamara: String){
        self.redcamara = redcamara
        let url = NSURL (string : "https://neighbors-alertavecinal.herokuapp.com/appmovil/token/\(redcamara)")
        let datos = NSData (contentsOf : url! as URL)
        do{
            
            let json1 = try JSONSerialization.jsonObject(with: datos! as Data, options: JSONSerialization.ReadingOptions.mutableLeaves)
            let dico1 = json1 as! NSDictionary
            print("Dico1 \(dico1)")
            let dico2 = dico1["tokens"] as! [NSDictionary]
            //print("Dico 2 \(dico2)")
            //print("Count \(dico2.count)")
            var contador: Int = 0
            
            for _ in dico2{
                
                let id = dico2[contador]["_id"] as? String ?? ""
                let token = dico2[contador]["token"] as? String ?? ""
                let user_id = dico2[contador]["user_id"] as? String ?? ""
                let Tokens = Token(token: token, user_id: user_id)
          
                self.token.append(Tokens)
                contador = contador+1        }
        }
        catch {
            print("Error")
        }
    }
    
    var token : [Token] = []
        
    func getToken(with Tokenid: Int) -> Token {
            return self.token[Tokenid]
        }
    
}
