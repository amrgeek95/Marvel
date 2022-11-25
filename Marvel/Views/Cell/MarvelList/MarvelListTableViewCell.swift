//
//  MarvelListTableViewCell.swift
//  Marvel
//
//  Created by Mac on 23/11/2022.
//

import UIKit
import SDWebImage

class MarvelListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel :UILabel!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconImg: UIImageView!

    static let cellIdentifier = "MarvelListTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib () ->UINib {
        return UINib(nibName: cellIdentifier, bundle: nil)
    }
    
    public func configure(with item : Marvel){
        
        
        self.nameLabel.text = item.name
        self.iconImg.sd_setImage(with: URL(string: item.thumbnail), placeholderImage: UIImage(named: "loading"))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
