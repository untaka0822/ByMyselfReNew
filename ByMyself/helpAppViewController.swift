//
//  helpAppViewController.swift
//  ByMyself
//
//  Created by untaka0822 on 2017/07/10.
//  Copyright © 2017年 untaka0822. All rights reserved.
//

import UIKit

class helpAppViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var helpTableView: UITableView!
    
    var helpTitles = ["セルフコーチングワークって？", "大きい目標を設定しよう！", "目標時間を設定しよう！", "小さい目標を設定しよう！", "アラームを設定しよう！", "実際に行動しよう！"]
    
    // 選択された行番号
    var selectedIndex = -1 //全く選択されていない時は、-1が入っている
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // プロトコル先に書くとこの変換が出る
    // 行数を設定
    // -> Int : 「戻り値のデータ型はInt型です」という意味
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    // 表示するセルの中身
    func tableView(_ tableView: UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell {
        
        // 定数を表示
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // 表示したい文字の設定 cellの中には最初からtextLabelが入っている
        cell.textLabel?.text = helpTitles[indexPath.row]
        cell.textLabel?.textColor = UIColor.black
        
        
        // 文字を設定さいたセル
        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print("選択されたデータ:\(helpTitles[indexPath.row])")
        
        // 選択された行番号をメンバ変数に格納
        selectedIndex = indexPath.row
        
        // セグエを指定して画面移動
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    
    // セグエを通って次の画面へ移動するとき
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetail" {
        // 次の画面をインスタンス化(ダウンキャスト型変換)
        var dvc = segue.destination as! DetailHelpViewController
        
        // 次の画面のプロパティに選択された行番号を指定
        dvc.sIndex = selectedIndex
            
        }
    }
    
    
    @IBAction func tapReturn(_ sender: UIBarButtonItem) {
        let next = storyboard!.instantiateViewController(withIdentifier: "toFirstView")
        self.present(next,animated: true, completion: nil)
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
