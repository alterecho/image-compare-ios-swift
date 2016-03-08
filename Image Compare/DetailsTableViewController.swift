//
//  DetailsTableViewController.swift
//  Image Compare
//
//  Created by Vijay Chandran J on 08/03/16.
//  Copyright © 2016 Vijay Chandran J. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController {
    
    var tableData: MetaDataSet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: CELL_ID)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let count = tableData?.count {
            return count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableData?[section].typeName
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let metaData = tableData?[section] {
            return metaData.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.contentView.backgroundColor = UIColor.redColor()
        headerView.textLabel?.textAlignment = NSTextAlignment.Center
        
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CELL_ID, forIndexPath: indexPath)
        if let metaData = tableData?[indexPath.section] {
            let metaDataElement = metaData[indexPath.row]
            cell.textLabel?.text = metaDataElement.title
            cell.detailTextLabel?.text = metaDataElement.valueString
            
        }
        
        return cell
    }
    
    private let CELL_ID = "cell"

   
}
