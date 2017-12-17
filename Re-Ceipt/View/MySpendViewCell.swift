//
//  MySpendViewCell.swift
//  Re-Ceipt
//
//  Created by 유영정 on 2017. 12. 17..
//  Copyright © 2017년 SSU. All rights reserved.
//

import UIKit

class MySpendViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
