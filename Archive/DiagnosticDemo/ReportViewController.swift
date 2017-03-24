//
//  ReportViewController.swift
//  DiagnosticDemo
//
//  Created by pradnya on 23/03/17.
//  Copyright © 2017 pradnya. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController,UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var reportTbl: UITableView!
    
    var iconArr = ["gps","volume","proximity","wifi"]
    var lblArr = ["GPS Working", "Volume Button Working", "Proximity Working", "WiFi Working"]
    var reportArr = ["accept","accept","reject","accept"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Quality Check Complete"
        
        let btnView = UIView(frame: CGRect(x: 0, y: screenHeight-60, width: screenWidth, height: 60))
        //btnView.backgroundColor = UIColor.blue
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 60))
        btn.backgroundColor = UIColor.red
        btn.setTitle("Test Again", for: .normal)
        btnView.addSubview(btn)
        
        self.view.addSubview(btnView)
        self.view.bringSubview(toFront: btnView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let status = "Some features were not tested."
//        return status
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 40.0
//    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 20))
//        //btnView.backgroundColor = UIColor.blue
//        let lbl = UILabel(
//        btn.backgroundColor = UIColor.red
//        btn.setTitle("Test Again", for: .normal)
//        btnView.addSubview(btn)
//
//    
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reportCell", for: indexPath) as! ReportTableViewCell
        cell.iconImg.image = UIImage(named: iconArr[indexPath.row])
        cell.reportLbl.text = "\(lblArr[indexPath.row])"
        cell.reportImg.image = UIImage(named: reportArr[indexPath.row])
        return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
