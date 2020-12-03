//
//  FirebaseViewModel.swift
//  FlickriFy
//
//  Created by Tariq Almazyad on 12/3/20.
//

import Foundation
import FirebaseFirestore
import SwiftUI

final class FirebaseViewModel: ObservableObject {
    
    @Published var photos = [Photo]()
    @Published var isFavorite: Bool = false
    
    // get photos from firebase
    func fetchPhotosFromFirebase(){
        var photosDictionary: [String: Photo] = [:]
        Firestore.firestore().collection("my favorite").addSnapshotListener { [weak self] (snapshot, error) in
            guard let self = self else {return}
            if let error = error {
                print("Unable to fetch data from firebase\(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot?.documentChanges else {return}
            self.photos = snapshot.compactMap{ try? $0.document.data(as: Photo.self)}
            // simple solution to avoid duplicate document by using dictionary IDs , since each id is unique .
            self.photos.forEach { photo in
                let photoTemp = photo
                photosDictionary[photoTemp.id] = photo
            }
            
            self.photos = Array(photosDictionary.values)
        }
    }
    // delete chosen photo
    func deleteItem(at offsets: IndexSet){
        if let photo = photos.enumerated().first(where: {$0.offset == offsets.first}) {
            DispatchQueue.main.async { [weak self] in
                self?.photos.remove(atOffsets: offsets)
                FirebaseManager.shared.favoriteManager(.deleteFavorite, photo: photo.element) { error in
                    if let error = error {
                        print("DEBUG: error while deleting item\(error.localizedDescription)")
                        return
                    }
                    self?.fetchPhotosFromFirebase()
                }
            }
        }
    }
}
