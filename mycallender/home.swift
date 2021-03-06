import UIKit
import FSCalendar
import CalculateCalendarLogic
import RealmSwift

//ディスプレイサイズ取得
let w = UIScreen.main.bounds.size.width
let h = UIScreen.main.bounds.size.height

class home: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    

    
    
    //保存した食費
    let foodlabelDate = UILabel(frame: CGRect(x: 250, y: 700, width: 200, height: 50))
    //保存した娯楽費
    let EntertainmentlabelDate = UILabel(frame: CGRect(x: 250, y: 750, width: 200, height: 50))
    //保存した交際費
    let labelDate = UILabel(frame: CGRect(x: 250, y: 800, width: 200, height: 50))
    //保存した交通費
    let koutuulabelDate = UILabel(frame: CGRect(x: 250, y: 850, width: 200, height: 50))
    //保存した雑費
    let zappilabelDate = UILabel(frame: CGRect(x: 250, y: 900, width: 200, height: 50))
    //保存したtotal
    let totallabelData=UILabel(frame: CGRect(x: 250, y: 550, width: 200, height: 50))
    
    //タップした時に食費表示
    let foodlabelTitle = UILabel(frame: CGRect(x: 60, y: 700, width: 180, height: 50))
    //タップした時に娯楽費表示
    let EntlabelTitle = UILabel(frame: CGRect(x: 60, y: 750, width: 180, height: 50))
    //タップした時に交際費表示
    let labelTitle = UILabel(frame: CGRect(x: 60, y: 800, width: 180, height: 50))
    //タップした時に交通費表示
    let koutuulabelTitle = UILabel(frame: CGRect(x: 60, y: 850, width: 180, height: 50))
    //タップした時に雑費表示
    let zappilabelTitle = UILabel(frame: CGRect(x: 60, y: 900, width: 180, height: 50))

    //タップした時にtotall表示
    let totallabelTitle=UILabel(frame: CGRect(x: 60, y: 550, width: 180, height: 50))
    
    
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
        
        //交際費表示設定
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
        
        //交通費表示設定
        koutuulabelDate.text = ""
        koutuulabelDate.font = UIFont.systemFont(ofSize: 18.0)
        view.addSubview(koutuulabelDate)
        
        //雑費表示設定
        zappilabelDate.text = ""
        zappilabelDate.font = UIFont.systemFont(ofSize: 18.0)
        view.addSubview(zappilabelDate)
        
        //total表示設定
        totallabelData.text=""
        totallabelData.font = UIFont.systemFont(ofSize: 18.0)
        view.addSubview(totallabelData)
        
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
        label.text = " Total  "
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
        
        labelTitle.text = " 交際費 "
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
        
        koutuulabelTitle.text = " 交通費 "
        koutuulabelTitle.backgroundColor = .orange
        koutuulabelTitle.textAlignment = .center
        view.addSubview(koutuulabelTitle)
        
        zappilabelTitle.text = " 雑費 "
        zappilabelTitle.backgroundColor = .orange
        zappilabelTitle.textAlignment = .center
        view.addSubview(zappilabelTitle)
        
        
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
        
        koutuulabelDate.text = " "
        koutuulabelDate.textColor = .lightGray
        koutuulabelDate.backgroundColor = .orange
        view.addSubview(koutuulabelDate)
        
        zappilabelDate.text = " "
        zappilabelDate.textColor = .lightGray
        zappilabelDate.backgroundColor = .orange
        view.addSubview(zappilabelDate)
        
        
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
                koutuulabelDate.text = " ¥ " + ev.koutuu
                koutuulabelDate.textColor = .black
                view.addSubview(koutuulabelDate)
                zappilabelDate.text = " ¥ " + ev.zappi
                zappilabelDate.textColor = .black
                view.addSubview(zappilabelDate)
                
                let a:Double=Double(ev.event)!
                let b:Double=Double(ev.FoodExpense)!
                let c:Double=Double(ev.EntertainmentExpenses)!
                let d:Double=Double(ev.koutuu)!
                let e:Double=Double(ev.zappi)!
                
                let sum = a+b+c+d+e
                let printSum = Int(sum)
                totallabelData.text = " ¥ " + String(printSum)
                totallabelData.textColor = .black
                view.addSubview(totallabelData)
            }
        }
        
        
        
    }
    
}

