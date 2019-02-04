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

    var ftext = UITextField()
    let chart = PieChartView()
    let label = UILabel()
    var textFieldString = ""
    
    var ar:[Double] = []
    var ar2:[String] = []
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet var BaseCharts: PieChartView!
    @IBOutlet weak var label2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //ftext.keyboardType = UIKeyboardType.numberPad

        button.frame = CGRect(x:500, y : 100, width:100, height : 50);
        label.frame = CGRect(x:320, y:150, width:160, height:30)
        label2.frame = CGRect(x:230, y:200, width:300, height:50)
        ftext.frame = CGRect(x : 270, y : 100, width:200, height : 50);
        chart.frame = CGRect(x : 50, y : 300, width : 650, height :  650);
        chart.chartDescription?.enabled = false
        
        
        // テキストを中央寄せ
        label2.textAlignment = NSTextAlignment.center
        
        label2.layer.borderColor = UIColor(red: 0.1, green: 0.7, blue: 1.0, alpha: 0.5).cgColor
        label2.layer.borderWidth = 2
        label2.layer.masksToBounds = true
        label2.layer.cornerRadius = 10

        ftext.borderStyle = .roundedRect
        ftext.clearButtonMode = .whileEditing
        ftext.returnKeyType = .done
        ftext.placeholder = "入力してください"
        label.text = "例:2019/01/01"
        

        //let rgba = UIColor(red: 255/255, green: 128/255, blue: 168/255, alpha: 1.0)
        //button2.backgroundColor = rgba
        //let dataSet = PieChartDataSet(values: [PieChartDataEntry(value: 10, label: "A"), PieChartDataEntry(value: 90, label: "B")], label: "Data")
        //dataSet.colors = ChartColorTemplates.vordiplom()
        //chart.data = PieChartData(dataSet: dataSet)
        view.addSubview(chart)
        view.addSubview(ftext)
        view.addSubview(label)

        //var ar:[Double] = []
        //var ar2:[String] = []
        //let realm = try! Realm()
        //let result = realm.objects(Event.self)
        //chart.centerText = "One Week"
        //let results = realm.objects(Event.self).sorted(byKeyPath: "event", ascending: false)
        //for dates in result {
            //print(dates.date)
            //print(results)
            //print(dates.event)
            //let x = Double(dates.event)
            //let y = String(dates.date)
            //print(y)
            //ar.append(x!)
            //ar2.append(y)
        }
        
        //let dataSet = PieChartDataSet(values: [PieChartDataEntry(value: ar[0], label: ar2[0]), PieChartDataEntry(value: ar[1], label: ar2[1]),PieChartDataEntry(value: ar[2], label: ar2[2]),PieChartDataEntry(value: ar[3], label: ar2[3]),PieChartDataEntry(value: ar[4], label: ar2[4]),PieChartDataEntry(value: ar[5], label: ar2[5]),PieChartDataEntry(value: ar[6], label: ar2[6])], label: "Date")
        //dataSet.colors = ChartColorTemplates.vordiplom()
        //chart.data = PieChartData(dataSet: dataSet)
    


    
    @IBAction func tapped_button(_ sender: Any) {
        label2.text = ftext.text
        ftext.text = ""
        let realm = try! Realm()
        let result = realm.objects(Event.self)
        for dates in result {
            let x = Double(dates.event)
            let y = String(dates.date)
            if label2.text == y {
                ar.append(x!)
                ar2.append(y)
                chart.centerText = dates.date
            }
            
        }
        //let dataSet = PieChartDataSet(values: [PieChartDataEntry(value: ar[0], label: ar2[0]), PieChartDataEntry(value: ar[1], label: ar2[1]),PieChartDataEntry(value: ar[2], label: ar2[2]),PieChartDataEntry(value: ar[3], label: ar2[3]),PieChartDataEntry(value: ar[4], label: ar2[4]),PieChartDataEntry(value: ar[5], label: ar2[5]),PieChartDataEntry(value: ar[6], label: ar2[6])], label: "Date")
        let dataSet = PieChartDataSet(values: [PieChartDataEntry(value: ar[0], label: ar2[0])], label: "Date")
        dataSet.colors = ChartColorTemplates.vordiplom()
        chart.data = PieChartData(dataSet: dataSet)
        print(result)
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Keyboardを閉じる
        ftext.resignFirstResponder()
        return true
    }
    //keyboard以外の画面を押すと、keyboardを閉じる処理
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.ftext.isFirstResponder) {
            self.ftext.resignFirstResponder()
        }
    }
}
