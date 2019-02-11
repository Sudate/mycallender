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
    let label = UILabel()
    var textFieldString = ""
    
    var ar:[Double] = []
    var ar2:[String] = []
    var ar3:[Double] = []
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet var BaseCharts: PieChartView!
    @IBOutlet weak var label2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.frame = CGRect(x:500, y : 100, width:100, height : 50);
        label.frame = CGRect(x:320, y:150, width:160, height:30)
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

        ftext.borderStyle = .roundedRect
        ftext.clearButtonMode = .whileEditing
        ftext.returnKeyType = .done
        ftext.placeholder = "入力してください"
        
        label.text = "例:2019/01/01"
        
        //dataSet.colors = ChartColorTemplates.vordiplom()
        view.addSubview(BaseCharts)
        view.addSubview(ftext)
        view.addSubview(label)
        }
    @IBAction func tapped_button(_ sender: Any) {
        label2.text = ftext.text
        ftext.text = ""
        let realm = try! Realm()
        let result = realm.objects(Event.self)
        print(result)
        for dates in result {
            let x = Double(dates.event)
            let y = String(dates.date)
            let z = Double(dates.FoodExpense)
            if label2.text == y {
                    ar.append(x!)
                    ar2.append(y)
                    ar3.append(z!)
                BaseCharts.centerText = dates.date
                let dataSet = PieChartDataSet(values: [PieChartDataEntry(value: ar.last!, label: "ALL"),PieChartDataEntry(value: ar3.last!, label: "Food")], label: "Date")
                //dataSet.colors = ChartColorTemplates.vordiplom()
                dataSet.colors = ChartColorTemplates.colorful()
                BaseCharts.data = PieChartData(dataSet: dataSet)
            }
        }
       
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
