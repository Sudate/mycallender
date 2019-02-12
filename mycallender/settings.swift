//
//  settings.swift
//  mycallender
//
//  Created by Okura on 2019/02/11.
//  Copyright © 2019 kentarou sudate. All rights reserved.
//

import UIKit

class settings: UITableViewController {

    @IBOutlet weak var fontFamily: UILabel!
    @IBOutlet weak var fontSize: UILabel!
    @IBOutlet weak var versionNumber: UILabel!
    
    //フォントの設定。アプリ全体に適用される。
    var setFontFamily: String = "Helvetica Neue"
    var setFontSize: CGFloat = 17
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fontFamily.text = setFontFamily
        
        // UserDefaultsの情報を画面にセットする
        if let name = UserDefaults.standard.value(forKey: "name") as? String {
            fontFamily.text = name
        }
        
        // アプリのバージョン
        if let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            versionNumber.text = version
        }
        
    }

    //セクションの数
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //各セクションの項目の数。name1.countは多分リストの長さを拾ってくる関数だと思う。
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: // 「設定」のセクション
            return 1
        case 1: // 「その他」のセクション
            return 1
        default: // ここが実行されることはないはず
            return 0
        }
    }
}
