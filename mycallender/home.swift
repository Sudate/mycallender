import UIKit
import FSCalendar
import CalculateCalendarLogic
import RealmSwift

//ディスプレイサイズ取得
let w = UIScreen.main.bounds.size.width
let h = UIScreen.main.bounds.size.height

class home: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    

    
    //保存した金額
    let labelDate = UILabel(frame: CGRect(x: 250, y: 700, width: 300, height: 50))
    //保存した食費
    let foodlabelDate = UILabel(frame: CGRect(x: 250, y: 800, width: 300, height: 50))
    //保存した娯楽費
    let EntertainmentlabelDate = UILabel(frame: CGRect(x: 250, y: 900, width: 300, height: 50))
    
    
    //タップした時にExpense表示
    let labelTitle = UILabel(frame: CGRect(x: 60, y: 700, width: 180, height: 50))

    //タップした時に食費表示
    let foodlabelTitle = UILabel(frame: CGRect(x: 60, y: 800, width: 180, height: 50))
    
    //タップした時に娯楽費表示
    let EntlabelTitle = UILabel(frame: CGRect(x: 60, y: 900, width: 180, height: 50))
    
    
    //カレンダー部分
    let dateView = FSCalendar(frame: CGRect(x: 0, y: 30, width: w, height: 500))
    //タップした日付の表示
    let Date = UILabel(frame: CGRect(x: 60, y: 600, width: 200, height: 100))
    override func viewDidLoad() {
        super.viewDidLoad()
        //カレンダー設定
        self.dateView.dataSource = self
        self.dateView.delegate = self
        self.dateView.today = nil
        self.dateView.tintColor = .red
        self.view.backgroundColor = .white
        dateView.backgroundColor = .white
        view.addSubview(dateView)
        
        //日付表示設定
        Date.text = ""
        Date.font = UIFont.systemFont(ofSize: 60.0)
        Date.textColor = .black
        view.addSubview(Date)
        
        //「主なスケジュール」表示設定
        labelTitle.text = ""
        labelTitle.textAlignment = .center
        labelTitle.font = UIFont.systemFont(ofSize: 20.0)
        view.addSubview(labelTitle)
        
        //スケジュール内容表示設定
        labelDate.text = ""
        labelDate.font = UIFont.systemFont(ofSize: 18.0)
        view.addSubview(labelDate)
        
        
        //food内容表示設定
        foodlabelDate.text = ""
        foodlabelDate.font = UIFont.systemFont(ofSize: 18.0)
        view.addSubview(foodlabelDate)
        
        //娯楽費内容表示設定
        EntertainmentlabelDate.text = ""
        EntertainmentlabelDate.font = UIFont.systemFont(ofSize: 18.0)
        view.addSubview(EntertainmentlabelDate)

        
        //スケジュール追加ボタン
       // let addBtn = UIButton(frame: CGRect(x: w - 70, y: h - 170, width: 60, height: 60))
        //addBtn.setTitle("+", for: UIControl.State())
        //addBtn.setTitleColor(.white, for: UIControl.State())
        //addBtn.backgroundColor = .orange
        //addBtn.layer.cornerRadius = 30.0
        //addBtn.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        //view.addSubview(addBtn)l
        
        //Total表示
        let label = UILabel(frame: CGRect(x: 60, y:550, width:180, height:50))
        label.text = " Total ¥ "
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = NSTextAlignment.center
        label.textColor = .white
        label.backgroundColor = .purple
        self.view.addSubview(label)
        
        
    }
    
    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    //画面遷移(スケジュール登録ページ)
    @objc func onClick(_: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let SecondController = storyboard.instantiateViewController(withIdentifier: "Insert")
        present(SecondController, animated: true, completion: nil)
    }
    
    // 祝日判定を行い結果を返すメソッド
    func judgeHoliday(_ date : Date) -> Bool {
        //祝日判定用のカレンダークラスのインスタンス
        let tmpCalendar = Calendar(identifier: .gregorian)
        
        // 祝日判定を行う日にちの年、月、日を取得
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        
        let holiday = CalculateCalendarLogic()
        
        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }
    
    // date型 -> 年月日をIntで取得
    func getDay(_ date:Date) -> (Int,Int,Int){
        let tmpCalendar = Calendar(identifier: .gregorian)
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        return (year,month,day)
    }
    
    //曜日判定
    func getWeekIdx(_ date: Date) -> Int{
        let tmpCalendar = Calendar(identifier: .gregorian)
        return tmpCalendar.component(.weekday, from: date)
    }
    
    // 土日や祝日の日の文字色を変える
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        //祝日判定をする
        if self.judgeHoliday(date){
            return UIColor.red
        }
        
        //土日の判定
        let weekday = self.getWeekIdx(date)
        if weekday == 1 {
            return UIColor.red
        }
        else if weekday == 7 {
            return UIColor.blue
        }
        
        return nil
    }
    
    //カレンダー処理(スケジュール表示処理)
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
        
        labelTitle.text = " Expense "
        labelTitle.backgroundColor = .orange
        labelTitle.textAlignment = .center
        view.addSubview(labelTitle)
        
        foodlabelTitle.text = " 食費 "
        foodlabelTitle.backgroundColor = .orange
        foodlabelTitle.textAlignment = .center
        view.addSubview(foodlabelTitle)
        
        EntlabelTitle.text = " 娯楽費 "
        EntlabelTitle.backgroundColor = .orange
        EntlabelTitle.textAlignment = .center
        view.addSubview(EntlabelTitle)
        
        
        
        //予定がある場合、スケジュールをDBから取得・表示する。
        //無い場合、「スケジュールはありません」と表示。
        labelDate.text = " "
        labelDate.textColor = .lightGray
        labelDate.backgroundColor = .orange
        view.addSubview(labelDate)
        
        foodlabelDate.text = " "
        foodlabelDate.textColor = .lightGray
        foodlabelDate.backgroundColor = .orange
        view.addSubview(foodlabelDate)
        
        EntertainmentlabelDate.text = " "
        EntertainmentlabelDate.textColor = .lightGray
        EntertainmentlabelDate.backgroundColor = .orange
        view.addSubview(EntertainmentlabelDate)
        
        
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: date)
        let month = tmpDate.component(.month, from: date)
        let day = tmpDate.component(.day, from: date)
        let m = String(format: "%02d", month)
        let d = String(format: "%02d", day)
        
        let da = "\(year)/\(m)/\(d)"
        
        //クリックしたら、日付が表示される。
        Date.text = "\(m)/\(d)"
        view.addSubview(Date)
        
        //スケジュール取得
        let realm = try! Realm()

        var result = realm.objects(Event.self)
        result = result.filter("date = '\(da)'")
        print(result)
        for ev in result {
            if ev.date == da {
                labelDate.text = " ¥ " + String(ev.event)
                labelDate.textColor = .black
                view.addSubview(labelDate)
                foodlabelDate.text = " ¥ " + ev.FoodExpense
                foodlabelDate.textColor = .black
                view.addSubview(foodlabelDate)
                EntertainmentlabelDate.text = " ¥ " + String(ev.EntertainmentExpenses)
                EntertainmentlabelDate.textColor = .black
                view.addSubview(EntertainmentlabelDate)
               
            
            }
        }
        
        
        
    }
    
}

