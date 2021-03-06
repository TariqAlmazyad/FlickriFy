//
//  Model.swift
//  FlickriFy
//
//  Created by Tariq Almazyad on 11/30/20.
//

import Foundation

struct Photos: Codable , Hashable {
    let photos: PhotosData
}

struct PhotosData: Codable, Hashable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: String
    let photo: [Photo]
}

struct Photo: Codable, Hashable, Identifiable {
    let id: String
    let title : String
    let datetaken : String
    let views : String
    let tags : String
    let latitude : String
    let longitude : String
    let accuracy : String
    let url_z : URL
}


