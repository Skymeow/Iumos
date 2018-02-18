//
//  ResultsViewController.swift
//  lumos ios
//
//  Created by Shalin Shah on 6/27/17.
//  Copyright © 2017 Shalin Shah. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    let sections = ["Left Eye", "Right Eye", "Symmetry"]
    let section_icons: [UIImage] = [#imageLiteral(resourceName: "eye_icon"), #imageLiteral(resourceName: "eye_icon"), #imageLiteral(resourceName: "symmetry_icon")]
    let descriptions = [["Cup to Disk Ratio","Cup Size","Disk Size","Inferior Thickness", "Superior Thickness", "Nasal Thickness", "Temporal Thickness", "Pallor Stage"], ["Cup to Disk Ratio","Cup Size","Disk Size","Inferior Thickness", "Superior Thickness", "Nasal Thickness", "Temporal Thickness", "Pallor Stage"], ["CDR Difference", "CDR Symmetry", "Pallor Symmetry"]]
    let stats = [[".63","234","374","43", "32", "47", "43", "2"], [".47","353","534","64", "26", "45", "12", "1"], [".12", "YES", "YES"]]
    let dates  = ["June 23, 2017", "May 13, 2017", "Sep 29, 2016", "Jan 10, 2015"]

    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var riskLabel: UILabel!
    @IBOutlet weak var whatTheRiskIs: UILabel!

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Text style for "RISK" Label
        riskLabel.clipsToBounds = true
        riskLabel.alpha = 1
        riskLabel.text = "RISK".uppercased()
        riskLabel.font = UIFont(name: "AvenirNext-Regular", size: 12)
        riskLabel.textColor = UIColor(red: 0.64, green: 0.64, blue: 0.64, alpha: 1)
        
        // Text style for "RISK: HIGH"
        whatTheRiskIs.clipsToBounds = true
        whatTheRiskIs.alpha = 1
        whatTheRiskIs.text = "RISK: HIGH".uppercased()
        whatTheRiskIs.font = UIFont(name: "AvenirNext-Regular", size: 30)
        whatTheRiskIs.textColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1)
        whatTheRiskIs.backgroundColor = UIColor(red: 162/255, green: 0/255, blue: 33/255, alpha: 1)
        
        self.navigationController?.navigationBar.topItem?.title = " "
        navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "AvenirNext-DemiBold", size: 15)!, NSAttributedStringKey.foregroundColor : UIColor.white]
        self.navigationItem.title = "RESULTS".uppercased()
        
//        // Text style for "RESULTS"
//        let style = UILabel(frame: CGRect(x: 476, y: 91, width: 210, height: 38))
//        style.clipsToBounds = true
//        style.alpha = 1
//        style.text = "RESULTS".uppercased()
//        style.font = UIFont(name: "AvenirNext-DemiBold", size: 50)
//        style.textColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1)
//        style.alignment = .left
//        // Text style for "RESULTS"
//        let textStyle1 = UILabel(frame: CGRect(x: 476, y: 91, width: 210, height: 38))
//        style.alignment = .left

    }
    
    
    
    
//    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return sections[section]
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.white
        
        let image = UIImageView(image: section_icons[section])
        if (section == 2) {
            image.frame = CGRect(x: 10, y: 5, width: 50, height: 30)
        } else {
            image.frame = CGRect(x: 15, y: 10, width: 38, height: 20)
        }
        view.addSubview(image)
        
        let label = UILabel()
        label.text = sections[section].uppercased()
        label.frame = CGRect(x: 75, y: 5, width: 100, height: 30)
        
        // Text style for "SYMMETRY"
        label.clipsToBounds = true
        label.alpha = 1
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        label.textColor = UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1)
        
        
        view.addSubview(label)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return descriptions[section].count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell") as! ResultsTableViewCell
        
        cell.selectionStyle = .none

        
        // count each cell number in a uitableview with sections
        var cellNumber = indexPath.row;
        if (indexPath.section > 0 && indexPath.section < 2) {
            for i in 0 ... indexPath.section {
                cellNumber += tableView.numberOfRows(inSection:i)
            }
                cellNumber -= 8
        } else if (indexPath.section > 1) {
            for i in 0 ... indexPath.section {
                cellNumber += tableView.numberOfRows(inSection:i)
            }
            cellNumber -= 3
        }

        // set cell background color to a gradient
        cell.backgroundColor = findBackgroundColor(row: cellNumber)
        


        
        
        // the following commented code increases cell border on all sides of the cell
        // cell.layer.borderWidth = 15.0
        // cell.layer.borderColor = UIColor.white.cgColor
        
        // the following code increases cell border only on specified borders
        let bottom_border = CALayer()
        let bottom_padding = CGFloat(10.0)
        bottom_border.borderColor = UIColor.white.cgColor
        bottom_border.frame = CGRect(x: 0, y: cell.frame.size.height - bottom_padding, width:  cell.frame.size.width, height: cell.frame.size.height)
        bottom_border.borderWidth = bottom_padding
        
        let right_border = CALayer()
        let right_padding = CGFloat(15.0)
        right_border.borderColor = UIColor.white.cgColor
        right_border.frame = CGRect(x: cell.frame.size.width - right_padding, y: 0, width: right_padding, height: cell.frame.size.height)
        right_border.borderWidth = right_padding
        
        let left_border = CALayer()
        let left_padding = CGFloat(15.0)
        left_border.borderColor = UIColor.white.cgColor
        left_border.frame = CGRect(x: 0, y: 0, width: left_padding, height: cell.frame.size.height)
        left_border.borderWidth = left_padding
        
        //        let top_border = CALayer()
        //        let top_padding = CGFloat(10.0)
        //        top_border.borderColor = UIColor.white.cgColor
        //        top_border.frame = CGRect(x: 0, y: 0, width: cell.frame.size.width, height: top_padding)
        //        top_border.borderWidth = top_padding
        
        
        cell.layer.addSublayer(bottom_border)
        cell.layer.addSublayer(right_border)
        cell.layer.addSublayer(left_border)
        //        cell.layer.addSublayer(top_border)
        
        
        cell.layer.masksToBounds = true
        
        
        cell.resultDescription.text = descriptions[indexPath.section][indexPath.row]
        cell.noImageStatLabel.text = stats[indexPath.section][indexPath.row]
        
        // This is just a test to see if the cell count is working and accurate
        // cell.noImageStatLabel.text = (String(cellNumber))

        
        return cell
    }
    

    func findBackgroundColor(row: Int) -> UIColor {
        let startcomponents = UIColor(red:1.00, green:0.00, blue:0.29, alpha:1.0).cgColor.components
        let endcomponents = UIColor(red:0.33, green:0.06, blue:0.20, alpha:1.0).cgColor.components
        let numberOfRows = 19
        
        let r = ((startcomponents?[0])! - (endcomponents?[0])!)
        let g = ((startcomponents?[1])! - (endcomponents?[1])!)
        let b = ((startcomponents?[2])! - (endcomponents?[2])!)
        let a = ((startcomponents?[3])! - (endcomponents?[3])!)
        
        let perchange = CGFloat(row)/CGFloat(numberOfRows-1)
        let rdelta = (perchange * r)
        let gdelta = (perchange * g)
        let bdelta = (perchange * b)
        let adelta = (perchange * a)
        
        
        let newColor: UIColor = UIColor(red: fabs(startcomponents![0] - rdelta), green: fabs(startcomponents![1] - gdelta), blue: fabs(startcomponents![2] - bdelta), alpha: fabs(startcomponents![3] - adelta))
        
        
        return newColor
    }

}
