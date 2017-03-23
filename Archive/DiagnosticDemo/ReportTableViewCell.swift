//
//  ReportTableViewCell.swift
//  DiagnosticTest
//
//  Created by Administrator on 3/23/17.
//  Copyright © 2017 Administrator. All rights reserved.
//

import UIKit

class ReportTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var reportLbl: UILabel!
    @IBOutlet weak var reportImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
