//
//  themeColorTable.swift
//  mycallender
//
//  Created by Okura on 2019/02/13.
//  Copyright © 2019 kentarou sudate. All rights reserved.
//

import UIKit

class themeColorTable: UITableViewController {
    
    @IBOutlet var colorTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "テーマカラー"
        colorTableView.dataSource = self
        colorTableView.delegate = self
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }

}
