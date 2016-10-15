//
//  PlaygroundViewController.swift
//  HexIO
//
//  Created by Nicole Mitchell on 10/14/16.
//  Copyright © 2016 Nicole Mitchell. All rights reserved.
//

import UIKit

class PlaygroundViewController: UIViewController {

    @IBOutlet weak var drawerView: UIView!
    var drawerOriginalCenter: CGPoint!
    var drawerDownOffset: CGFloat!
    var drawerUp: CGPoint!
    var drawerDown: CGPoint!
    
    @IBAction func didPanDrawer(_ sender: AnyObject) {
        print("DID PAN")
        let translation = sender.translation(in: view)
        let location = sender.location(in: drawerView)
        let velocity = sender.velocity(in: drawerView)
        
        if sender.state == .began {
            drawerOriginalCenter = drawerView.center
        }
        if sender.state == .changed {
            drawerView.center = CGPoint(x: drawerOriginalCenter.x, y: drawerOriginalCenter.y + translation.y)
        }
        if sender.state == .ended {
            if velocity.y > 0 {
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.drawerView.center = self.drawerDown
                    }, completion: nil)
            }
            if velocity.y < 0 {
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.drawerView.center = self.drawerUp
                    }, completion: nil)
            }
        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        drawerDownOffset = 170
        drawerUp = drawerView.center
        drawerDown = CGPoint(x: drawerView.center.x ,y: drawerView.center.y + drawerDownOffset)
        
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
