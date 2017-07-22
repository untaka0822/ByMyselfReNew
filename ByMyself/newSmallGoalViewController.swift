//
//  newSmallGoalViewController.swift
//  ByMyself
//
//  Created by untaka0822 on 2017/07/17.
//  Copyright © 2017年 untaka0822. All rights reserved.
//

import UIKit
import CoreData

class newSmallGoalViewController: UIViewController {
    
    @IBOutlet weak var smallNewGoalName: UITextField!

    @IBOutlet weak var smallNewGoalMemo: UITextView!
    
    @IBOutlet weak var timeDatePicker: UIDatePicker!
    
    @IBOutlet weak var smallNewGoalLimit: UIDatePicker!
    
    // トータルの時間
    var totalTime: String = ""
    
    let date = DateManager()
    
    // 空の辞書型配列
    var smallGoals: [NSDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 仮のサイズでツールバー生成
        let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        kbToolBar.barStyle = UIBarStyle.default  // スタイルを設定
        
        kbToolBar.sizeToFit()  // 画面幅に合わせてサイズを変更
        
        // スペーサー
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        // 閉じるボタン
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: "commitButtonTapped")
        
        
        kbToolBar.items = [spacer, commitButton]
        
        smallNewGoalMemo.inputAccessoryView = kbToolBar
        
        let textField = UITextField()
        smallNewGoalName.placeholder = "大きい目標に対する目標を入力"
        // DatePickerの字の色
        smallNewGoalLimit.setValue(UIColor.white, forKeyPath: "textColor")
        
        timeDatePicker.setValue(UIColor.white, forKeyPath: "textColor")
        
        // TextViewの外形
        self.smallNewGoalMemo.layer.cornerRadius = 15
        self.smallNewGoalMemo.layer.masksToBounds = true
        
        // 日付を文字列に変換するためのフォーマットを設定
        let dada = DateFormatter()
        
        // フォーマットの設定
        dada.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        // 初期値
        totalTime = dada.string(from: timeDatePicker.date)
        
    }
    
    // smallNewGoalMemoのDoneが押された時
    func commitButtonTapped (){
        self.view.endEditing(true)
    }
    
    // TextFieldのreturnキーが押された時
    @IBAction func tapReturn(_ sender: UITextField) {
    }

    // キャンセルがおされた時
    @IBAction func tapCancel(_ sender: UIBarButtonItem) {
        
        let next = storyboard!.instantiateViewController(withIdentifier: "toFirstView")
        self.present(next,animated: true, completion: nil)
        
    }
    
    // tapSaveが押された時
    @IBAction func tapSave(_ sender: UIBarButtonItem) {
        
        // AppDelegateを使う用意しておく
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // エンティティを操作するためのオブジェクトを作成
        let viewContext = appDelegate.persistentContainer.viewContext
        
        // エンティティ名でオブジェクトを作成
        let SmallGoal = NSEntityDescription.entity(forEntityName: "SmallGoals", in: viewContext)
        
        // BigGoalエンティティにレコード(行)を挿入するためのオブジェクトを作成
        let newRecord = NSManagedObject(entity: SmallGoal!, insertInto: viewContext)
        
        // 値のセット
        newRecord.setValue(smallNewGoalName.text, forKey: "titles") // 値を代入
        
        // 日付を文字列に変換するためのフォーマットを設定
        let dfc = DateFormatter()
        
        // フォーマットの設定
        dfc.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        newRecord.setValue(dfc.date(from: totalTime), forKey: "times")
        
        newRecord.setValue(smallNewGoalMemo.text, forKey: "memos")
        newRecord.setValue(Date(), forKey: "saveDate")
        
        
        do {
            // レコード(行)の即時保存
            try viewContext.save()
        } catch {
            
        }
        
        // ローカル通知のオブジェクト作成
        let notification :UILocalNotification = UILocalNotification()
        
        // タイトル設定
        notification.alertTitle = smallNewGoalName.text! + "の時間に到達しました"
        
        // 通知メッセージの設定
        notification.alertBody = "お疲れ様でした。\n次なる目標に向けて進みましょう。"
        
        // TimeZoneの設定(現在iphoneやMacに指定している時間)
        notification.timeZone = TimeZone.current
        
        // 通知の時間を設定
        notification.fireDate = Date(timeIntervalSinceNow: TimeInterval(date.getGoalTimeInterval(targetTime: dfc.date(from: totalTime)!)))
        
        // ローカル通知オブジェクトをセット(アプリが終了してもスケジュール通り発動する)
        UIApplication.shared.scheduleLocalNotification(notification)
        
        // 次のページへ
        dismiss(animated: true, completion: nil)

    }

    
    // 選択された日付が変わった時発動
    @IBAction func tapDatePicker(_ sender: UIDatePicker) {
        
        // 日付を文字列に変換するためのフォーマットを設定
        let df = DateFormatter()
        
        // フォーマットの設定
        df.dateFormat = "yyyy/MM/dd "
        
        let dftime = DateFormatter()
        
        // フォーマットの設定
        dftime.dateFormat = "HH:mm:ss"
        
        
        var dateGoals = df.string(from: sender.date)
        
        var dateGoalsTime = dftime.string(from: smallNewGoalLimit.date)
        
        dateGoals = dateGoals + dateGoalsTime
        
        print(dateGoals)
        
        totalTime = dateGoals
    }
    
    // 選択された時間が変わった時発動
    @IBAction func tapDatePicker1(_ sender: UIDatePicker) {
        
        // 日付を文字列に変換するためのフォーマットを設定
        let df = DateFormatter()
        
        // フォーマットの設定
        df.dateFormat = "HH:mm:ss"
        
        let dftime = DateFormatter()
        
        // フォーマットの設定
        dftime.dateFormat = "yyyy/MM/dd "
        
        var dateGoals = df.string(from: sender.date)
        
        var dateGoalsTime = dftime.string(from: timeDatePicker.date)
        
        dateGoals = dateGoalsTime + dateGoals
        
        print(dateGoals)
        
        totalTime = dateGoals
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
