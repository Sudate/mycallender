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
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var pieChart: PieChartView!
    
    var pickerView: UIPickerView = UIPickerView()
    let list: [String] = ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月","9月","10月","11月","12月"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ピッカー設定
        pickerView.delegate = self as UIPickerViewDelegate
        pickerView.dataSource = self as UIPickerViewDataSource
        pickerView.showsSelectionIndicator = true
        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        // インプットビュー設定
        textField.inputView = pickerView
        textField.inputAccessoryView = toolbar
        
        
        pieChart.frame = CGRect(x : 50, y : 300, width : 650, height :  650);
        pieChart.chartDescription?.enabled = false
        view.addSubview(pieChart)
        
        
        
    }
    // 決定ボタン押下
    @objc func done() {
        textField.endEditing(true)
        textField.text = "\(list[pickerView.selectedRow(inComponent: 0)])"
        
        let realm = try! Realm()
        let result = realm.objects(Event.self)
        print(result)
        
    }
}

extension mgraph : UIPickerViewDelegate, UIPickerViewDataSource {
    //列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    // ドラムロールの各タイトル
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    //選択時
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
     self.textField.text = list[row]
     }
}
