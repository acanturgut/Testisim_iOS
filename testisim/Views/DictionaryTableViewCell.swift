//
//  DictionaryTableViewCell.swift
//  testisim
//
//  Created by Ahmet Can on 20.08.2018.
//  Copyright © 2018 Testisim. All rights reserved.
//

import UIKit

class DictionaryTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
