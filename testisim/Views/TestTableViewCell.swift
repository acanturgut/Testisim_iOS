//
//  TestTableViewCell.swift
//  testisim
//
//  Created by Ahmet Can on 19.08.2018.
//  Copyright © 2018 Testisim. All rights reserved.
//

import UIKit

class TestTableViewCell: UITableViewCell {

    @IBOutlet weak var testImage: UIImageView!
    @IBOutlet weak var testText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
