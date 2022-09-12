//
//  MovieListTableViewCell.swift
//  Smarters Pro
//
//  Created by Keshav on 10/08/22.
//

import UIKit

class MovieListTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var movieListCollectionView: UICollectionView!
    
    var imageArray = ["ironman", "justice","lostcity","spidey","strange","thor","wonderw","ironman", "justice","lostcity","spidey","strange","thor","wonderw"]
    
    var collectionItemSelected: ((IndexPath)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    func createLayout() -> UICollectionViewLayout {
//
//        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
//
//            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
//            let item = NSCollectionLayoutItem(layoutSize: itemSize)
//            item.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 15.0)
//
//            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150.0))
//            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//
//            let section = NSCollectionLayoutSection(group: group)
//            section.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0)
//
//            section.orthogonalScrollingBehavior = .paging
//
//            return section
//        }
//
//        return layout
//    }
    
    var collectionViewOffset: CGFloat {
        set { movieListCollectionView.contentOffset.x = newValue }
        get { return movieListCollectionView.contentOffset.x }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        movieListCollectionView.frame = contentView.bounds
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as! MovieListCollectionViewCell
        cell.posterImageView.image = UIImage(named: imageArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionItemSelected?(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 230, height: 380)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func setCollectionViewDataSourceDelegate(forRow row: Int) {
        movieListCollectionView.delegate = self
        movieListCollectionView.dataSource = self
        movieListCollectionView.tag = row
        movieListCollectionView.setContentOffset(movieListCollectionView.contentOffset, animated: false)
        movieListCollectionView.register(UINib(nibName: "MovieListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieListCollectionViewCell")
//        movieListCollectionView.collectionViewLayout = createLayout()
        movieListCollectionView.reloadData()
    }
    
}
