//
//  themeColorTable.swift
//  mycallender
//
//  Created by Okura on 2019/02/13.
//  Copyright © 2019 kentarou sudate. All rights reserved.
//

import UIKit

class themeColorTable: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var themeColorPicker: UIPickerView!
    
    var setR: CGFloat = 153
    var setG: CGFloat = 204
    var setB: CGFloat = 255
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "テーマカラー"
        themeColorPicker.dataSource = self
        themeColorPicker.delegate = self
    }

    //ここからはテーブルの設定
    //セクションの数
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //各セクションの項目の数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: // 「テーマカラー」のセクション
            return 2
        default: // ここが実行されることはないはず
            return 0
        }
    }
    
    //ここからはテーマカラーを決めるPickerViweの設定
    //themeColorPickerの中身のリスト
    var themeColorList = ["スカイブルー", "グリーン", "イエロー", "ピンク", "ベージュ"]
    
    //themeColorPickerの列を1にする。
    func numberOfComponents(in fontFamilyPicker: UIPickerView) -> Int {
        return 1
    }
    //themeColorPickerの行をリストの要素数にする。
    func pickerView(_ fontFamilyPicker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return themeColorList.count
    }
    
    func pickerView(_ fontFamilyPicker: UIPickerView, titleForRow row: Int, forComponent component: Int)-> String? {
        return themeColorList[row]
    }
    
    //themeColorPickerのrowが選択された時の挙動
    func pickerView(_ fontFamilyPicker: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        let selectThemeColor: String = themeColorList[row]
        //選んだ色によってrgbの値を変える。
        switch selectThemeColor {
        case "スカイブルー":
            setR = 153
            setG = 204
            setB = 255
        case "グリーン":
            setR = 153
            setG = 255
            setB = 0
        case "ピンク":
            setR = 255
            setG = 204
            setB = 255
        case "イエロー":
            setR = 255
            setG = 255
            setB = 102
        case "ベージュ":
            setR = 255
            setG = 204
            setB = 153
        default: // ここが実行されることはないはず
            setR = 153
            setG = 204
            setB = 255
        }
    }
    
    @IBAction func themeColorButton(_ sender: Any) {
        //テーマカラーの設定をアプリ全体に適用。
        self.navigationController?.navigationBar.barTintColor = UIColor(red: setR/255, green: setG/255, blue: setB/255, alpha: 1)
        UINavigationBar.appearance().barTintColor = UIColor(red: setR/255, green: setG/255, blue: setB/255, alpha: 1)
        //UserDefaultsにテーマカラーの設定を保存。次回のアプリ起動時にAppDelegate.swiftで呼び出される。
        UserDefaults.standard.set(setR, forKey: "themeColorR")
        UserDefaults.standard.set(setG, forKey: "themeColorG")
        UserDefaults.standard.set(setB, forKey: "themeColorB")
    }
    
}
