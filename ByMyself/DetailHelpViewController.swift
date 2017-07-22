//
//  DetailViewController.swift
//  practiceTeaList
//
//  Created by untaka0822 on 2017/06/11.
//  Copyright © 2017年 untaka0822. All rights reserved.
//

import UIKit

class DetailHelpViewController: UIViewController {
    
    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var myTextView: UITextView!
    
    // 前の画面から何行目が選択されたかわかる行番号を格納するプロパティ
    var sIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ナビゲーションを透明にする処理
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()

        self.myTextView.layer.cornerRadius = 15
        self.myTextView.layer.masksToBounds = true
        
        print("前の画面から選択された行:\(sIndex)")
        
        if sIndex == 0 {
            
            myLabel.text = "セルフコーチングワークって？"
            
            myTextView.text = "自らをコーチングすることを言います。\nコーチングとは野球やサッカーのコーチという意味の他に乗り物(馬車)という意味もあります。\nセルフコーチングとは自分で自分の目標に向かって進むことを意味します。\n例えば、自分がエンジニアになりたいと思った時\n・なぜなりたいのかを明確に\n・どうなっていたいか\n・なるためにどのようにやるか\n・なった後のことを考え行動する\n\nこの考え方をセルフコーチングワークといいます。"
            
        }
            
        else if sIndex == 1 {
            
            myLabel.text = "大きい目標を設定しよう！"
            
            myTextView.text = "目標とは「自分のゴール」です。\n設定する際に重要なのが大好きなことで且つ、今の自分では達成方法が分からないことです。\nそのため、より具体的な目標を立てるようにしてください。\nこの大きい目標が終わった時点で次の大きい目標へと移り変わります。"
            
        }
            
        else if sIndex == 2 {
            
            myLabel.text = "目標時間を設定しよう！"
            
            myTextView.text = "設定した目標の期限(いつまでに達成するか)を設定しましょう。\nこれはものすごく大事な作業で期限を決めることでよりその中でどのように行動すれば良いか考えることで自然と行動が工夫されていきます。大きな目標の期限は一度決めてしまうと達成するまで変更できません。"
            
        }
            
        else if sIndex == 3 {
            
            myLabel.text = "小さい目標を設定しよう！"
            
            myTextView.text = "大きい目標に対する小さい目標を設定しましょう。\nより目標を具体化することでモチベーションの維持や行動に繋がってきます。\n大きい目標に必要な要素を絞り出し大きい目標と同様に期限を設定しましょう。\n小さい目標は横にスワイプすることで削除することができます。"
            
        }
        
        else if sIndex == 4 {
            
            myLabel.text = "アラームを設定しよう！"
            
            myTextView.text = "アラームを設定し目標を達成するよう自分へ促しましょう。人間は忘れやすい生き物です。\n毎日覚えなくてはならないことが出てくるため日々過ごしていると忘れがちになってしまいます。\nそのためもう一度目標への意識の再確認を行いましょう。"
            
        }
        
        else if sIndex == 5 {
            
            myLabel.text = "実際に行動しよう！"
            
            myTextView.text = "ここまで設定したらあとは行動するのみです。\n目標設定しても行動しなければ意味がありません。\n自分はできないと卑下せず\n「自分を信じて行動する」\nことが一番大事です。"
            
        }

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
