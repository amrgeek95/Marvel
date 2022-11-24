//
//  characeterDetailTopItemTableViewCell.swift
//  Marvel
//
//  Created by Mac on 24/11/2022.
//

import UIKit

class characeterDetailTopItemTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    static let cellIdentifier = "characeterDetailTopItemTableViewCell"

    
    static func nib()-> UINib {
        return UINib(nibName: cellIdentifier, bundle: nil)

    }
    
    
    func configure(with item:Marvel){
        self.titleLabel.text = item.name
        self.descriptionLabel.text = item.description
        self.iconImg.sd_setImage(with: URL(string: item.thumbnail), placeholderImage: UIImage(named: "loading"))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
