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
    @Published var photosSelection: Int = 100
    @Published var isPhotoPickerVisible = false
    @Published var filterSelected: FilterPicker = .views
    @Published var isFilterPickerVisible = false
    
    
    
    func getPhotos(numPhotos: Int){
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isLoading = true
            NetworkingManager.shared.downloadPhotos(numPhotos: numPhotos) { [weak self] result in
                switch result {
                case .success( let photos):
                    print("Download is success \(photos)")
                    print("Total photos \(photos.photos.photo.count)")
                    self?.photos = photos
                case .failure( let error):
                    switch error {
                    case .invalidURL:
                        self?.alertItem = AlertContext.invalidURL
                    case .invalidRequest:
                        self?.alertItem = AlertContext.invalidResponse
                        
                    case .invalidData:
                        self?.alertItem = AlertContext.invalidData
                        
                    case .unableToComplete:
                        self?.alertItem = AlertContext.unableToComplete
                    }
                }
                self?.isLoading = false
            }
            
        }
        
        
    }
    
}

