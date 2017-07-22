

import Foundation
import UIKit
import CoreData

class DateManager {
    
    private let formatter = DateFormatter()
    private let date = Date()
    private var dateStr: String?
    private let calendar = Calendar(identifier: .gregorian)
    
    var num : Int = 0
            
    init() {
        formatter.timeZone = NSTimeZone.system
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateStr = ""
    }
    
    //現在時刻を返します"yyyy-MM-dd-HH-mm-ss"
    func getNowDate() -> String{
        dateStr = formatter.string(from: date)
        guard let now = dateStr else { return ""}
        return now
    }
    
    //設定したカウントダウンの秒数を返してくれます
    func getXmaxTimeInterval() -> Int {
        
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
                
                let title: String? = result.value(forKey: "title") as? String
                let time: Date? = result.value(forKey: "time") as! Date
                let saveDate: Date? = result.value(forKey: "saveDate") as! Date
                
                
                let pickerDate = result.value(forKey: "time") as! Date
                
                let yy = DateFormatter()
                yy.timeZone = TimeZone.ReferenceType.local
                yy.dateFormat = "yyyy"
                let goalYear = yy.string(from: pickerDate)
                
                let MM = DateFormatter()
                MM.timeZone = TimeZone.ReferenceType.local
                MM.dateFormat = "MM"
                let goalMonth = MM.string(from: pickerDate)
                
                let dd = DateFormatter()
                dd.timeZone = TimeZone.ReferenceType.local
                dd.dateFormat = "dd"
                let goalDays = dd.string(from: pickerDate)
                
                let HH = DateFormatter()
                HH.timeZone = TimeZone.ReferenceType.local
                HH.dateFormat = "HH"
                let goalHours = HH.string(from: pickerDate)

                let mm = DateFormatter()
                mm.timeZone = TimeZone.ReferenceType.local
                mm.dateFormat = "mm"
                let goalMinutes = mm.string(from: pickerDate)

                let ss = DateFormatter()
                ss.timeZone = TimeZone.ReferenceType.local
                ss.dateFormat = "ss"
                let goalSeconds = ss.string(from: pickerDate)

                guard let goal = calendar.date(from: DateComponents(year: Int(goalYear), month: Int(goalMonth), day: Int(goalDays), hour: Int(goalHours), minute: Int(goalMinutes), second: Int(goalSeconds))) else { return 0}
                let spanFromWow = goal.timeIntervalSinceNow
                
                num =  Int(floor(spanFromWow))
            }
            return num
        } catch {
            print("エラー")
            return 0
        }
        
    }
    
    
    //設定したカウントダウンの秒数を返してくれます
    func getGoalTimeInterval(targetTime: Date) -> Int {
        
        
                let pickerDate = targetTime
                
                let yy = DateFormatter()
                yy.timeZone = TimeZone.ReferenceType.local
                yy.dateFormat = "yyyy"
                let goalYear = yy.string(from: pickerDate)
                
                let MM = DateFormatter()
                MM.timeZone = TimeZone.ReferenceType.local
                MM.dateFormat = "MM"
                let goalMonth = MM.string(from: pickerDate)
                
                let dd = DateFormatter()
                dd.timeZone = TimeZone.ReferenceType.local
                dd.dateFormat = "dd"
                let goalDays = dd.string(from: pickerDate)
                
                let HH = DateFormatter()
                HH.timeZone = TimeZone.ReferenceType.local
                HH.dateFormat = "HH"
                let goalHours = HH.string(from: pickerDate)
                
                let mm = DateFormatter()
                mm.timeZone = TimeZone.ReferenceType.local
                mm.dateFormat = "mm"
                let goalMinutes = mm.string(from: pickerDate)
                
                let ss = DateFormatter()
                ss.timeZone = TimeZone.ReferenceType.local
                ss.dateFormat = "ss"
                let goalSeconds = ss.string(from: pickerDate)
                
                guard let goal = calendar.date(from: DateComponents(year: Int(goalYear), month: Int(goalMonth), day: Int(goalDays), hour: Int(goalHours), minute: Int(goalMinutes), second: Int(goalSeconds))) else { return 0}
                let spanFromWow = goal.timeIntervalSinceNow
                
                num =  Int(floor(spanFromWow))
        
            return num
    }
}

