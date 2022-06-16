//
//  TableViewCell.swift
//  ois-ios
//
//  Created by Alikhan Nursapayev on 11.06.2022.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initialize(mainLabel: String, secondLabel: String, thirdLabel: String, image: String) {
        if let imageUrl = URL(string: image) {
            let scale = UIScreen.main.scale
            let thumbnailSize = CGSize(width: 200 * scale, height: 200 * scale)
                img.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "doc.fill"), context: [.imageThumbnailPixelSize : thumbnailSize])

        }
        self.mainLabel.text = mainLabel
        self.secondLabel.text = secondLabel
        self.thirdLabel.text = thirdLabel
    }
    
}
