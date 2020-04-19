//
//  TrackViewModel.swift
//  iSongs
//
//  Created by Prashant Gaikwad on 18/04/20.
//  Copyright © 2020 Prashant Gaikwad. All rights reserved.
//

import Foundation
import UIKit

struct TrackViewModel {

    let trackName: String
    let artistName: String
    let trackArtImgString: String
    let previewUrl: String

    // Dependency Injection (DI)
    init(track: Track) {
        self.trackName = track.trackName ?? "-"
        self.artistName = track.artistName ?? "-"
        self.trackArtImgString = track.artworkUrl100 ?? ""
        self.previewUrl = track.previewUrl ?? ""
    }

}
