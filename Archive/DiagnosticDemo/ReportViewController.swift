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
    var lblArr = ["GPS Working","Proximity Sensor Working","Volume Button Working", "Wi-Fi Working"]
    var reportArr = ["accept","accept","reject","accept"]
    var reportArr1 = [gpstestResult,proximityTestresult,volumeTest,wifiTestresult]
    
    @IBAction func sendReportClicked(_ sender: UIButton) {
        //have Toast
       Toast.sharedInstance.textOnlyToast("Test report send successfully", position: "bottom")
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Smart Check Complete"
        self.navigationItem.setHidesBackButton(true, animated:true);
         self.navigationController?.navigationBar.isHidden = false
        //Button Test Again
//        let btnView = UIView(frame: CGRect(x: 0, y: screenHeight-60, width: screenWidth, height: 60))
//        //btnView.backgroundColor = UIColor.blue
//        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 60))
//        btn.backgroundColor = UIColor.init(red: 0, green: 128/255.0, blue: 255/255, alpha: 1)
//        btn.setTitle("Test Again", for: .normal)
//        btn.titleLabel!.font =  UIFont(name: "MyriadPro-Bold", size: 17)
//        btn.addTarget(self, action: #selector(testAgain), for: .touchUpInside)
//        btnView.addSubview(btn)
        
//        self.view.addSubview(btnView)
//        self.view.bringSubview(toFront: btnView)
        
        if(gpstestResult == "1" && proximityTestresult == "1" && volumeTest == "1" && wifiTestresult == "1"){
            self.statusLbl.text = "All features tested successfully."
        }else{
            self.statusLbl.text = "Some features showed errors upon testing."
        }
    }
    @IBAction func testAgain(){
        self.navigationController!.popToRootViewController(animated: false)
         self.navigationController?.navigationBar.isHidden = true
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
    
    //var lblArr = ["GPS Working","Proximity Sensor Working","Volume Button Working", "Wi-Fi Working"]
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reportCell", for: indexPath) as! ReportTableViewCell
        cell.iconImg.image = UIImage(named: iconArr[indexPath.row])
        cell.reportLbl.text = "\(lblArr[indexPath.row])"
        if ((reportArr1[indexPath.row]) == "1")
        {
            if(indexPath.row == 0){
                cell.reportLbl.text = "GPS Working"
            }
            if(indexPath.row == 1){
                 cell.reportLbl.text = "Proximity Sensor Working"
            }
            if(indexPath.row == 2){
                cell.reportLbl.text = "Volume Button Working"
            }
            if(indexPath.row == 3){
                cell.reportLbl.text = "Wi-Fi Working"
            }
            cell.reportImg.image = UIImage(named: "accept")
        }
         if ((reportArr1[indexPath.row]) == "0")
        {
            if(indexPath.row == 0){
                cell.reportLbl.text = "GPS Test Failed"
            }
            if(indexPath.row == 1){
                cell.reportLbl.text = "Proximity Sensor Test Failed"
            }
            if(indexPath.row == 2){
                cell.reportLbl.text = "Volume Button Test Failed"
            }
            if(indexPath.row == 3){
                cell.reportLbl.text = "Wi-Fi Test Failed"
            }
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
