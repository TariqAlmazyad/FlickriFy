//
//  NetworkingManager.swift
//  FlickriFy
//
//  Created by Tariq Almazyad on 11/30/20.
//

import UIKit
import CoreLocation

private let api_key = "d89fb63f9ad2c49fac5a0e26fa19e7f9"

enum NetworkError: Error {
    case invalidURL
    case invalidRequest
    case invalidData
    case unableToComplete
}

final class NetworkingManager {
    static let shared = NetworkingManager()
    
    private let lat = LocationManager.shared.currentLocation?.latitude ?? 0.0
    private let lon = LocationManager.shared.currentLocation?.longitude ?? 0.0
    
    private init () {}
    
    func downloadPhotos(numPhotos: Int ,completion: @escaping(Result<Photos, NetworkError>) -> Void) {
        let baseUrl = "https://api.flickr.com/services/rest?lat=\(lat)&format=json&media=photos&method=flickr.photos.search&api_key=\(api_key)&radius=20&nojsoncallback=1&per_page=\(numPhotos)&lon=\(lon)&extras=url_z,date_taken,geo,tags,views"
        
        guard let url = URL(string: baseUrl) else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let response = (response as? HTTPURLResponse)?.statusCode , response >= 400 {
                    completion(.failure(.invalidRequest))
                    return
                }
                if let error = error {
                    print(error)
                    completion(.failure(.unableToComplete))
                    return
                }
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                do {
                    let decodedData = try JSONDecoder().decode(Photos.self, from: data)
                    completion(.success(decodedData))
                } catch (let error){
                    print(error.localizedDescription)
                    completion(.failure(.invalidData))
                    return
                }
            }
        }.resume()
    }
}