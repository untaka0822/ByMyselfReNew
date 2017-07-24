//
//  AddGoalViewController.swift
//  ByMyself
//
//  Created by untaka0822 on 2017/06/30.
//  Copyright © 2017年 untaka0822. All rights reserved.
//

import UIKit
import CoreData

class AddGoalViewController: UIViewController {
    
    @IBOutlet weak var goalTitle: UITextField!
    
    @IBOutlet weak var goalLimit: UIDatePicker!
    
    @IBOutlet weak var goalTime: UIDatePicker!
    
    // トータルの時間
    var bigTotal: String = ""
    
    // 大きい目標の辞書型配列
    var bigGoal: [NSDictionary] = []
    
    let date = DateManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalLimit.setValue(UIColor.white, forKeyPath: "textColor")
        
        goalTime.setValue(UIColor.white, forKeyPath: "textColor")
        
        
        // 日付を文字列に変換するためのフォーマットを設定
        let dada = DateFormatter()
        
        // フォーマットの設定
        dada.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        // 初期値
        bigTotal = dada.string(from: goalLimit.date)

        
        
    }
    
    // キャンセルがおされた時
    @IBAction func tapCancel(_ sender: UIBarButtonItem) {

    let next = storyboard!.instantiateViewController(withIdentifier: "toFirstView")
        self.present(next,animated: true, completion: nil)
        
    }
    
    
    // TextFieldのリターンキーが押されたとき
    @IBAction func tapReturnKey(_ sender: UITextField) {
    }
    
    // Doneが押され次のページに行く時
    @IBAction func tapDone(_ sender: UIBarButtonItem) {
        
        // AppDelegateを使う用意しておく
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // エンティティを操作するためのオブジェクトを作成
        let viewContext = appDelegate.persistentContainer.viewContext
        
        // エンティティ名でオブジェクトを作成
        let BigGoal = NSEntityDescription.entity(forEntityName: "BigGoal", in: viewContext)
        
        // BigGoalエンティティにレコード(行)を挿入するためのオブジェクトを作成
        let newRecord = NSManagedObject(entity: BigGoal!, insertInto: viewContext)
        
        // 値のセット
        newRecord.setValue(goalTitle.text, forKey: "title") // 値を代入
        
        // 日付を文字列に変換するためのフォーマットを設定
        let dfc = DateFormatter()
        
        // フォーマットの設定
        dfc.dateFormat = "yyyy/MM/dd HH:mm:ss"
        newRecord.setValue(dfc.date(from: bigTotal), forKey: "time")
        newRecord.setValue(Date(), forKey: "saveDate")
        
        do {
            // レコード(行)の即時保存
            try viewContext.save()
        } catch {
            
        }
        
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
        
        var dateGoalsTime = dftime.string(from: goalTime.date)
        
        dateGoals = dateGoals + dateGoalsTime
        
        bigTotal = dateGoals
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
        
        var dateGoalsTime = dftime.string(from: goalLimit.date)
        
        dateGoals = dateGoalsTime + dateGoals
        
        bigTotal = dateGoals
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
