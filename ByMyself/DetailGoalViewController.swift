//
//  DetailGoalViewController.swift
//  ByMyself
//
//  Created by untaka0822 on 2017/07/12.
//  Copyright © 2017年 untaka0822. All rights reserved.
//

import UIKit
import CoreData

class DetailGoalViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var returnButton: UIBarButtonItem!
    
    @IBOutlet weak var mySmallTitle: UITextField!

    @IBOutlet weak var mySmallLimit: SpringLabel!
    
    @IBOutlet weak var mySmallNote: UITextView!
    
    var dcSelectedDate: Date = Date()
    
    // 前の画面から何行目が選択されたかわかる行番号を格納するプロパティ
    var sIndex = -1
    
    // 大きい目標用Timer
    var timer: Timer!
    
    var date = DateManager()
    
    var smallGoals: [NSDictionary] = []
    
    // 空の変数を作り値を受け取る
    var smallTitleName: String = ""
    
    var smallGoalTime: String = ""
    
    var smallGoalMemo: String = ""
    
    var smallTimeLimit: Date = Date()
    
    // メンバ変数を用意 (CRUD処理)
    var SmallGoalSaveDate: Date = Date()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        mySmallTitle.text = smallTitleName
        mySmallNote.text = smallGoalMemo
        
    
        print("前の画面から選択された行:\(sIndex)")
        
        // 仮のサイズでツールバー生成
        let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        kbToolBar.barStyle = UIBarStyle.default  // スタイルを設定
        
        kbToolBar.sizeToFit()  // 画面幅に合わせてサイズを変更
        
        // スペーサー
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        // 閉じるボタン
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: "commitButtonTapped")
        
        
        kbToolBar.items = [spacer, commitButton]
        
        
        mySmallNote.inputAccessoryView = kbToolBar
        
        // 外側を丸く
        self.mySmallNote.layer.cornerRadius = 15
        self.mySmallNote.layer.masksToBounds = true

        
    }
    
    
    // 画面が変わったとき毎回表示する
    override func viewWillAppear(_ animated: Bool) {
        // カウントダウン処理
        super.viewWillAppear(true)
        
        //カウントダウン
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        timer.fire()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        timer.invalidate()
        timer = nil
    }
    
    func update(tm: Timer) {
        
        let df = DateFormatter()
        
        // フォーマットの設定
        df.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        let smallTimeLimit: Date = df.date(from: self.smallGoalTime)!
        var count: Int = date.getGoalTimeInterval(targetTime: smallTimeLimit)
        
        var min: Int = count / 60
        
        var hour: Int = min / 60
        
        var day: Int = hour / 24
        
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
        
        if count != 0 {
        // 出力 yearはそのまま 日にちは1年で365日、1日は24時間、1時間は60分、1分は60秒という計算
            mySmallLimit.text = "\(day % 365)日\(hour % 24)時間\(min % 60)分\(count % 60)秒"
        } else {
            mySmallLimit.text = "お疲れ様でした。\n目標時間に到達しました。"
        }
    }


    
    // saveが押されたとき(更新処理)
    @IBAction func tapSave(_ sender: UIBarButtonItem) {
        
        // AppDelegateを使う用意をしておく
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // エンティティを操作するためのオブジェクトを作成
        let viewContext = appDelegate.persistentContainer.viewContext
        
        // どのエンティティからdataを取得してくるか設定
        let query:NSFetchRequest<SmallGoals> = SmallGoals.fetchRequest()
        
        // 絞り込み検索(更新したいデータを取得する)
        let namePredicate =  NSPredicate(format: "saveDate = %@", SmallGoalSaveDate as CVarArg)
        query.predicate = namePredicate
        
        do {
            // データを一括取得
            let fetchResults = try viewContext.fetch(query)
            
            // データの取得
            for result: AnyObject in fetchResults {
                
                // 更新する準備(NSManagedObjectにダウンキャスト型変換)
                let record = result as! NSManagedObject
                
                // 更新したいデータのセット リミット時間以外
                record.setValue(mySmallTitle.text, forKey: "titles")
                record.setValue(mySmallNote.text, forKey: "memos")
                record.setValue(Date(), forKey: "saveDate")
                
                do {
                    // レコード(行)の即時保存
                    try viewContext.save()
                } catch {
                }
            }
            
            // ページ移動
            dismiss(animated: true, completion: nil)
            
        } catch {
        }
        
    }
    
    // mySmallNoteのDoneが押された時
    func commitButtonTapped (){
        self.view.endEditing(true)
    }    
    
    
    // returnkeyが押された時
    @IBAction func tapReturnKey(_ sender: UITextField) {
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
