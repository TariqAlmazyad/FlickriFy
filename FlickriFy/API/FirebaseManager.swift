//
//  FirebaseManager.swift
//  FlickriFy
//
//  Created by Tariq Almazyad on 12/3/20.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
//
//enum Firebase {
//    case <#case#>
//}

final class FirebaseManager{
    
    static let shared = FirebaseManager()
    
    private init() {}
    
    func addToMyFavorite(_ photo: Photo, completion: ((Error?) -> Void)?) {
        do {
            try Firestore.firestore().collection("my favorite").document(photo.id).setData(from: photo, completion: completion)
        } catch (let error){
            print("error while uploading photo to firebase \(error.localizedDescription)")
        }
    }
    
}
