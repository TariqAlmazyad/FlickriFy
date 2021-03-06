//
//  PhotosListViewModel.swift
//  FlickriFy
//
//  Created by Tariq Almazyad on 12/1/20.
//

import Foundation
import CoreLocation
final class PhotosViewModel: ObservableObject{
    
    @Published var photos: Photos?
    @Published var alertItem: AlertItem?
    @Published var isLoading: Bool = true
    @Published var selectedPhoto: Photos?
    @Published var numOfSelectedPhotos: Int = 20
    @Published var isPhotoPickerVisible = false
    @Published var filterSelected: FilterPicker = .views
    @Published var isFilterPickerVisible = false
    
    
    var isPickerVisible: Bool {
        return isPhotoPickerVisible
            || isFilterPickerVisible
    }
    
    // to allow user to sort photos based on views or datetaken
    var filteredPhotos: [Photo] {
        switch filterSelected {
        case .postedDate:
            return photos?.photos.photo.sorted { $0.datetaken > $1.datetaken } ?? []
        case .views:
            return photos?.photos.photo.sorted { Int($0.views)! > Int($1.views)! } ?? []
        }
    }
    
    // fetch photos with desired limit
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
                    print("Current Location is \(LocationManager.location.latitude)")
                    print("Current Location is \(LocationManager.location.longitude)")
                    
                case .failure( let error):
                    switch error {
                    // display error if we have invalid link
                    case .invalidURL:
                        self.alertItem = AlertContext.invalidURL
                        // display error if we have invalid Request
                    case .invalidRequest:
                        self.alertItem = AlertContext.invalidResponse
                        // display error if we have invalid Data struct 
                    case .invalidData:
                        self.alertItem = AlertContext.invalidData
                        // display error if we have internet connection
                    case .unableToComplete:
                        self.alertItem = AlertContext.connectionError
                    }
                }
                self.isLoading = false
            }
            
        }
    }
    
}

