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
    @IBOutlet weak var versionNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "設定"
        
        // UserDefaultsの情報を画面にセットする。
        if let setFontFamily = UserDefaults.standard.value(forKey: "fontFamily") as? String {
            fontFamily.text = setFontFamily
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
    
    //各セクションの項目の数。
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: // 「設定」のセクション
            return 2
        case 1: // 「その他」のセクション
            return 1
        default: // ここが実行されることはないはず
            return 0
        }
    }
}
