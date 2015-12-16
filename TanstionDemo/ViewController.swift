//
//  ViewController.swift
//  TanstionDemo
//
//  Created by zmjios on 15/12/11.
//  Copyright © 2015年 zmjios. All rights reserved.
//

import UIKit

struct ClassModel{
    var title:String?
    var subTitle:String?
    var controller:String?
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    
    
    var tableView:UITableView?
    let dataSource:[ClassModel] = [ClassModel.init(title: "ios7 before", subTitle: "demo1", controller: "ContainerViewController"),
                                   ClassModel.init(title: "ios7 after", subTitle: "demo2", controller: "CustomViewController"),
                                   ClassModel.init(title: "ios7 after", subTitle: "customAnimationForNavigationController", controller: "CustomNaviViewController"),
                                   ClassModel.init(title: "ios7 after", subTitle: "仿网易新闻", controller: "NewsViewController"),
                                   ClassModel.init(title: "ios7 after", subTitle: "常见查看图片详情", controller: "SourceViewController")]
    
    var naviManager:NagationAnimationManager?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Transtion Demo"
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.tableView = UITableView.init(frame: self.view.bounds, style: UITableViewStyle.Grouped);
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.view.addSubview(self.tableView!)
        
        self.tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellId")

    
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            
            return 1;
        }else
        {
            return self.dataSource.count - 1
        }
        
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0{
            
            return "ios7 before"
        }else
        {
            return "ios7 after"
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cellId")!
        
        if indexPath.section == 0{
            
            cell.textLabel?.text = (self.dataSource.first as ClassModel!).subTitle
        }else
        {
            if (indexPath.row >= 0 && indexPath.row + 1 <= self.dataSource.count){
                cell.textLabel?.text = (self.dataSource[indexPath.row + 1] as ClassModel!).subTitle
            }
            
        }
        
        
        
    
        
        return cell
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let className :String? = (indexPath.section == 0) ? (self.dataSource[0] as ClassModel!).controller:(self.dataSource[indexPath.row + 1] as ClassModel!).controller
        if className != nil && TranstionUtil.swiftClassFromString(className) != nil  {
            if let vc:UIViewController? = (TranstionUtil.swiftClassFromString(className) as! UIViewController.Type).init(){
                
                if(className == "NewsViewController"){
                    
                    if naviManager == nil{
                        
                        naviManager =  NagationAnimationManager.init(navi: self.navigationController!)
                        
                    }
                    
                    navigationController?.delegate = naviManager
                    
                }else
                {
                    navigationController?.delegate = nil;
                }
                
                self.navigationController!.pushViewController(vc!, animated: true)
            }
        }
    }

    

    
}

