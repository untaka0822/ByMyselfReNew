//
//  SecondViewController.swift
//  ByMyself
//
//  Created by untaka0822 on 2017/06/28.
//  Copyright © 2017年 untaka0822. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    var alarmList: [NSDictionary] = []
    
    var GoalList: [NSDictionary] = []
    
    
    var selectedIndex = -1 // 全く選択されていない時に入る値
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    @IBAction func goBackSecond(_ segue:UIStoryboardSegue) {}
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // ナビゲーションを透明にする処理
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        
    }

    // 編集ボタンを押した時の処理
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        myTableView.reloadData()
        myTableView.setEditing(editing, animated: animated)
        
    }
    
    
    // アラームを削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            alarmList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // 行数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmList.count
    }
    
    // 表示するセルの中身を作る
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! customCell
        
         cell.todoTitleLabel.text = alarmList[indexPath.row] as! String
        
         cell.alarmTitle.text = GoalList[indexPath.row] as! String
        
        
        // Editボタンが押されたとき
        if tableView.isEditing == true {
            // スイッチを隠す
            cell.alarmSwitch.isHidden = true
            
        } else {
            // スイッチを出す
            cell.alarmSwitch.isHidden = false
        }
        
        return cell
    }
    
    // セルがタップされた時に発動
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("選択されたデータ:\(alarmList[indexPath.row])")
        print("選択されたデータ:\(GoalList[indexPath.row])")
            
        selectedIndex = indexPath.row
        
        // セグエを通して画面移動
            self.performSegue(withIdentifier: "showDetail", sender: nil)
        
    }
    
    // セグエを通って次の画面へ移動するとき
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetail" {
             //次の画面をインスタンス化(as:ダウンキャスト型変換)
              var dvc = segue.destination as! DetailAlarmViewController
        
            //次の画面のプロパティに選択された行番号を指定
            dvc.sIndex = selectedIndex
            // dvc.name = alarmList[selectedIndex]
            // dvc.alarm = GoalList[selectedIndex]
        }
    }
    
    
    // アラーム追加ボタンが押された時
    @IBAction func tapAddAlarm(_ sender: UIBarButtonItem) {
        
        self.performSegue(withIdentifier: "showModule", sender: nil)
    }
    
    
    @IBAction func mySwitch(_ sender: UISwitch) {

    // switchの状態が変わった時に発動するメソッド
        // 値がtrueかfalseか
        print(sender.isOn)
        
        if sender.isOn {
            // SwitchがONの時、実行される
            // アラームが実行されるようにする
            
        } else {
            // Switchがoffの時実行される
            // アラームが実行されないようにする
            
        }

    }

    // Editボタンが押されたとき
    @IBAction func tapEdit(_ sender: UIBarButtonItem) {
        
        //通常モードと編集モードを切り替える。
        if(myTableView.isEditing == true) {
            myTableView.isEditing = false
        } else {
            myTableView.isEditing = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

