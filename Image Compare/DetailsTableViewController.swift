//
//  DetailsTableViewController.swift
//  Image Compare
//
//  Created by Vijay Chandran J on 08/03/16.
//  Copyright © 2016 Vijay Chandran J. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController {
    
    
    static var valueFrame: CGRect?
    
    var tableData: MetaDataSet?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.registerClass(DetailsTableViewCell.self, forCellReuseIdentifier: CELL_ID)
        self.tableView.registerClass(DetailsTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HEADER_ID)
        
        self.tableView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        self.tableView.separatorColor = UIColor.whiteColor()
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
//    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return tableData?[section].typeName
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let metaData = tableData?[section] {
            return metaData.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let metaData = tableData?[indexPath.section] {
            return DetailsTableViewCell.heightForMetaDataElement(metaDataElement: metaData[indexPath.row])
        }
        return 44.0
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let ret = tableView.dequeueReusableHeaderFooterViewWithIdentifier(HEADER_ID)
        return ret
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let headerView = view as! DetailsTableViewHeaderFooterView
        //headerView.contentView.backgroundColor = UIColor.clearColor()
        //return
        //let headerView = view as! TableViewHeaderFooterView
        headerView.titleLabel.text = tableData?[section].typeName
        return
        //headerView.contentView.backgroundColor = COLOR_THEME
        
        //headerView.textLabel?.textAlignment = NSTextAlignment.Center
        //headerView.textLabel?.textColor = COLOR_THEME_HIGHLIGHT
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: DetailsTableViewCell = tableView.dequeueReusableCellWithIdentifier(CELL_ID, forIndexPath: indexPath) as! DetailsTableViewCell
        if let metaData = tableData?[indexPath.section] {
            let metaDataElement = metaData[indexPath.row] as? DeltaMetaDataElement
            //cell.textLabel?.text = metaDataElement.title
            //cell.detailTextLabel?.text = metaDataElement.valueString
            cell.metaDataElement = metaDataElement
            
        }
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = COLOR_THEME_HIGHLIGHT
        
        return cell
    }
    
    private let CELL_ID = "cell"
    private let HEADER_ID = "header"

   
}
