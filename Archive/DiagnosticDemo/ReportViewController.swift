//
//  ReportViewController.swift
//  DiagnosticDemo
//
//  Created by pradnya on 23/03/17.
//  Copyright © 2017 pradnya. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController,UITableViewDataSource, UITableViewDelegate  {

    var iconArr = ["gps","volume","proximity","wifi"]
    var lblArr = ["Gps Test", "Volume Button Test", "Proximity Test", "Wifi Test"]
    var reportArr = ["accept","accept","reject","accept"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Reports"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
