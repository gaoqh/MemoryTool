//
//  HomeViewController.swift
//  MemoryTool
//
//  Created by 高庆华 on 16/6/9.
//  Copyright © 2016年 高庆华. All rights reserved.
//

import UIKit
import XCGLogger
import SnapKit
import WebImage
import FMDB

class HomeViewController: UIViewController, UINavigationControllerDelegate {
    //MARK: - 属性
    private var calendarMenuView: CVCalendarMenuView!
    private var calendarView: CVCalendarView!
    private var monthLabel: UILabel!
    private var selectedDay: DayView!
    private var addPlanBtn: UIButton!
    
    //数据源
    var reviseDaysArray: [CVDate] = [CVDate]()

    
    var animationFinished = true
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()

        setNav()
        configUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calendarMenuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
    }
    
    //MARK: - 设置UI
    func setNav() {
        navigationController?.delegate = self
        //        [self.navigationItem.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blueColor]} forState:UIControlStateNormal]; 
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(18), NSForegroundColorAttributeName: homeColor]
//        navigationController?.navigationBar.tintColor = homeColor
        navigationItem.leftBarButtonItem = UIBarButtonItem.item("", title: "今日", target: self, action: #selector(HomeViewController.leftItemClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem.item("naviItemRight", title: "", target: self, action: #selector(HomeViewController.rightItemClick))
        monthLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
        monthLabel.textColor = UIColor.darkGrayColor()
        monthLabel.textAlignment = .Center
        monthLabel.font = UIFont.boldSystemFontOfSize(20)
        monthLabel.text = CVDate(date: NSDate()).globalDescription
        navigationItem.titleView = monthLabel
    }
    
    func configUI() {
        let bgImage = UIImageView(image: UIImage(named: "homeBG"))
        view.addSubview(bgImage)
        bgImage.frame = view.frame
        
        calendarMenuView = CVCalendarMenuView()
        view.addSubview(calendarMenuView)
        calendarMenuView.snp_makeConstraints { (make) in
            make.top.equalTo(NavigationH)
            make.left.right.equalTo(0)
            make.height.equalTo(40)
        }
        calendarMenuView.backgroundColor = homeColor
        calendarMenuView.menuViewDelegate = self
        
        calendarView = CVCalendarView()
        view.addSubview(calendarView)
        calendarView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(calendarMenuView.snp_bottom).offset(10)
            make.height.equalTo(300)
        }
        calendarView.calendarDelegate = self
        calendarView.calendarAppearanceDelegate = self
        
        addPlanBtn = UIButton(type: .Custom)
        view.addSubview(addPlanBtn)
        addPlanBtn.sizeToFit()
        addPlanBtn.snp_makeConstraints { (make) in
            make.centerX.equalTo(0)
            make.bottom.equalTo(view.snp_bottom).inset(6)
        }
        
        addPlanBtn.setBackgroundImage(UIImage(named: "homeAdd"), forState: .Normal)
        addPlanBtn.addTarget(self, action: #selector(HomeViewController.addPlanBtnClick), forControlEvents: .TouchUpInside)
        
    }
    //MARK: - 点击事件
    func leftItemClick() {
        calendarView.toggleCurrentDayView()
    }
    
    func rightItemClick() {
        navigationController?.pushViewController(ReviseViewController(), animated: true)
    }
    
    func addPlanBtnClick() {
        let nav = UINavigationController(rootViewController: AddPlanViewController())
        presentViewController(nav, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    //MARK: - UINavigationDelegate
    //隐藏导航条的背景
//    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
//        if viewController === self {
//            for view in navigationController.navigationBar.subviews {
//                if view.isKindOfClass(NSClassFromString("_UINavigationBarBackground")!) {
//                    view.hidden = true
//                }
//                
//            }
//        }else {
//            for view in navigationController.navigationBar.subviews {
//                if view.isKindOfClass(NSClassFromString("_UINavigationBarBackground")!) {
//                    view.hidden = false
//                    
//                }
//            }
//        }
//    }


}
// MARK: - CVCalendarViewDelegate & CVCalendarMenuViewDelegate
extension HomeViewController: CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
    func presentationMode() -> CalendarMode {
        return .MonthView
    }
    
    func firstWeekday() -> Weekday {
        return .Monday
    }
    
    func shouldShowWeekdaysOut() -> Bool {
        return true
    }
    
    func shouldAutoSelectDayOnMonthChange() -> Bool {
        return true
    }
    
    func shouldAnimateResizing() -> Bool {
        return true // Default value is true
    }
    //选中某天
    func didSelectDayView(dayView: CVCalendarDayView, animationDidFinish: Bool) {
        print("\(dayView.date.commonDescription) is selected!")
        selectedDay = dayView
        //拿到数据源后刷新视图
    }
    
    func presentedDateUpdated(date: CVDate) {
        monthLabel.text = date.globalDescription
    }
    
    //哪些显示下部点标
    func dotMarker(shouldShowOnDayView dayView: CVCalendarDayView) -> Bool {
//        for day in reviseDaysArray {
//            if dayView.date == day {
//                return true
//            }
//        }
        return false
    }
    //点标颜色
    func dotMarker(colorOnDayView dayView: CVCalendarDayView) -> [UIColor] {
        
        return [UIColor.redColor()]
    }
    
//    func dotMarker(shouldMoveOnHighlightingOnDayView dayView: CVCalendarDayView) -> Bool {
//        return true
//    }
    
    func dotMarker(sizeOnDayView dayView: DayView) -> CGFloat {
        return 20
    }
    
    func dotMarker(moveOffsetOnDayView dayView: DayView) -> CGFloat {
        return -15
    }
    
    
    
    //星期标识
    func weekdaySymbolType() -> WeekdaySymbolType {
        return .Short
    }
    //
    func selectionViewPath() -> ((CGRect) -> (UIBezierPath)) {
        return { UIBezierPath(rect: CGRectMake(0, 0, $0.width, $0.height)) }
    }
    //自定义选中状态下的日期
    func shouldShowCustomSingleSelection() -> Bool {
        return false
    }
    //初步的视图
    func preliminaryView(viewOnDayView dayView: DayView) -> UIView {
        let circleView = CVAuxiliaryView(dayView: dayView, rect: dayView.bounds, shape: CVShape.Circle)
        circleView.fillColor = .colorFromCode(0xCCCCCC)
        return circleView
    }
    
    func preliminaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        if (dayView.isCurrentDay) {
            return true
        }
        return false
    }

