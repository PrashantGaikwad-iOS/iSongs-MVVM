//
//  TrackVC.swift
//  iSongs
//
//  Created by Prashant Gaikwad on 18/04/20.
//  Copyright © 2020 Prashant Gaikwad. All rights reserved.
//

import UIKit
import AVKit

class TrackVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tracksCollectionView: UICollectionView!

    //MARK: - Properties
    var trackViewModels = [TrackViewModel]()
    let cellId = "CellID"
    var searchController: UISearchController!

    //MARK: - View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    //MARK: - Custom Methods
    fileprivate func fetchData(searchText: String) {
        //let searchText = "jack+johnson"
        Service.shared.fetchTracks(searchKey: searchText) { (result, err) in
            if let err = err {
                print("Failed to fetch tracks:", err)
                return
            }
            let tracks = result?.results
            self.trackViewModels = tracks?.map({return TrackViewModel(track: $0)}) ?? []
            self.tracksCollectionView.reloadData()
            if self.trackViewModels.count > 0 {
                self.tracksCollectionView.scrollToItem(at: [0,0], at: .top, animated: true)
            }
        }
    }

    fileprivate func setupView() {
        navigationItem.hidesSearchBarWhenScrolling = false

        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search artist name here..."
        searchController.searchBar.delegate = self as UISearchBarDelegate
        searchController.searchBar.sizeToFit()
        self.definesPresentationContext = true
        navigationItem.searchController = searchController
    }

    private func openPlayer(urlString: String) {
        guard let url = URL(string: urlString) else {
            print("error")
            return
        }
        let player = AVPlayer(url: url)
        let controller = AVPlayerViewController()
        controller.player = player
        present(controller,animated: true){
            player.play()
        }
    }
}

//MARK: - CollectionView DataSource
extension TrackVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trackViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TrackCell
        let trackViewModel = trackViewModels[indexPath.row]
        cell.trackViewModel = trackViewModel
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let trackViewModel = trackViewModels[indexPath.row]
        openPlayer(urlString: trackViewModel.previewUrl)
    }
}

//MARK: - CollectionView Delegate
extension TrackVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (tracksCollectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
}

//MARK: - SearchBar Delegate
extension TrackVC: UISearchResultsUpdating,UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }


    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var finalString = searchBar.text?.replacingOccurrences(of: " ", with: "+")
        finalString = finalString?.lowercased()
        fetchData(searchText: finalString ?? "")
        searchBar.text = ""
        searchController.searchBar.resignFirstResponder()
        searchController.dismiss(animated: true, completion: nil)
    }
}
