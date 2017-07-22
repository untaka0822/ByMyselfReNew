import UIKit

class ModuleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var alarmDatePicker: UIDatePicker!
    
    @IBOutlet weak var alarmFunctionTableView: UITableView!
    
    @IBAction func goBackModule(_ segue:UIStoryboardSegue) {}

    var alarmFunctions = ["Repeat", "title of alarm", "Sound"]
    
    var alarmValues = ["Every Monday", "ランニング", "Wake Me Up"]
    
    // 選択された行番号
    var selectedIndex = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        alarmDatePicker.setValue(UIColor.white, forKeyPath: "textColor")
        
        // ナビゲーションを透明にする処理
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
    }
    
    // 行数カウント
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    // 表示するセルの中身
    func tableView(_ tableView: UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell {
        
        // 定数を表示
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! customCell2
        
        // 表示したい文字の設定 cellの中には最初からtextLabelが入っている
        cell.alarmSettings?.text = alarmFunctions[indexPath.row]
        
        cell.alarmDetailTitle?.text = alarmValues[indexPath.row]
        
        // 文字を設定さいたセル
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("選択されたデータ:\(alarmValues[indexPath.row])")
        
        // 選択された行番号をメンバ変数に格納
        selectedIndex = indexPath.row
        
        print(selectedIndex)
        
        // セグエを指定して画面移動
        if selectedIndex == 0 {
        performSegue(withIdentifier: "showDetailAlarm0", sender: nil)
        }
        
        if selectedIndex == 1 {
            performSegue(withIdentifier: "showDetailAlarm1", sender: nil)
        }
        
        if selectedIndex == 2 {
            performSegue(withIdentifier: "showDetailAlarm2", sender: nil)
        }
    }
    
    
    // セグエを通って次の画面へ移動するとき
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        // 次の画面をインスタンス化(ダウンキャスト型変換)
        if segue.identifier == "showDetailAlarm0" {
            
            var dvc = segue.destination as! alarmDaysViewController
            
             dvc.sIndex = selectedIndex
             // dvc.alarmDetailFunction = alarmValues[selectedIndex]
        }
        
        if segue.identifier == "showDetailAlarm1" {
            
            var dvc = segue.destination as! alarmTitlesViewController
            
            // 次の画面のプロパティに選択された行番号を指定
            dvc.sIndex = selectedIndex
            dvc.alarmDetailFunction = alarmValues[selectedIndex]
            
        }
        
        if segue.identifier == "showDetailAlarm2" {
            
            var dvc = segue.destination as! alarmSoundViewController
            
            // 次の画面のプロパティに選択された行番号を指定
             dvc.sIndex = selectedIndex
            // dvc.alarmDetailFunction = alarmValues[selectedIndex]
            
        }

        

    }

    
    // 選択された日付が変わった時発動
    @IBAction func tapDatePicker(_ sender: UIDatePicker) {

        // 日付を文字列に変換するためのフォーマットを設定
        let df = DateFormatter()
        
        // フォーマットの設定
        df.dateFormat = "yyyy/MM/dd HH:mm"
        
        print(df.string(from: sender.date))
    }
    
    @IBAction func tapCancel(_ sender: UIBarButtonItem) {
        let next = storyboard!.instantiateViewController(withIdentifier: "toSecondView")
        self.present(next,animated: true, completion: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
