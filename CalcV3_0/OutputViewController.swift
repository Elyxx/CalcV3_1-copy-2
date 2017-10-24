//
//  OutputViewController.swift
//  CalcV3_0
//
//  Created by adminaccount on 10/6/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import UIKit

class OutputViewController: UIViewController{
    
    var mid_result:String = ""
    
    @IBOutlet private weak var TypedStr: UILabel!
   
    @IBOutlet private weak var memory: RoundedLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //TypedStr.adjustsFontForContentSizeCategory = true
    }
    func checkMemory(_ result: String){
        memory.text = result
    }
    func display(_ result: String){
        let width = TypedStr.intrinsicContentSize.width
        if width > 338 {
            print("limit has been reached")
        }
     
          TypedStr.text = result
    }
    
    
    // MARK: - Navigation

    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        }*/
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    //}
    

}
