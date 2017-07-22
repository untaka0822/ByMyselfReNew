//
//  customCell.swift
//  ByMyself
//
//  Created by untaka0822 on 2017/06/30.
//  Copyright © 2017年 untaka0822. All rights reserved.
//

import UIKit

class customCell: UITableViewCell {
    
    @IBOutlet weak var todoTitleLabel: UILabel!
    
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    @IBOutlet weak var alarmTitle: UILabel!
    
    var alarmList = [""]
    
    var alarmTime = [""]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
