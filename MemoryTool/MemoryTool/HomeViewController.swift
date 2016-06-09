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

class HomeViewController: UIViewController, UINavigationControllerDelegate {
    //MARK: - 属性
    private var calendarMenuView: CVCalendarMenuView!
    private var calendarView: CVCalendarView!
    private var monthLabel: UILabel!
    private var selectedDay:DayView!
    
    var animationFinished = true
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()

        setNav()
        configUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calendarMenuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
    }
    //MARK: - 设置UI
    func setNav() {
        navigationController?.delegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.item("", title: "今日", target: self, action: #selector(HomeViewController.leftItemClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem.item("naviItemRight", title: "", target: self, action: #selector(HomeViewController.rightItemClick))
        monthLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        monthLabel.textColor = UIColor.darkGrayColor()
        monthLabel.textAlignment = .Center
        monthLabel.font = UIFont.boldSystemFontOfSize(20)
        monthLabel.text = CVDate(date: NSDate()).globalDescription
        navigationItem.titleView = monthLabel
    }
    
    func configUI() {
        let bgImage = UIImageView(image: UIImage(named: "homeBG"))
        view.addSubview(bgImage)
        bgImage.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        calendarMenuView = CVCalendarMenuView()
        view.addSubview(calendarMenuView)
        calendarMenuView.alpha = 0.8
        calendarMenuView.menuViewDelegate = self
        calendarMenuView.snp_makeConstraints { (make) in
            make.top.equalTo(NavigationH + 10)
            make.width.equalTo(SCREENW)
            make.height.equalTo(10)
            make.centerX.equalTo(0)
        }
        
        calendarView = CVCalendarView()
        view.addSubview(calendarView)
        calendarView.alpha = 0.8
        calendarView.calendarDelegate = self
        calendarView.calendarAppearanceDelegate = self
        calendarView.snp_makeConstraints { (make) in
            make.top.equalTo(calendarMenuView.snp_bottom).offset(5)
            make.width.equalTo(SCREENW)
            make.height.equalTo(350)
            make.centerX.equalTo(calendarMenuView)
        }
        
    }
    //MARK: - 点击事件
    func leftItemClick() {
        calendarView.toggleCurrentDayView()
    }
    
    func rightItemClick() {
        navigationController?.pushViewController(ReviseViewController(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UINavigationDelegate
    //隐藏导航条的背景
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        if viewController === self {
            for view in navigationController.navigationBar.subviews {
                if view.isKindOfClass(NSClassFromString("_UINavigationBarBackground")!) {
                    view.hidden = true
                }
                
            }
        }else {
            for view in navigationController.navigationBar.subviews {
                if view.isKindOfClass(NSClassFromString("_UINavigationBarBackground")!) {
                    view.hidden = false
                    
                }
            }
        }
    }


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
    
    func shouldAnimateResizing() -> Bool {
        return true // Default value is true
    }
    //选中某天
    func didSelectDayView(dayView: CVCalendarDayView, animationDidFinish: Bool) {
        print("\(dayView.date.commonDescription) is selected!")
        selectedDay = dayView
    }
    
    func presentedDateUpdated(date: CVDate) {
        if monthLabel.text != date.globalDescription && self.animationFinished {
            let updatedMonthLabel = UILabel()
            updatedMonthLabel.textColor = monthLabel.textColor
            updatedMonthLabel.font = monthLabel.font
            updatedMonthLabel.textAlignment = .Center
            updatedMonthLabel.text = date.globalDescription
            updatedMonthLabel.sizeToFit()
            updatedMonthLabel.alpha = 0
            updatedMonthLabel.center = CGPoint(x: self.monthLabel.center.x, y: self.monthLabel.center.y + 20)
            
            let offset = CGFloat(48)
            updatedMonthLabel.transform = CGAffineTransformMakeTranslation(0, offset)
            updatedMonthLabel.transform = CGAffineTransformMakeScale(1, 0.1)
            
            UIView.animateWithDuration(0.35, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.animationFinished = false
                self.monthLabel.transform = CGAffineTransformMakeTranslation(0, -offset)
                self.monthLabel.transform = CGAffineTransformMakeScale(1, 0.1)
                self.monthLabel.alpha = 0
                
                updatedMonthLabel.alpha = 1
                updatedMonthLabel.transform = CGAffineTransformIdentity
                
            }) { _ in
                
                self.animationFinished = true
                self.monthLabel.frame = updatedMonthLabel.frame
                self.monthLabel.text = updatedMonthLabel.text
                self.monthLabel.transform = CGAffineTransformIdentity
                self.monthLabel.alpha = 1
                updatedMonthLabel.removeFromSuperview()
            }
            
            self.view.insertSubview(updatedMonthLabel, aboveSubview: self.monthLabel)
        }
    }
    
    //哪些显示下部点标
    func dotMarker(shouldShowOnDayView dayView: CVCalendarDayView) -> Bool {
        
        return true
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


