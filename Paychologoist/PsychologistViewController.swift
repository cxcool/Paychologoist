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
        
        var destination = segue.destinationViewController as? UIViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController
        }
        if let hvc = destination as? HappinessViewController {
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

