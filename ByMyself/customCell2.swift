//
//  customCell2.swift
//  ByMyself
//
//  Created by untaka0822 on 2017/07/13.
//  Copyright © 2017年 untaka0822. All rights reserved.
//

import UIKit

class customCell2: UITableViewCell {
    
    // アラームの機能の値
    @IBOutlet weak var alarmDetailTitle:
        UILabel!
    
    // アラームの機能の名前
    @IBOutlet weak var alarmSettings: UILabel!
    
    var alarmDetailFunction = [""]
    
    var alarmFunctionNames = [""]
    
    @IBAction func goBackModule(_ segue:UIStoryboardSegue) {}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
