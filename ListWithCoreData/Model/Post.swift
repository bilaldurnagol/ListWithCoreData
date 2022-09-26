//
//  Post.swift
//  ListWithCoreData
//
//  Created by Bilal Durnagöl on 23.09.2022.
//

import Foundation

struct Post: Identifiable, Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}

/*
 {
     "albumId": 1,
     "id": 1,
     "title": "accusamus beatae ad facilis cum similique qui sunt",
     "url": "https://via.placeholder.com/600/92c952",
     "thumbnailUrl": "https://via.placeholder.com/150/92c952"
   }
 */
