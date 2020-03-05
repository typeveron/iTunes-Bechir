//
//  StoreItemController.swift
//  iTunesB
//
//  Created by Bechir Mihoub on 2020-02-24.
//  Copyright © 2020 Bechir Mihoub. All rights reserved.
//

import UIKit

class StoreItemController {


    func fetchItems(matching query: [String: String], completion: @escaping ([StoreItem]?) -> Void) {
        let baseURL = URL(string: "https://itunes.apple.com/search")!
        
        let url = baseURL.withQueries(query)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            
            if let data = data,
                let storeItems = try? jsonDecoder.decode(StoreItems.self, from: data) {
                completion(storeItems.results)
            
            } else {
                print("Either no data was returned, or data was not serialized.")
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    
    func testFunction() {
        
        
        let url = URL(string: "https://itunes.apple.com/search?term=bob&limit=10&lang=en_us&media=movie")!
        
         let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 else {
                    return
            }
            
            guard let data = data else {
                print("This is the error \(error.debugDescription)" )
                return
            }
            
            if let result = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as String? {
                print(result)
            }
            
            
        }
        
        task.resume()

    }

    
    func fetchItemArtwork(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }
}
