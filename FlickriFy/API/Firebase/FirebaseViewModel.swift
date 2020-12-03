//
//  FirebaseViewModel.swift
//  FlickriFy
//
//  Created by Tariq Almazyad on 12/3/20.
//

import Foundation
import FirebaseFirestore

final class FirebaseViewModel: ObservableObject {
    
    @Published var photos = [Photo]()
    @Published var isFavorite: Bool = false
    
    func fetchPhotosFromFirebase(completion: @escaping( [Photo]) -> Void){
        var photosDictionary: [String: Photo] = [:]
        Firestore.firestore().collection("my favorite").getDocuments { [weak self] (snapshot, error) in
            guard let self = self else {return}
            if let error = error {
                print("Unable to fetch data from firebase\(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else {return}
            self.photos = snapshot.documents.compactMap{try! $0.data(as: Photo.self)}
            self.photos.forEach { photo in
                let photoTemp = photo
                photosDictionary[photoTemp.id] = photo
            }
            
            self.photos = Array(photosDictionary.values)
            completion(self.photos)
        }
    }
    
}
