//
//  FirstViewController.swift
//  ByMyself
//
//  Created by untaka0822 on 2017/06/28.
//  Copyright © 2017年 untaka0822. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    
    @IBOutlet weak var myWords: UILabel!
    
    @IBOutlet weak var myName: UILabel!
    
    @IBOutlet weak var countLabel: SpringLabel!
    
    @IBOutlet weak var bigGoalName: UILabel!
    
    @IBOutlet weak var helpButton: UIButton!
    
    @IBOutlet weak var plusButton: UIButton!

    @IBOutlet weak var smallTableView: UITableView!
    
    @IBOutlet weak var smallGoalsLabel: UILabel!
    
    @IBAction func goBackFirst(_ segue:UIStoryboardSegue) {}
    
    let date = DateManager()
    
    // 絞り込み削除に使用
    var dcSelectedDate = Date()
    
    // 大きい目標用Timer
    var timer: Timer!
    
    // セルの中身用にTimerを用意
    var celltimer: Timer!
    
    // 大きい目標の辞書型配列
    var bigGoal: [NSDictionary] = []
    
    // 小さい目標の辞書型配列
    var smallGoals: [NSDictionary] = []
    
    // 小さい目標のメンバ変数
    var smallGoalsTitles:[String] = []
    var smallGoalsTimes:[String] = []
    var smallGoalsNotes:[String] = []
    var smallSaveDate:[Date] = []
    
    // 送る値の初期値
    var selectedIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // CoreDataからDataを読み込み処理
        read()
        
        // 外側を丸く
        self.plusButton.layer.cornerRadius = 12 
        self.plusButton.layer.masksToBounds = true
    
    }
    
    // 大きい目標側のread
    func read() {
        
        // AppDelegateを使う用意をしておく
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // エンティティを操作するためのオブジェクトを作成
        let viewContext = appDelegate.persistentContainer.viewContext
        
        // どのエンティティからdataを取得してくるか設定
        let query: NSFetchRequest<BigGoal> = BigGoal.fetchRequest()
        
        do {
            // データを一括取得
            let fetchResults = try viewContext.fetch(query)
            
            // データの取得
            for result: AnyObject in fetchResults {
                
                let df = DateFormatter()
                df.dateFormat = "yyyy/MM/dd HH:mm:ss"

                
                let title: String? = result.value(forKey: "title") as? String
                let time: Date? = result.value(forKey: "time") as! Date
                let time1: String? = df.string(from: time!)
                let saveDate: Date? = result.value(forKey: "saveDate") as! Date
                
                // 直接表示
                bigGoalName.text = title! + "まで"
                countLabel.text = time1
                

            }
        } catch {
            
        }
    
    }
    
    // 小さい目標側のエンティティ
    func smallGoalRead() {
        
        // AppDelegateを使う用意をしておく
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // エンティティを操作するためのオブジェクトを作成
        let viewContext = appDelegate.persistentContainer.viewContext
        
        // どのエンティティからdataを取得してくるか設定
        let fetchRequest : NSFetchRequest<SmallGoals> = SmallGoals.fetchRequest()
        
        // 持ってくる順番を決める
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "times", ascending: true)]
        
        do {
            
            // データを一括取得
            let fetchResults = try viewContext.fetch(fetchRequest)
            
            // 配列の初期化
            smallGoals = []
            smallGoalsTitles = []
            smallGoalsTimes = []
            smallGoalsNotes = []
            smallSaveDate = []
            
            // データの取得
            for result: AnyObject in fetchResults {
            
                
                let df = DateFormatter()
                df.dateFormat = "yyyy/MM/dd HH:mm:ss"
                
                // SmallGoals
                let titles: String? = result.value(forKey: "titles") as? String
                let times: Date? = result.value(forKey: "times") as! Date
                let times1: String? = df.string(from: times!)
                let memos: String? = result.value(forKey: "memos") as? String
                let saveDate: Date? = result.value(forKey: "saveDate") as! Date
                
                smallGoalsTitles.append(titles!)
                smallGoalsTimes.append(times1!)
                smallGoalsNotes.append(memos!)
                smallSaveDate.append(saveDate!)
                
                smallGoals.append(["titles": smallGoalsTitles, "times": smallGoalsTimes, "memos": smallGoalsNotes, "saveDate": smallSaveDate])
            }
            
        } catch {
            
        }
        
    }
    

    
    // 小さい目標を削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            dcSelectedDate = smallSaveDate[indexPath.row] as Date
            // AppDelegateを使う用意をしておく
            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            
            // エンティティを操作するためのオブジェクトを作成
            let viewContext = appDelegate.persistentContainer.viewContext
            
            // どのエンティティからdataを取得してくるか設定
            let request : NSFetchRequest<SmallGoals> = SmallGoals.fetchRequest()
            
            // 絞り込み検索(更新したいデータを取得する)
            let namePredicate =  NSPredicate(format: "saveDate = %@", dcSelectedDate as CVarArg)
            request.predicate = namePredicate

            do {
                // 削除するデータを取得
                let fetchResults = try viewContext.fetch(request)
                for result: AnyObject in fetchResults {
                    let record = result as! NSManagedObject
                    print(record)
                    // 一行ずつ削除
                    viewContext.delete(record)
                }
                // 削除した状態を保存
                try viewContext.save()
            } catch {
            }
            smallGoalRead()
        }
        smallTableView.reloadData()
    }

    
    // 画面が変わったとき毎回表示する
    override func viewWillAppear(_ animated: Bool) {
        // カウントダウン処理
        super.viewWillAppear(true)
        
        // 再度読み込み
        read()
        
        smallGoalRead()
        
        // 画面更新
        smallTableView.reloadData()
        
        //カウントダウン
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        timer.fire()
        
        // Motivation.plistの辞書型
        var person = ["person1","person2","person3","person4","person5","person6","person7","person8","person9","person10","person11","person12","person13","person14","person15","person16","person17","person18","person19","person20", "person21"]
        
        let random = Int(arc4random()) % person.count
        
        // info.plistから引っ張ってくる
        let filePath = Bundle.main.path(forResource: "Motivation", ofType: "plist")
        
        let dic = NSDictionary(contentsOfFile: filePath!)
        let detailInfo:NSDictionary = dic![person[random]] as! NSDictionary
        
        myName.text = "----- " + (detailInfo["name"] as! String) + " -----"
        myWords.text = (detailInfo["words"] as! String)
    

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        timer.invalidate()
        timer = nil
    }
    
    
    // 表示するセルの中身を作る
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellGoal", for: indexPath) as! customCell1
        
         cell.smallGoal.text = smallGoalsTitles[indexPath.row]
    
        // 各時間帯を時間内に
        var count: Int = date.getXmaxTimeInterval()
        
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
        
        if count % 10 == 0 {
            cell.animateLabel(label: cell.smallGoal)
        }
        
        if count % 60 == 0 {
            cell.animateLabel1(label: cell.smallGoal)
        }
        
        // 小さい目標名
        cell.smallGoalNameLabel.text = smallGoalsTitles[indexPath.row]
        
        // 小さい目標の期限
        cell.smallGoal.text = smallGoalsTimes[indexPath.row]
        
        // 小さい目標用のタイマー
        cell.setTimer(Label: cell.smallGoal)
        
        
        return cell
        
    }

    

    func update(tm: Timer) {
        // 各時間帯を時間内に
        var count: Int = date.getXmaxTimeInterval()
        
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
            animateLabel(label: countLabel)
        }
        
        if count % 60 == 0 {
            animateLabel1(label: countLabel)
        }
        
        
        // 出力 yearはそのまま 日にちは1年で365日、1日は24時間、1時間は60分、1分は60秒という計算
        countLabel.text = "\(year)年\(day % 365)日\n\(hour % 24)時間\(min % 60)分\(count % 60)秒"
        
    }
    
    func animateLabel1(label: SpringLabel) {
        
        countLabel.animation = "flash"
        countLabel.curve = "easeIn"
        countLabel.duration = 0.2
        countLabel.animate()
        
    }
    
    func animateLabel(label: SpringLabel) {
        
        countLabel.animation = "pop"
        countLabel.curve = "easeIn"
        countLabel.duration = 1.0
        countLabel.animate()

    }
    
    // 行数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return smallGoals.count
        
    }
    
    // セルがタップされたとき
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("選択されたデータ:\(smallGoals[indexPath.row])")
        
        selectedIndex = indexPath.row
        
        // セグエを通して画面移動
        performSegue(withIdentifier: "showDetailGoal", sender: indexPath.row)
        
        
    }
    
    // セグエを通って次の画面へ移動するとき
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetailGoal" {
            //次の画面をインスタンス化(as:ダウンキャスト型変換)
            let dvc = segue.destination as! DetailGoalViewController
    
            //次の画面のプロパティに選択された行番号を指定
            dvc.sIndex = selectedIndex

            dvc.smallTitleName = smallGoalsTitles[selectedIndex]
            dvc.smallGoalTime = smallGoalsTimes[selectedIndex]
            dvc.smallGoalMemo = smallGoalsNotes[selectedIndex]
            dvc.SmallGoalSaveDate = smallSaveDate[selectedIndex]
        }
    }
    

    // helpボタン
    @IBAction func helpButton(_ sender: UIButton) {
        // セグエを通して画面移動
        self.performSegue(withIdentifier: "toHelp", sender: nil)
    }

    // plusボタン
    @IBAction func plusButton(_ sender: UIButton) {
        // セグエを通して画面移動
        self.performSegue(withIdentifier: "toAdd", sender: nil)
    }
    
    //ボタン押下時に呼ばれるメソッド
    @IBAction func changeMode(sender: AnyObject) {
        //通常モードと編集モードを切り替える。
        if(smallTableView.isEditing == true) {
            smallTableView.isEditing = false
        } else {
            smallTableView.isEditing = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

