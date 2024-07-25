//
//  postDataModel.swift
//  SocioutApp
//
//  Created by swati mane on 10/09/22.
//

import Foundation

struct jsonstruct:Decodable {
    let userId : Int
    let id : Int
    let title : String
    let body : String
}

struct PostComment : Decodable{
    
    let postId : Int
    let id : Int
    let name : String
    let email : String
    let body : String
    
}
