//
//  startViewController.swift
//  DiagnosticDemo
//
//  Created by Administrator on 3/31/17.
//  Copyright © 2017 pradnya. All rights reserved.
//

import UIKit

class startViewController: UIViewController {

    @IBOutlet weak var startTest: UIButton!
    @IBAction func startTestClicked(_ sender: UIButton) {
        
        let startVC = self.storyboard?.instantiateViewController(withIdentifier: "startTest") as! ViewController
        self.navigationController?.pushViewController(startVC, animated: true)
   

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.startTest.translatesAutoresizingMaskIntoConstraints = true
        //self.startTest.frame = CGRect(x: 114, y: 750, width: 147, height: 30)
       
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5, delay: 0.2, options: UIViewAnimationOptions.curveEaseOut, animations:{
        // self.startTest.frame = CGRect(x: 114, y: 500, width: 147, height: 30)
        }, completion: nil)
         self.navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
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
