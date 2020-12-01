//
//  PhotosListViewModel.swift
//  FlickriFy
//
//  Created by Tariq Almazyad on 12/1/20.
//

import Foundation
import CoreLocation
final class PhotosListViewModel: ObservableObject{
    
    @Published var photos: Photos?
    @Published var alertItem: AlertItem?
    @Published var isLoading: Bool = true
    @Published var selectedPhoto: Photos?
    @Published var numOfSelectedPhotos: Int = 20
    @Published var isPhotoPickerVisible = false
    @Published var filterSelected: FilterPicker = .views
    @Published var isFilterPickerVisible = false
    
<<<<<<< HEAD
    var filteredPhotos: [Photo] {
        if filterSelected == .postedDate {
            return photos?.photos.photo.sorted{ $0.datetaken > $1.datetaken} ?? []
        } else {
            return   photos?.photos.photo.sorted{ Int($0.views) ?? 0 > Int($1.views) ?? 0} ?? []
        }
    }
=======
    
    var isPickerVisible: Bool {
        return isPhotoPickerVisible
            || isFilterPickerVisible
    }
    
    var filteredPhotos: [Photo] {
        switch filterSelected {
        case .postedDate:
            return photos?.photos.photo.sorted { $0.datetaken > $1.datetaken } ?? []
        case .views:
            return photos?.photos.photo.sorted { Int($0.views)! > Int($1.views)! } ?? []
        }
    }
    
>>>>>>> starting-unit-testing
    
    func getPhotos(numPhotos: Int){
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let  self  = self else{return}
            self.isLoading = true
            
            NetworkingManager.shared.downloadPhotos(numPhotos: numPhotos) { [weak self] result in
                guard let  self  = self else{return}
                
                switch result {
                case .success( let photos):
                    print("Download is success \(photos)")
                    print("Total photos \(photos.photos.photo.count)")
                    self.photos = photos
                    
                    
                case .failure( let error):
                    switch error {
                    case .invalidURL:
                        self.alertItem = AlertContext.invalidURL
                    case .invalidRequest:
                        self.alertItem = AlertContext.invalidResponse
                        
                    case .invalidData:
                        self.alertItem = AlertContext.invalidData
                        
                    case .unableToComplete:
                        self.alertItem = AlertContext.connectionError
                    }
                }
                self.isLoading = false
            }
            
        }
    }
    
}

