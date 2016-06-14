//
//  ReviseViewController.swift
//  MemoryTool
//
//  Created by 高庆华 on 16/6/9.
//  Copyright © 2016年 高庆华. All rights reserved.
//

import UIKit

enum ReviseCellType: Int {
    /// 复习内容
    case ReviseContent = 0
    /// 记忆曲线
    case MemoryCurve = 1
    /// 复习提醒
    case ReviseRemind = 2
    ///  反馈
    case Feedback = 3
}

class ReviseViewController: UIViewController {
    //MARK: - 属性
    private var tableView: UITableView!
    private var reviseSwitch: UISwitch!
    //图片名称
    private lazy var icons: NSMutableArray = NSMutableArray(array: ["usercenter", "orders", "setting_like", "feedback", "recomment"])
    //标题名称
    private lazy var titles: NSMutableArray = NSMutableArray(array: ["复习内容", "记忆曲线", "复习提醒", "反馈"])
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
        setNav()
        setTableView()
    }
    //MARK: - 设置UI
    func setNav() {
        
    }
    
    func setTableView() {
        automaticallyAdjustsScrollViewInsets = false
        tableView = UITableView(frame: CGRectMake(0, NavigationH, SCREENW, SCREENH), style: UITableViewStyle.Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 44
        tableView.sectionFooterHeight = 0.1
                tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        view.addSubview(tableView)
    }

    
}

extension ReviseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return titles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let reuseID: String = "reviseCellID"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(reuseID)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: reuseID)
            //给不同行的cell设置不同显示方式
            switch indexPath.section {
            case 0:
                cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            case 1:
                cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                let label = UILabel()
                label.text = "自定义"
                label.font = UIFont.systemFontOfSize(10)
                label.sizeToFit()
                label.backgroundColor = UIColor.clearColor()
                label.frame = CGRect(x: SCREENW - label.width - 25, y: 12, width: label.width, height: label.height)
                cell?.contentView.addSubview(label)
                label.textColor = UIColor.grayColor()
            case 2:
                cell!.accessoryType = UITableViewCellAccessoryType.None
                reviseSwitch = UISwitch()
                reviseSwitch.frame.origin = CGPoint(x: SCREENW - reviseSwitch.width - 12, y: ((cell?.height)! - reviseSwitch.height) * 0.5)
                cell?.contentView.addSubview(reviseSwitch)
            case 3:
                cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            default:break
            }
            
            cell?.selectionStyle = .None
            cell?.textLabel?.text = titles[indexPath.section] as? String
        }
        
        
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case ReviseCellType.ReviseContent.hashValue:
            navigationController?.pushViewController(ReviseContentController(), animated: true)
            
        case 1:
            navigationController?.pushViewController(CurveSettingController(), animated: true)
        case 2:
            break
        case 3:
            navigationController?.pushViewController(FeedbackViewController(), animated: true)
        default:
            break
        }
    }
    
    
}
