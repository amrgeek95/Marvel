//
//  MarvelCharacterTableViewCell.swift
//  Marvel
//
//  Created by Mac on 23/11/2022.
//

import UIKit

class MarvelCharacterTableViewCell: UITableViewCell  , UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemCollectionView: UICollectionView!
    static let cellIdentifier = "MarvelCharacterTableViewCell"
    var items = [Item]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    static func nib () ->UINib {
        return UINib(nibName: cellIdentifier, bundle: nil)
    }
    func configure(with items : resultItem,title:String){
        self.titleLabel.text = title
        self.itemCollectionView.reloadData()
        self.items = items.items
        //register cell
        itemCollectionView.register(MarvelCharactersCollectionViewCell.nib(), forCellWithReuseIdentifier: MarvelCharactersCollectionViewCell.cellIdentifier)

        
        // set delegate
        self.itemCollectionView.delegate = self
        self.itemCollectionView.dataSource = self
        //
        self.itemCollectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension MarvelCharacterTableViewCell {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // dataArary is the managing array for your UICollectionView.
        
        return CGSize(width: UIScreen.main.bounds.size.width / 2.0, height: UIScreen.main.bounds.size.width / 2.0 + 30.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MarvelCharactersCollectionViewCell.cellIdentifier, for: indexPath) as! MarvelCharactersCollectionViewCell
        
        guard let item = self.items[indexPath.row] as? Item ?? nil else {return cell}
        cell.configure(with: item)

        return cell
    }
    
    
}
