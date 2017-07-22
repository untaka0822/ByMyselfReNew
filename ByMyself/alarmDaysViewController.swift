//
//  alarmDaysViewController.swift
//  ByMyself
//
//  Created by untaka0822 on 2017/07/20.
//  Copyright © 2017年 untaka0822. All rights reserved.
//

import UIKit

class alarmDaysViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var daysTableView: UITableView!
    
    var selectedIndex = -1
    
    var sIndex = -1
    
    var days = ["Every Sunday", "Every Monday", "Every Tuesday", "Every Wednesday", "Every Thursday", "Every Friday", "Every Saturday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        daysTableView.allowsMultipleSelection = true
        
        daysTableView.tableFooterView = UIView(frame: .zero)
        
        // ナビゲーションを透明にする処理
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        
    }

    // 行数を設定
    // -> Int : この中で返す値はIntじゃないとダメだよってこと
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    // 表示するセルの中身
    func tableView(_ tableView: UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell {
        
        // 定数を表示
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // 表示したい文字の設定 cellの中には最初からtextLabelが入っている
        cell.textLabel?.text = days[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        // 文字が設定されたセル
        return cell
    }
    
    // セルがタップされたとき
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("選択されたデータ:\(indexPath.row)")
        
        // チェックマークをつける
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    
    }
    
    // セルがアンタップされたとき
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at:indexPath)
        cell?.accessoryType = .none
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
