//
//  NetworkingManager.swift
//  FlickriFy
//
//  Created by Tariq Almazyad on 11/30/20.
//

import UIKit
import CoreLocation



enum NetworkError: Error {
    case invalidURL
    case invalidRequest
    case invalidData
    case unableToComplete
}

final class NetworkingManager {
    static let shared = NetworkingManager()
    private let cache = NSCache<NSString, UIImage>()
//    private let lat = LocationManager.shared.currentLocation?.latitude ?? 0.0
//    private let lon = LocationManager.shared.currentLocation?.longitude ?? 0.0
    public let api_key = "d89fb63f9ad2c49fac5a0e26fa19e7f9"
    private init () {}
    
    /// Make API call with number of desired photos
    /// - Parameters:
    ///   - numPhotos: total displayed photos in view
    ///   - completion: once the request finishes, it escapes with result
    func downloadPhotos(numPhotos: Int ,completion: @escaping(Result<Photos, NetworkError>) -> Void) {
        let baseUrl = "https://api.flickr.com/services/rest?lat=\(LocationManager.location.latitude)&format=json&media=photos&method=flickr.photos.search&api_key=\(api_key)&radius=20&nojsoncallback=1&per_page=\(numPhotos)&lon=\(LocationManager.location.longitude)&extras=url_z,date_taken,geo,tags,views"
        
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
    
    
    
    /// Ability to download image and cache it without re-downloading it again
    /// - Parameters:
    ///   - urlString: image url as String
    ///   - completed: once the function successfully finishes, it escapes with an optional image as  UIImage? 
    func downloadImage(fromURLString urlString: String, completed: @escaping(UIImage?) -> Void){
        
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey){
            completed(image)
            return
        }
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
    }
}
