//
//  FirebaseManager.swift
//  FlickriFy
//
//  Created by Tariq Almazyad on 12/3/20.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

enum FirebaseFavorite {
    case addFavorite
    case deleteFavorite
}

final class FirebaseManager{
    
    static let shared = FirebaseManager()
    
    private init() {}
    
    //    func addToMyFavorite(_ photo: Photo, completion: ((Error?) -> Void)?) {
    //        do {
    //            try Firestore.firestore().collection("my favorite").document(photo.id).setData(from: photo, completion: completion)
    //        } catch (let error){
    //            print("error while uploading photo to firebase \(error.localizedDescription)")
    //        }
    //    }
    //
    //
    //    func deleteMyFavorite(_ photoId: String, completion: ((Error?) -> Void)?) {
    //        Firestore.firestore().collection("my favorite").document(photoId).delete(completion: completion)
    //    }
    
    
    /// Favorite manager to manage your favorites by save photos or delete them
    /// - Parameters:
    ///   - operationType: enum case which you add or delete a photo
    ///   - photo: Photo type
    ///   - completion: once the func finishes executed, it escapes with result of success or error
    func favoriteManager(_ operationType: FirebaseFavorite, photo: Photo ,  completion: ((Error?) -> Void)?) {
        
        switch operationType {
        case .addFavorite:
            do {
                try Firestore.firestore().collection("my favorite").document(photo.id).setData(from: photo, completion: completion)
            } catch (let error){
                print("error while uploading photo to firebase \(error.localizedDescription)")
            }
            
        case .deleteFavorite:
            Firestore.firestore().collection("my favorite").document(photo.id).delete(completion: completion)
        }
    }
    
}
