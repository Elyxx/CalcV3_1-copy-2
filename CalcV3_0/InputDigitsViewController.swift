//
//  InputDigitsViewController.swift
//  CalcV3_0
//
//  Created by adminaccount on 10/6/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import UIKit
import AVFoundation
class InputDigitsViewController: UIViewController{
    
    weak var delegate: DigitsDelegate?
    var bracketsCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var operationMinus: RoundedButton!
    
    private func makesound(){
        AudioServicesPlaySystemSound(1105)
    }
    
    @IBAction func butPressed(_ sender: RoundedButton!) {
        makesound()
        sender.fade()
        delegate?.refreshLabel(sender.currentTitle!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? InputDigitsViewController{
            destination.delegate = delegate
        }
          
    }
    @IBOutlet weak var digit7: RoundedButton!
    
    @IBOutlet weak var leftBracket: RoundedButton!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
