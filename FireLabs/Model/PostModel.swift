//
//  PostModel.swift
//  FireLabs
//
//  Created by Aba-Bakri on 7/1/20.
//  Copyright © 2020 Ababakri Ibragimov. All rights reserved.
//

import Foundation

class Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
    init(userId: Int, id: Int, title: String, body: String) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
}
