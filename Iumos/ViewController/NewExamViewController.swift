//
//  NewExamViewController.swift
//  lumos ios
//
//  Created by Shalin Shah on 6/27/17.
//  Copyright © 2017 Shalin Shah. All rights reserved.
//

import UIKit
import Fusuma

class NewExamViewController: UIViewController, FusumaDelegate {
    


    @IBOutlet weak var headingLabel: UILabel!
    
    var whichEye: String = ""
    var leftImage : UIImage!
    var rightImage : UIImage!
    var eyeImages = [UIImage]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
        // Show Fusuma
        let fusuma = FusumaViewController()
        fusumaCropImage = false
//        fusuma.hasVideo = false
        fusuma.delegate = self
        self.present(fusuma, animated: true, completion: nil)

        
        whichEye = "left"
    }
    
    //    MARK: fix me, find a way to false hasVideo
    @IBAction func rightEyeButtonPressed(_ sender: AnyObject) {
        // Show Fusuma
        let fusuma = FusumaViewController()
        fusumaCropImage = false
//        fusuma.hasVideo = false
        fusuma.delegate = self
        self.present(fusuma, animated: true, completion: nil)

        
        whichEye = "right"
    }
    
    func fusumaDismissedWithImage(_ image: UIImage) {
        print("Called just after dismissed FusumaViewController")
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
        print("Called just after a video has been selected.")
    }
    
    func fusumaCameraRollUnauthorized() {
        
        print("Camera roll unauthorized")
        
        let alert = UIAlertController(title: "Access Requested", message: "Saving image needs to access your photo album", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { (action) -> Void in
            
            if let url = URL(string:UIApplicationOpenSettingsURLString) {
//                UIApplication.shared.openURL(url)
                UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                    print("success")
                })
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func fusumaClosed() {
        
        print("Called when the close button is pressed")
        

    }
    func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode) {
    }
    
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        
    }


}