//    //附加的view
//    func supplementaryView(viewOnDayView dayView: DayView) -> UIView {
//        let π = M_PI
//        
//        let ringSpacing: CGFloat = 4.0
//        let ringInsetWidth: CGFloat = 0.0
//        let ringVerticalOffset: CGFloat = 0.0
//        var ringLayer: CAShapeLayer!
//        let ringLineWidth: CGFloat = 1.0
//        let ringLineColour: UIColor = UIColor.blackColor()
//        
//        let newView = UIView(frame: dayView.bounds)
//        
//        let diameter: CGFloat = (newView.bounds.width) - ringSpacing
//        let radius: CGFloat = diameter / 2.0
//        
//        let rect = CGRectMake(newView.frame.midX-radius, newView.frame.midY-radius-ringVerticalOffset, diameter, diameter)
//        
//        ringLayer = CAShapeLayer()
//        newView.layer.addSublayer(ringLayer)
//        
//        ringLayer.fillColor = nil
//        ringLayer.lineWidth = ringLineWidth
//        ringLayer.strokeColor = ringLineColour.CGColor
//        
//        let ringLineWidthInset: CGFloat = CGFloat(ringLineWidth/2.0) + ringInsetWidth
//        let ringRect: CGRect = CGRectInset(rect, ringLineWidthInset, ringLineWidthInset)
//        let centrePoint: CGPoint = CGPointMake(ringRect.midX, ringRect.midY)
//        let startAngle: CGFloat = CGFloat(-π/2.0)
//        let endAngle: CGFloat = CGFloat(π * 2.0) + startAngle
//        let ringPath: UIBezierPath = UIBezierPath(arcCenter: centrePoint, radius: ringRect.width/2.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)
//        
//        ringLayer.path = ringPath.CGPath
//        ringLayer.frame = newView.layer.bounds
//        
//        return newView
//    }
    
//    func supplementaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
//        if (Int(arc4random_uniform(3)) == 1) {
//            return true
//        }
//        
//        return false
//    }
}


//TODO: 翻页的api是calendarView.loadPreviousView()和calendarView.loadNextView()


