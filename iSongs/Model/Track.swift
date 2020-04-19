//
//  Song.swift
//  iSongs
//
//  Created by Prashant Gaikwad on 18/04/20.
//  Copyright © 2020 Prashant Gaikwad. All rights reserved.
//

import Foundation

struct Result: Decodable {
    let resultCount: Int?
    let results: [Track]?
}

struct Track: Decodable {
    let trackId: Int?
    let trackName: String?
    let artistName: String?
    let artworkUrl100: String?
    let previewUrl: String?
}
