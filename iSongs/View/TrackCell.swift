//
//  TrackCell.swift
//  iSongs
//
//  Created by Prashant Gaikwad on 18/04/20.
//  Copyright © 2020 Prashant Gaikwad. All rights reserved.
//

import Foundation
import UIKit

class TrackCell: UICollectionViewCell {

    @IBOutlet weak var trackNameLbl: UILabel!
    @IBOutlet weak var artistNameLbl: UILabel!
    @IBOutlet weak var trackArtworkImgView: UIImageView!

    var trackViewModel: TrackViewModel! {
        didSet {
            trackNameLbl.text = trackViewModel.trackName
            artistNameLbl.text = trackViewModel.artistName
            guard let url = URL(string: trackViewModel.trackArtImgString) else { return }
            UIImage.loadFrom(url: url) { image in
                self.trackArtworkImgView.image = image
            }
        }
    }
}
