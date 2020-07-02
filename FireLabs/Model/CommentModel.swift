//
//  CommentModel.swift
//  FireLabs
//
//  Created by Aba-Bakri on 7/1/20.
//  Copyright © 2020 Ababakri Ibragimov. All rights reserved.
//

import Foundation

class Comment: Codable {
    let id: Int
    let name: String
    let email: String
    let body: String
    
    init(id: Int, name: String, email: String, body: String) {
        self.id = id
        self.name = name
        self.email = email
        self.body = body
    }
}
