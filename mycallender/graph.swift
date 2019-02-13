//
//  graph.swift
//  mycallender
//
//  Created by kentarou sudate on 2018/12/06.
//  Copyright © 2018 kentarou sudate. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class graph: UIViewController {
    
    var textFieldString = ""
    
    var ar1:[Double] = []
    var ar2:[String] = []
    var ar3:[Double] = []
    var ar4:[Double] = []
    var ar5:[Double] = []
    var ar6:[Double] = []
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet var BaseCharts: PieChartView!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var ftext: DatePickerKeyboard!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.frame = CGRect(x:500, y : 100, width:100, height : 50);
        label2.frame = CGRect(x:230, y:200, width:300, height:50)
        ftext.frame = CGRect(x : 270, y : 100, width:200, height : 50);
        BaseCharts.frame = CGRect(x : 50, y : 300, width : 650, height :  650);
        BaseCharts.chartDescription?.enabled = false
        
        // テキストを中央寄せ
        label2.textAlignment = NSTextAlignment.center
        label2.layer.borderColor = UIColor(red: 0.1, green: 0.7, blue: 1.0, alpha: 0.5).cgColor
        label2.layer.borderWidth = 2
        label2.layer.masksToBounds = true
        label2.layer.cornerRadius = 10
        label2.text=""

        ftext.borderStyle = .roundedRect
        ftext.clearButtonMode = .whileEditing
        ftext.returnKeyType = .done
        ftext.placeholder = "入力してください"
        
        
        //dataSet.colors = ChartColorTemplates.vordiplom()
        view.addSubview(BaseCharts)
        view.addSubview(ftext)
        }
    @IBAction func tapped_button(_ sender: Any) {
        let text = ftext.text
        if text!.isEmpty{
            ftext.text = "2019/1/21"
        }
        var moji = String(ftext.text!)
        if let range = moji.range(of: "年") {
            moji.replaceSubrange(range, with: "/")
        }
        if let range = moji.range(of: "月") {
            moji.replaceSubrange(range, with: "/")
        }
        if let range = moji.range(of: "日") {
            moji.replaceSubrange(range, with: "")
        }
        print(moji)
        let c = NSMutableString(string: moji)
        let a = String(moji[moji.index(moji.startIndex, offsetBy: 5)])
        let e = String(moji[moji.index(moji.startIndex, offsetBy: 6)])
        let f = Int(e)
        let b = Int(a)
        if  b == 1 {
            if f == 0 || f == 1 || f == 2{
            label2.text = moji
            }
        }else{
            c.insert("0", at: 5)
            label2.text = String(c)
        }
        ftext.text = ""
        let realm = try! Realm()
        let result = realm.objects(Event.self)
        print(result)
        for dates in result {
            let t = Double(dates.EntertainmentExpenses)
            let u = Double(dates.koutuu)
            let v = Double(dates.zappi)
            let x = Double(dates.event)
            let y = String(dates.date)
            let z = Double(dates.FoodExpense)
            
            let a:Double=Double(dates.event)!
            let b:Double=Double(dates.FoodExpense)!
            let c:Double=Double(dates.EntertainmentExpenses)!
            let d:Double=Double(dates.koutuu)!
            let e:Double=Double(dates.zappi)!
            
            let sum = Int(a+b+c+d+e)
            let printSum = String(sum)

            if label2.text == y {
                    ar4.append(t!)
                    ar5.append(u!)
                    ar6.append(v!)
                    ar1.append(x!)
                    ar2.append(y)
                    ar3.append(z!)
                    BaseCharts.centerText = "合計:"+printSum
                }
            
        }
        let dataSet = PieChartDataSet(values: [PieChartDataEntry(value: ar1.last!, label: "交際費"),PieChartDataEntry(value: ar3.last!, label: "食費"),PieChartDataEntry(value: ar4.last!, label: "娯楽費"),PieChartDataEntry(value: ar5.last!, label: "交通費"),PieChartDataEntry(value: ar6.last!, label: "雑費")], label: ar2.last!)
        //dataSet.colors = ChartColorTemplates.vordiplom()
        dataSet.colors = ChartColorTemplates.colorful()
        BaseCharts.data = PieChartData(dataSet: dataSet)
        ar4.append(0)
        ar5.append(0)
        ar6.append(0)
        ar1.append(0)
        ar3.append(0)
        }
    
    //func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     //   //Keyboardを閉じる
     //   ftext.resignFirstResponder()
     //   return true
   // }
    //keyboard以外の画面を押すと、keyboardを閉じる処理
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.ftext.isFirstResponder) {
            self.ftext.resignFirstResponder()
        }
    }
}

class DatePickerKeyboard: UITextField {
    
    private var datePicker: UIDatePicker!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commoninit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commoninit()
    }
    private func commoninit() {
        // datePickerの設定
        datePicker = UIDatePicker()
        datePicker.date = Date()
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ja")
        datePicker.addTarget(self, action: #selector(setText), for: .valueChanged)
        
        // textFieldのtextに日付を表示する
        setText()
        
        inputView = datePicker
        inputAccessoryView = createToolbar()
    }
    // キーボードのアクセサリービューを作成する
    private func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 44)
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: self, action: nil)
        space.width = 12
        let flexSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let todayButtonItem = UIBarButtonItem(title: "今日", style: .done, target: self, action: #selector(todayPicker))
        let doneButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePicker))
        let toolbarItems = [flexSpaceItem, todayButtonItem, doneButtonItem, space]
        toolbar.setItems(toolbarItems, animated: true)
        return toolbar
    }
    
    // キーボードの完了ボタンタップ時に呼ばれる
    @objc private func donePicker() {
        resignFirstResponder()
    }
    // キーボードの今日ボタンタップ時に呼ばれる
    @objc private func todayPicker() {
        datePicker.date = Date()
        setText()
    }
    
    // datePickerの日付けをtextFieldのtextに反映させる
    @objc private func setText() {
        let f = DateFormatter()
        f.dateStyle = .long
        f.locale = Locale(identifier: "ja")
        text = f.string(from: datePicker.date)
    }
    
    // クラス外から日付を取り出すためのメソッド
    func getDate() -> Date {
        return datePicker.date
    }
    // カーソル非表示
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect(x: 0, y: 0, width: 0, height: 0)
    }
}
