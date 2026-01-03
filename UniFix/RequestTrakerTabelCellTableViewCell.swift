//
//  RequestTrakerTabelCellTableViewCell.swift
//  UniFix
//
//  Created by zahraa humaidan on 18/12/2025.
//

import UIKit

class RequestTrakerTabelCellTableViewCell: UITableViewCell {

    @IBOutlet weak var statusLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        statusLabel.textAlignment = .center
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
