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
    @IBOutlet var statusLbl:UILabel!
    var iconArr = ["gps","proximity","volume","wifi"]
    var lblArr = ["GPS Working","Proximity Working","Volume Button Working", "WiFi Working"]
    var reportArr = ["accept","accept","reject","accept"]
    var reportArr1 = [gpstestResult,proximityTestresult,volumeTest,wifiTestresult]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Quality Check Complete"
        self.navigationItem.setHidesBackButton(true, animated:true);

        let btnView = UIView(frame: CGRect(x: 0, y: screenHeight-60, width: screenWidth, height: 60))
        //btnView.backgroundColor = UIColor.blue
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 60))
        btn.backgroundColor = UIColor.red
        btn.setTitle("Test Again", for: .normal)
        btn.addTarget(self, action: #selector(testAgain), for: .touchUpInside)
        btnView.addSubview(btn)
        
        self.view.addSubview(btnView)
        self.view.bringSubview(toFront: btnView)
        if(gpstestResult == "1" && proximityTestresult == "1" && volumeTest == "1" && wifiTestresult == "1"){
            self.statusLbl.text = "All test are Pass."
        }else{
            self.statusLbl.text = "Diagnose completed. Some of the test failed."
        }
    }
    @IBAction func testAgain(){
        self.navigationController!.popToRootViewController(animated: false)
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
        if ((reportArr1[indexPath.row]) == "1")
        {
            cell.reportImg.image = UIImage(named: "accept")
        }
         if ((reportArr1[indexPath.row]) == "0")
        {
            cell.reportImg.image = UIImage(named: "reject")
        }

       // cell.reportImg.image = UIImage(named: reportArr[indexPath.row])
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
