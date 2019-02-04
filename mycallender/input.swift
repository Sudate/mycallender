import UIKit
import RealmSwift
//ディスプレイサイズ取得
let w2 = UIScreen.main.bounds.size.width
let h2 = UIScreen.main.bounds.size.height




//スケジュール内容入力テキスト
let eventText = UITextView(frame: CGRect(x: (w2 - 90) / 2, y: 150, width: 300, height: 50))

let foodText = UITextView(frame: CGRect(x: (w2 - 90) / 2, y: 200, width: 300, height: 50))


//日付フォーム(UIDatePickerを使用)
let y = UIDatePicker(frame: CGRect(x: 340, y: 250, width: 280, height: 300))
//日付表示
let y_text = UILabel(frame: CGRect(x: 340 , y: 550, width: 300, height: 20))
class Input: UIViewController {
    let labelKeep = UILabel(frame: CGRect(x: 450, y:700, width:100, height:50))
    var date: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //スケジュール内容入力テキスト設定
        eventText.text = ""
        eventText.layer.borderColor = UIColor.gray.cgColor
        eventText.layer.borderWidth = 1.0
        eventText.layer.cornerRadius = 10.0
        eventText.font = UIFont.systemFont(ofSize: 25)
        view.addSubview(eventText)
        
        //food内容入力テキスト設定
        foodText.text = ""
        foodText.layer.borderColor = UIColor.gray.cgColor
        foodText.layer.borderWidth = 1.0
        foodText.layer.cornerRadius = 10.0
        foodText.font = UIFont.systemFont(ofSize: 25)
        view.addSubview(foodText)
        
        //日付フォーム設定
        y.datePickerMode = UIDatePicker.Mode.date
        y.timeZone = NSTimeZone.local
        y.addTarget(self, action: #selector(picker(_:)), for: .valueChanged)
        view.addSubview(y)
        
        //日付表示設定
        y_text.backgroundColor = .white
        y_text.textAlignment = .center
        view.addSubview(y_text)
        
        //「書く!」ボタン
        let eventInsert = UIButton(frame: CGRect(x: (w2 - 200) / 2, y: 800, width: 200, height: 50))
        eventInsert.setTitle("書く！", for: UIControl.State())
        eventInsert.setTitleColor(.white, for: UIControl.State())
        eventInsert.backgroundColor = .orange
        eventInsert.addTarget(self, action: #selector(saveEvent(_:)), for: .touchUpInside)
        view.addSubview(eventInsert)
    
        //ラベル
        //let labelKeep = UILabel(frame: CGRect(x: 450, y:195, width:100, height:50))
        labelKeep.text = " "
        labelKeep.font = UIFont.systemFont(ofSize: 25)
        self.view.addSubview(labelKeep)
        
        //「戻る!」ボタン
        let backBtn = UIButton(frame: CGRect(x: (w - 200) / 2, y: h - 50, width: 200, height: 30))
        backBtn.setTitle("戻る", for: UIControl.State())
        backBtn.setTitleColor(.orange, for: UIControl.State())
        backBtn.backgroundColor = .white
        backBtn.layer.cornerRadius = 10.0
        backBtn.layer.borderColor = UIColor.orange.cgColor
        backBtn.layer.borderWidth = 1.0
        backBtn.addTarget(self, action: #selector(onbackClick(_:)), for: .touchUpInside)
        view.addSubview(backBtn)
        
        
        //Expenseラベル
        let label = UILabel(frame: CGRect(x: 150, y:150, width:100, height:50))
        label.text = "Expense"
        label.font = UIFont.systemFont(ofSize: 25)
        self.view.addSubview(label)
        
        //foodラベル
        let foodlabel = UILabel(frame: CGRect(x: 150, y:200, width:100, height:50))
        foodlabel.text = "Food"
        foodlabel.font = UIFont.systemFont(ofSize: 25)
        self.view.addSubview(foodlabel)
        
        //Dateラベル
        let labelDate = UILabel(frame: CGRect(x: 150, y:250, width:100, height:50))
        labelDate.text = "Date"
        labelDate.font = UIFont.systemFont(ofSize: 25)
        self.view.addSubview(labelDate)
    
        
        
        
    }
    //画面遷移(カレンダーページ)
    @objc func onbackClick(_: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //日付フォーム
    @objc func picker(_ sender:UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        y_text.text = formatter.string(from: sender.date)
        view.addSubview(y_text)
    }
    //DB書き込み処理
    @objc func saveEvent(_ : UIButton){
        print("データ書き込み開始")
        
        let realm = try! Realm()
        
        
        
        
        
        try! realm.write {
            
            //日付表示の内容とスケジュール入力の内容が書き込まれる。
            let Events = [Event(value: ["date": y_text.text,"FoodExpense":foodText.text,"event": eventText.text])]
            realm.add(Events)
            print("データ書き込み中")
        }
        
        print("データ書き込み完了")
        labelKeep.text = " saved! "
        labelKeep.font = UIFont.systemFont(ofSize: 25)
        self.view.addSubview(labelKeep)
        
        
        
    }
    
    
    
    
}
