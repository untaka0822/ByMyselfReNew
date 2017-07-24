//
//  customCell1.swift
//  ByMyself
//
//  Created by untaka0822 on 2017/07/06.
//  Copyright © 2017年 untaka0822. All rights reserved.
//

import UIKit
import CoreData

class customCell1: UITableViewCell {

    @IBOutlet weak var smallGoal: SpringLabel!
    
    @IBOutlet weak var smallGoalNameLabel: SpringLabel!
    
    var smallGoalTime: String = ""
    
    var smallGoalName: String = ""
    
    var timer: Timer!
    
    let date = DateManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setTimer(Label:UILabel) {
        
        smallGoalTime = Label.text!
        //カウントダウン
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func update(tm: Timer) {
        // 各時間帯を時間内に
        
        // smallGoalTimeをDate型に変換
        // ポイント yyyy/MM/dd HH:mm:ssにする必要がある
        // 日付を文字列に変換するためのフォーマットを設定
        let df = DateFormatter()
        
        // フォーマットの設定
        df.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        let visionGoals: Date = df.date(from: self.smallGoalTime)!
        var count: Int = date.getGoalTimeInterval(targetTime: visionGoals)
        
        var min: Int = count / 60
        
        var hour: Int = min / 60
        
        var day: Int = hour / 24
        
        var year: Int = day / 365
        
        // 強制終了
        if count <= 0 {
            timer.invalidate()
        }
        
        // 0以下にならないようにする記述
        if count <= 0 {
            count = 0
        }
        
        if min <= 0 {
            min = 0
        }
        
        if hour <= 0 {
            hour = 0
        }
        
        if day <= 0 {
            day = 0
        }
        
        if year <= 0 {
            year = 0
        }
        
        if count % 10 == 0 {
            animateLabel(label: smallGoal)
        }
        
        if count % 60 == 0 {
            animateLabel1(label: smallGoal)
        }
        

        // 出力 yearはそのまま 日にちは1年で365日、1日は24時間、1時間は60分、1分は60秒という計算
        if count != 0 {
            smallGoal.text = "\(year)年\(day % 365)日\(hour % 24)時間\(min % 60)分\(count % 60)秒"
        } else {
            smallGoal.text = "目標時間に到達しました。"
        }
    }
    
    
    func animateLabel1(label: SpringLabel) {
        
        label.animation = "flash"
        label.curve = "easeIn"
        label.duration = 0.2
        label.animate()
        
        label.animation = "flash"
        label.curve = "easeIn"
        label.duration = 0.2
        label.animate()
        
    }
    
    func animateLabel(label: SpringLabel) {
        
        label.animation = "pop"
        label.curve = "easeIn"
        label.duration = 1.0
        label.animate()
        
        label.animation = "pop"
        label.curve = "easeIn"
        label.duration = 1.0
        label.animate()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
