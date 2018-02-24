//
//  NewExamViewController.swift
//  lumos ios
//
//  Created by Shalin Shah on 6/27/17.
//  Copyright © 2017 Shalin Shah. All rights reserved.
//

import UIKit

class NewExamViewController: UIViewController, FrameExtractorDelegate {
    
    @IBOutlet weak var leftEyeImg: UIImageView!
    @IBOutlet weak var rightEyeImg: UIImageView!
    @IBOutlet weak var headingLabel: UILabel!
    
    var frameExtractor: FrameExtractor!
    var imgFrames = [UIImage]()
    var whichEye: String = ""
    var eyeImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func captured(image: UIImage) {
        
        leftEyeImg.image = image
    }
    
    @IBAction func stopTapped(_ sender: UIButton) {
        frameExtractor.stopSession()
        imgFrames = frameExtractor.imgFrames
    }
    
    @IBAction func leftEyeButtonPressed(_ sender: AnyObject) {
         self.frameExtractor = FrameExtractor()
        frameExtractor.delegate = self
        whichEye = "left"
    }
    
    @IBAction func rightEyeButtonPressed(_ sender: AnyObject) {
        
        whichEye = "right"
    }
}
