//
//  MarvelCharactersCollectionViewCell.swift
//  Marvel
//
//  Created by Mac on 23/11/2022.
//

import UIKit

class MarvelCharactersCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    static let cellIdentifier = "MarvelCharactersCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    static func nib () -> UINib {
        return UINib(nibName: cellIdentifier, bundle: nil)
    }
    func configure(with item:Item){
        self.titleLabel.text = item.title
        self.iconImg.sd_setImage(with: URL(string: item.thumbnail), placeholderImage: UIImage(named: "loading"))
    }
    

}
