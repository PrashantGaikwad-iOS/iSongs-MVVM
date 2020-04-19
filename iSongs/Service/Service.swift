//
//  Service.swift
//  iSongs
//
//  Created by Prashant Gaikwad on 18/04/20.
//  Copyright © 2020 Prashant Gaikwad. All rights reserved.
//

import Foundation

// Service to fetch Server data
class Service: NSObject {
    static let shared = Service()

    func fetchTracks(searchKey:String,completion: @escaping (Result?, Error?) -> ()) {
        let urlString = "https://itunes.apple.com/search?term=\(searchKey)" //&limit=50
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                print("Failed to fetch result:", err)
                return
            }

            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(Result.self, from: data)
                DispatchQueue.main.async {
                    completion(result, nil)
                }
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
        }.resume()
    }
}
