//
//  DetailsViewController.swift
//  Image Compare
//
//  Created by Vijay Chandran J on 05/03/16.
//  Copyright © 2016 Vijay Chandran J. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, _DetailsViewProtocol {
    
    //MARK:- appearance 
    func show(metaDataSet metaDataSet: MetaDataSet, inViewController vc: PictureViewController) {
        
        vc.addChildViewController(self)
        self.view.alpha = 0.0
        vc.view.addSubview(self.view)
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.view.alpha = 1.0
            }) { (completed) -> Void in
                self._detailsTableViewController.tableData = metaDataSet
                self._detailsTableViewController.tableView.reloadData()
        }
    }
    
    func dismiss() {
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.view.alpha = 0.0
            }) { (completed) -> Void in
                self.removeFromParentViewController()
                self.view.removeFromSuperview()
        }
    }
    
    
    func setTarget(target: AnyObject, action: Selector) {
        _cancelButton?.target = target
        _cancelButton?.action = action
    }
    
    init(pictureViewController: PictureViewController) {
        super.init(nibName: nil, bundle: nil)
        _toolbarHeight = pictureViewController.toolbarHeight
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let detailsView = _DetailsView()
        self.view = detailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let pvc = self.parentViewController {
            let screenSize = UIScreen.mainScreen().bounds.size
            
            self.view.backgroundColor = UIColor.yellowColor()
            
                // * initialize the details table controller
            
            _detailsTableViewController = DetailsTableViewController()
            let tableView = _detailsTableViewController.tableView
            self.view.addSubview(tableView)
            
                // * the frames according to the type of device
            
            if screenSize.height < 736 {    // * less than iPhone 6s plus
                let pvcs = pvc.view.frame.size
                self.view.frame = CGRectMake(0.0, _toolbarHeight, pvcs.width, pvcs.height - _toolbarHeight)
                let s = self.view.frame.size
                
                tableView.frame = CGRectMake(
                    0.0, 0.0,
                    s.width, s.height
                )
                
                
            } else {
                let pvcs = pvc.view.frame.size
                self.view.frame = CGRectMake(
                    pvcs.width * 0.5 - pvcs.width * 0.75 * 0.5,
                    pvcs.height * 0.5 - pvcs.height * 0.75 * 0.5,
                    pvcs.width * 0.75,
                    pvcs.height * 0.75
                )
                let s = self.view.frame.size
                tableView.frame = CGRectMake(0.0, 0.0, s.width, s.height)
            }
        }
        
        
        
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        (self.view as! _DetailsView).delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if let v = self.view as? _DetailsView {
            v.delegate = nil
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK:- UITableViewDataSource/delegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        return cell
    }
    
    
    //MARK:- private
    private var _detailsTableViewController: DetailsTableViewController!
    private var _cancelButton: UIBarButtonItem?
    private var _toolbarHeight: CGFloat = 44.0 // * toolbar height of the parent view controller
    
    private func detailsViewClickedOutside(view: _DetailsView) {
        // * close the details window
        //self.view.removeFromSuperview()
        print("detailsView clicked outside")
        self.dismiss()
        
    }
    

}




//MARK:- _DetailsViewProtocol -
private protocol _DetailsViewProtocol: class {
    func detailsViewClickedOutside(view: _DetailsView)
}

//MARK:- _DetailsView -
/*
    View to find out of view touches
*/
private class _DetailsView: UIView {
    weak var delegate: _DetailsViewProtocol?
    
    private override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        print("point:", point, "frame:", self.frame)
        if point.x < 0.0 ||
            point.y < 0.0 ||
            point.x > self.frame.size.width ||
            point.y > self.frame.size.height {
            if let method = delegate?.detailsViewClickedOutside(self) {
                method
            }
        }
        return super.hitTest(point, withEvent: event)
    }
}
