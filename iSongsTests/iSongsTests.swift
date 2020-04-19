//
//  iSongsTests.swift
//  iSongsTests
//
//  Created by Prashant Gaikwad on 19/04/20.
//  Copyright © 2020 Prashant Gaikwad. All rights reserved.
//

import XCTest
@testable import iSongs

class iSongsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Test the View Model
    func testTrackViewModel() {
        let track = Track(trackId: 1, trackName: "Jack", artistName: "Francis Ford Coppola", artworkUrl100: "https://is2-ssl.mzstatic.com/image/thumb/Music118/v4/24/46/97/24469731-f56f-29f6-67bd-53438f59ebcb/source/100x100bb.jpg",previewUrl:"https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview118/v4/94/25/9c/94259c23-84ee-129d-709c-577186cbe211/mzaf_5653537699505456197.plus.aac.p.m4a")
        let trackViewModel = TrackViewModel(track: track)
        XCTAssertEqual(track.artistName, trackViewModel.artistName)
        XCTAssertEqual(track.trackName, trackViewModel.trackName)
        XCTAssertEqual(track.artworkUrl100, trackViewModel.trackArtImgString)
    }

}
