//
//  NewExamViewController.swift
//  lumos ios
//
//  Created by Shalin Shah on 6/27/17.
//  Copyright © 2017 Shalin Shah. All rights reserved.
//

import UIKit

class NewExamViewController: UIViewController {
    
    var frameExtractor: FrameExtractor!

    @IBOutlet weak var headingLabel: UILabel!
    
    var whichEye: String = ""
    var leftImage : UIImage!
    var rightImage : UIImage!
    var eyeImages = [UIImage]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.frameExtractor = FrameExtractor()
        
        self.navigationController?.navigationBar.topItem?.title = " "
        navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "AvenirNext-DemiBold", size: 15)!, NSAttributedStringKey.foregroundColor : UIColor.white]
        self.navigationItem.title = "AM I OKAY?".uppercased()
        
        // Text style for "TAKE A PICTURE" Label
        headingLabel.clipsToBounds = true
        headingLabel.alpha = 1
        headingLabel.text = "TAKE A PICTURE".uppercased()
        headingLabel.font = UIFont(name: "AvenirNext-Regular", size: 11)
        headingLabel.textColor = UIColor(red: 0.64, green: 0.64, blue: 0.64, alpha: 1)
    }
    
    @IBAction func leftEyeButtonPressed(_ sender: AnyObject) {
        
        
        whichEye = "left"
    }
    
    @IBAction func rightEyeButtonPressed(_ sender: AnyObject) {
        
        whichEye = "right"
    }
}
