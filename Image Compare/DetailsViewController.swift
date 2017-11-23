//
//  DetailsViewController.swift
//  Image Compare
//
//  Created by Vijay Chandran J on 05/03/16.
//  Copyright © 2016 Vijay Chandran J. All rights reserved.
//

import UIKit

/** 
    Displays the image metadata. Changes layout according to device / screen size.
*/
class DetailsViewController: UIViewController, _DetailsViewProtocol {
    
    /** the overlay frame that is calculated based on the screen size */
    static var overlayFrame: CGRect = CGRect.zero
    
    /**
     Sets the metadata to be displayed
     - parameters:
        - metaDataSet: the MetaDataSet object to be displayed
     */
    func show(metaDataSet: MetaDataSet, inViewController vc: PictureViewController) {
        
        vc.addChildViewController(self)
        self.view.alpha = 0.0
        vc.view.addSubview(self.view)
        
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.view.alpha = 1.0
            }, completion: { (completed) -> Void in
                self._detailsTableViewController.tableData = metaDataSet
                self._detailsTableViewController.tableView.reloadData()
        }) 
    }
    
    /** dismisses the view controller */
    func dismiss(_ completedAction: @escaping (_ completed: Bool)->()) {
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.view.alpha = 0.0
            }, completion: { (completed_) -> Void in
                self.removeFromParentViewController()
                self.view.removeFromSuperview()
                completedAction(completed_)
        }) 
    }
    
    /** sets the method, and it's instance, to be called to dismiss this view controller (when clicked outside) */
    func set(dismissTarget: AnyObject, action: @escaping (() -> Void)) {
        _dismissTarget = dismissTarget
        _dismissAction = action
        
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
        
        if let pvc = self.parent {
            let screenSize = UIScreen.main.bounds.size
            
            self.view.backgroundColor = UIColor.clear
            
                // * initialize the details table controller
            
           
            
                // * the view frames according to the type of device
            
            // * set the static variable before initialzing the DetailsViewController, so that the variable can be used by the controller
            if screenSize.height < 736 {    // * less than iPhone 6 plus
                
                let pvcs = pvc.view.frame.size
                DetailsViewController.overlayFrame = CGRect(x: 0.0, y: _toolbarHeight, width: pvcs.width, height: pvcs.height - _toolbarHeight)
                
                
            } else {
                
                let pvcs = CGSize(width: pvc.view.frame.size.width, height: pvc.view.frame.size.height - _toolbarHeight)
                DetailsViewController.overlayFrame = CGRect(
                    x: pvcs.width * 0.5 - pvcs.width * 0.75 * 0.5,
                    y: pvcs.height * 0.5 - pvcs.height * 0.75 * 0.5 + _toolbarHeight,
                    width: pvcs.width * 0.75,
                    height: pvcs.height * 0.75
                )
            }
            
            self.view.frame = DetailsViewController.overlayFrame
            _detailsTableViewController = DetailsTableViewController()
            let tableView = _detailsTableViewController.tableView
            self.view.addSubview(tableView!)
            tableView?.frame = self.view.bounds
        }
        
        
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (self.view as! _DetailsView).delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
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
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    
    //MARK:- private
    fileprivate var _detailsTableViewController: DetailsTableViewController!
    fileprivate var _toolbarHeight: CGFloat = c_TOOL_BAR_HEIGHT // * toolbar height of the parent view controller
    fileprivate var _dismissTarget: AnyObject? // * an instance that handles the dismissal of this controller (called for out-of-view touches)
    //private var _dismissAction: Selector? // * the selector that handles the dismissal of this controller (called for out-of-view touches)
    fileprivate var _dismissAction: (() -> Void)?
    
    fileprivate func detailsViewClickedOutside(_ view: _DetailsView) {
        // * close the details window
        //self.view.removeFromSuperview()
        print("detailsView clicked outside")
        if let action = _dismissAction {
            action()
        }
        
    }
    

}




//MARK:- _DetailsViewProtocol -
private protocol _DetailsViewProtocol: class {
    func detailsViewClickedOutside(_ view: _DetailsView)
}

//MARK:- _DetailsView -
/*
    View to find out of view touches
*/
private class _DetailsView: UIView {
    weak var delegate: _DetailsViewProtocol?
    
    fileprivate override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("point:", point, "frame:", self.frame)
        if point.x < 0.0 ||
            point.y < 0.0 ||
            point.x > self.frame.size.width ||
            point.y > self.frame.size.height {
            if let method = delegate?.detailsViewClickedOutside(self) {
                method
            }
        }
        return super.hitTest(point, with: event)
    }
}
