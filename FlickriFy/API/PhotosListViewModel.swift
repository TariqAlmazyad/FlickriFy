//
//  PhotosListViewModel.swift
//  FlickriFy
//
//  Created by Tariq Almazyad on 12/1/20.
//

import Foundation

final class PhotosListViewModel: ObservableObject{
    @Published var photos: Photos?
    @Published var alertItem: AlertItem?
    @Published var isLoading: Bool = false
    @Published  var selectedPhoto: Photos?
    

    func getPhotos(numPhotos: Int){
        isLoading = true
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
        }
        isLoading = false
    }
    
}

