//
//  FeedbackViewController.swift
//  MemoryTool
//
//  Created by 高庆华 on 16/6/14.
//  Copyright © 2016年 高庆华. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {

    @IBOutlet weak var contentLabel: UILabel!
    
    @IBAction func feedbackBtnClick(sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    func configUI() {
        contentLabel.text = "我们将专门为您改进APP，请将建议发表在App Store的评论里面"
        contentLabel.font = UIFont.systemFontOfSize(14)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
