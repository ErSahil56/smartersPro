//
//  MovieListTableViewCell.swift
//  Smarters Pro
//
//  Created by Keshav on 10/08/22.
//

import UIKit

class MovieListTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var movieListCollectionView: UICollectionView!
    
    var imageArray = [UIImage(named: "Avtar")!, UIImage(named: "XMen")!,UIImage(named: "Pirates")!,UIImage(named: "Dracula")!,UIImage(named: "Carrie")!,UIImage(named: "CaptainAmerica")!]

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionvView()
        // Initialization code
    }
    
    func setUpCollectionvView(){
        movieListCollectionView.delegate = self
        movieListCollectionView.dataSource = self
        movieListCollectionView.register(UINib(nibName: "MovieListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieListCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath)as! MovieListCollectionViewCell
        cell.posterImageView.image = imageArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: (collectionView.frame.size.width - 50) / 5, height: collectionView.frame.size.height )
    }

}
