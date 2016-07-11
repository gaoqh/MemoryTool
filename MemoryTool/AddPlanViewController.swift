//
//  AddPlanViewController.swift
//  MemoryTool
//
//  Created by 高庆华 on 16/6/10.
//  Copyright © 2016年 高庆华. All rights reserved.
//

import UIKit
import SnapKit
import FMDB
import Photos
import ImagePicker

let ADD_PLAN_CELL_ID = "add_plan_cell_id"
/// 子控件的间距
let CHILD_VIEW_MARGIN: CGFloat = 10

class AddPlanViewController: UIViewController {
    
    //MARK: - UI控件
    private var mainScrollView: UIScrollView!
    private var imagePickerVc: ImagePickerController!
    private var numberOfLines: Int = 1
    private let leftMargin: CGFloat = 15
    private let photoViewH: CGFloat = 120
    //MARK: - 属性
    let addPhotoBtnW: CGFloat = (SCREENW - 10 * 4) / 4
    private var reviseTitle: String!
    private var reviseContents: [String]!
        private lazy var photoArray: [ZLPhotoPickerBrowserPhoto] = [ZLPhotoPickerBrowserPhoto]()
    //复习频率
    private var reviseFreq: String!
    //MARK: - 数据库
    var dataBase: FMDatabase!
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNav()
        configUI()
        openDataBase()
        
    }
    //MARK: - 构造（析构）方法

    //MARK: - 设置UI
    func setNav() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.item("", title: "取消", target: self, action: #selector(AddPlanViewController.cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem.item("", title: "确定", target: self, action: #selector(AddPlanViewController.finish))
    }
    
    func configUI() {
        view.backgroundColor = UIColor.lightGrayColor()
        automaticallyAdjustsScrollViewInsets = false
        mainScrollView = UIScrollView()
        mainScrollView.showsHorizontalScrollIndicator = false
        mainScrollView.showsVerticalScrollIndicator = false

        view.addSubview(mainScrollView)
        mainScrollView.alwaysBounceVertical = true
        mainScrollView.backgroundColor = UIColor.whiteColor()
        
        mainScrollView.addSubview(titleView)
        mainScrollView.addSubview(photosView)
        
        setConstraints()
    }
    
    func setConstraints() {
        titleView.snp_makeConstraints { (make) in
            make.top.equalTo(NavigationH)
            make.left.equalTo(leftMargin)
            make.width.equalTo(SCREENW - 2 * leftMargin)
            make.height.equalTo(50)
        }
        photosView.snp_makeConstraints { (make) in
            make.top.equalTo(titleView.snp_bottom).offset(10)
            make.left.equalTo(0)
            make.width.equalTo(SCREENW)
            make.height.equalTo(photoViewH)
        }
        
        mainScrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    func hideKeyboard() {
        
    }
    
    func reloadPhotosView() {
        let count = photoArray.count
        let addPace = addPhotoBtnW + CHILD_VIEW_MARGIN

        let newWidth = addPace * CGFloat(count + 1)
        photosView.snp_updateConstraints { (make) in
            make.width.equalTo(newWidth)
        }
        photosView.contentSize = CGSize(width: newWidth, height: photoViewH)
        photosView.reloadData()
    }
    
    //MARK: - 懒加载子控件
    private lazy var titleView: UITextView = {
        let field = UITextView()
        field.backgroundColor = UIColor.redColor()
        field.textColor = UIColor.lightGrayColor()
        field.font = UIFont.systemFontOfSize(14)
        field.text = "想要记录的..."
        return field
    }()
    
    /// 添加图片的View
    private lazy var photosView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let itemW = self.addPhotoBtnW
        layout.itemSize = CGSizeMake(itemW, itemW)
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 15, left: CHILD_VIEW_MARGIN, bottom: 15, right: CHILD_VIEW_MARGIN)
        
        let collView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collView.backgroundColor = UIColor.whiteColor()
        collView.bounces = true
        collView.alwaysBounceHorizontal = true
        collView.scrollEnabled = true
        collView.delegate = self
        collView.dataSource = self
        collView.registerNib(UINib(nibName: "PhotoViewCell", bundle: nil), forCellWithReuseIdentifier: ADD_PLAN_CELL_ID)
        collView.showsHorizontalScrollIndicator = true
        collView.showsVerticalScrollIndicator = false
        
        return collView
    }()
    
    //MARK: - 启动数据库
    func openDataBase() {
        let documents = try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
        let fileURL = documents.URLByAppendingPathComponent("test.sqlite")
        
        dataBase = FMDatabase(path: fileURL.path)
        
        let success = dataBase.open()
        if success {
            log.info("数据库创建成功！")
            let str = "CREATE TABLE IF NOT EXISTS t_test (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, score REAL NOT NULL)"
            if dataBase.executeUpdate(str, withArgumentsInArray: nil) {
                log.info("表创建成功")
            }else {
                log.error("表创建失败")
            }
        }else {
            log.error("数据库创建失败")
        }
        
    }
    //MARK: - 点击事件
    func cancel() {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func finish() {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addBtnClick() {
        
    }


}

extension AddPlanViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if photoArray.count == 12 {
            return photoArray.count
        }else {
            return photoArray.count + 1
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ADD_PLAN_CELL_ID, forIndexPath: indexPath) as! PhotoViewCell
        //如果是最后一张图片，就是添加按钮
        if indexPath.row == photoArray.count {
            cell.imageView.image = UIImage(named: "saleAdd")
        }else {
            let photo = photoArray[indexPath.row]
            if photo.asset == nil {
                cell.imageView.image = photo.thumbImage
            }else {
                cell.imageView.image = photo.aspectRatioImage
            }
            
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        hideKeyboard()
        
        if indexPath.row == photoArray.count {
            imagePickerVc = ImagePickerController()
            imagePickerVc.delegate = self
            imagePickerVc.imageLimit = 12
            Configuration.doneButtonTitle = "完成"
            
            presentViewController(imagePickerVc, animated: true, completion: nil)
        }else {
            let brower = ZLPhotoPickerBrowserViewController()
            brower.editing = true
            brower.status = .Fade
            brower.photos = photoArray
            brower.delegate = self
            brower.currentIndex = indexPath.row
            brower.showPickerVc(self)
        }
    }

    
}

extension AddPlanViewController: ImagePickerDelegate {
    func wrapperDidPress(images: [UIImage]) {
        
    }
    
    func doneButtonDidPress(images: [UIImage]) {
        photoArray = []
        for image in images {
            photoArray.append(ZLPhotoPickerBrowserPhoto(anyImageObjWith: image))
        }
        reloadPhotosView()
        imagePickerVc.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func cancelButtonDidPress() {
        
    }
}

extension AddPlanViewController: ZLPhotoPickerBrowserViewControllerDelegate {
    func photoBrowser(photoBrowser: ZLPhotoPickerBrowserViewController!, removePhotoAtIndex index: Int) {
        if photoArray.count > index {
            photoArray.removeAtIndex(index)
            photosView.reloadData()
        }
    }
}
