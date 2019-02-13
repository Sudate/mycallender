//
//  mgraph.swift
//  mycallender
//
//  Created by kentarou sudate on 2019/02/11.
//  Copyright © 2019 kentarou sudate. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class mgraph: UIViewController {
    
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var fftext: DatePickerKeyboard2!
    @IBOutlet weak var label3: UILabel!
    
    var pickerView: UIPickerView = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // ピッカー設定

        
        
        pieChart.frame = CGRect(x : 50, y : 300, width : 650, height :  650);
        pieChart.chartDescription?.enabled = false
        view.addSubview(pieChart)
    
    }

    @IBAction func button2(_ sender: Any) {
        let text2 = fftext.text
        
        if text2!.isEmpty{
            fftext.text = "2019/1/21"
        }
        var moji2 = String(fftext.text!)
        if let range = moji2.range(of: "年") {
            moji2.replaceSubrange(range, with: "/")
        }
        if let range = moji2.range(of: "月") {
            moji2.replaceSubrange(range, with: "/")
        }
        if let range = moji2.range(of: "日") {
            moji2.replaceSubrange(range, with: "")
        }
        //print(moji2)
        var k = String(moji2)
        let c = NSMutableString(string: moji2)
        let a = String(moji2[moji2.index(moji2.startIndex, offsetBy: 5)])
        let e = String(moji2[moji2.index(moji2.startIndex, offsetBy: 6)])
        let f = Int(e)
        let b = Int(a)
        if  b == 1 {
            if f == 0 || f == 1 || f == 2{
                label3.text = String(k.prefix(6))
                print(label3.text)
            }
        }else{
            c.insert("0", at: 5)
            k = String(c)
            label3.text = String(k.prefix(7))
            //let g = String(k.prefix(7))
            print(label3.text)
        }
        let g = String(k.prefix(7))
        var arFood2:[Double] = []
        var arEnter2:[Double] = []
        var arEvent2:[Double] = []
        var arKoutuu2:[Double] = []
        var arZappi2:[Double] = []
        let realm = try! Realm()
        //let label3Results = realm.objects(Event.self).filter("date BEGINSWITH '\(label3.text)'")
        let label3Results = realm.objects(Event.self).filter("date BEGINSWITH '\(g)'")
        for tu in label3Results{
            let f = Double(tu.FoodExpense)
            let k = Double(tu.koutuu)
            let z = Double(tu.zappi)
            let e = Double(tu.event)
            let p = Double(tu.EntertainmentExpenses)
            arFood2.append(f!)
            arEnter2.append(p!)
            arZappi2.append(z!)
            arKoutuu2.append(k!)
            arEvent2.append(e!)
            
        }
        //print(fftextResults)
        
        
        
        let foodSum2 = arFood2.reduce(0,+)
        let eventSum2 = arEvent2.reduce(0,+)
        let zappiSum2 = arZappi2.reduce(0,+)
        let koutuuSum2 = arKoutuu2.reduce(0,+)
        let enterSum2 = arEnter2.reduce(0,+)
        
        let foodInt2 = Int(foodSum2)
        let eventInt2 = Int(eventSum2)
        let zappiInt2 = Int(zappiSum2)
        let koutuuInt2 = Int(koutuuSum2)
        let enterInt2 = Int(enterSum2)
        
        let aTuki2:Double=Double(eventSum2)
        let bTuki2:Double=Double(foodSum2)
        let cTuki2:Double=Double(enterSum2)
        let dTuki2:Double=Double(koutuuSum2)
        let eTuki2:Double=Double(zappiSum2)
        
        let sumTuki2 = aTuki2+bTuki2+cTuki2+dTuki2+eTuki2
        
        let printSum2 = String(sumTuki2)
        
        pieChart.centerText = "合計:"+printSum2
        let dataSet = PieChartDataSet(values: [PieChartDataEntry(value: Double(eventInt2), label: "交際費"),PieChartDataEntry(value: Double(foodInt2), label: "食費"),PieChartDataEntry(value: Double(enterInt2), label: "娯楽費"),PieChartDataEntry(value: Double(koutuuInt2), label: "交通費"),PieChartDataEntry(value: Double(zappiInt2), label: "雑費")], label: label3.text)
        dataSet.colors = ChartColorTemplates.vordiplom()
        dataSet.colors = ChartColorTemplates.colorful()
        pieChart.data = PieChartData(dataSet: dataSet)
        print(foodInt2)
    }
    @IBAction func btnPrev_click(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}






class DatePickerKeyboard2: UITextField {
    
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

