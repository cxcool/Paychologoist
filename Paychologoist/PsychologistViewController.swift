//
//  ViewController.swift
//  Paychologoist
//
//  Created by 菜 on 15/7/16.
//  Copyright © 2015年 菜. All rights reserved.
//

import UIKit

class PsychologistViewController: UIViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let hvc = segue.destinationViewController as? HappinessViewController {
            if let identifier = segue.identifier {
                switch identifier {
                    case "good": hvc.happiness = 100
                    case "bad": hvc.happiness = 0
                default: hvc.happiness = 50
                }
            }
        }
    }
}

