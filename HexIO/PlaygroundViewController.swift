//
//  PlaygroundViewController.swift
//  HexIO
//
//  Created by Nicole Mitchell on 10/14/16.
//  Copyright © 2016 Nicole Mitchell. All rights reserved.
//

import UIKit

class PlaygroundViewController: UIViewController, UIGestureRecognizerDelegate {

    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
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
    
    
    var newlyCreatedHex: UIImageView!
    
    @IBOutlet weak var didPanHex: UIImageView!
    
    @IBAction func didPanHex(_ sender: UIPanGestureRecognizer) {
        print("DID MOVE")
        let translation = sender.translation(in: view)
        var imageView = sender.view as! UIImageView!
        var newlyCreatedHexOriginalCenter: CGPoint!
        newlyCreatedHexOriginalCenter = sender.location(in: view)
        
        if sender.state == .began {
            newlyCreatedHex = UIImageView(image: imageView?.image)
            
            // The didPan: method will be defined in Step 3 below.
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap (sender:)))
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
            let rotationGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didRotate(sender:)))
            rotationGestureRecognizer.require(toFail: panGestureRecognizer)
            rotationGestureRecognizer.delegate = self
            panGestureRecognizer.delegate = self
            tapGestureRecognizer.delegate = self

            //tapGestureRecognizer.numberOfTapsRequired = 2

            
            // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
            newlyCreatedHex.isUserInteractionEnabled = true

            newlyCreatedHex.addGestureRecognizer(tapGestureRecognizer)
            newlyCreatedHex.addGestureRecognizer(panGestureRecognizer)
            newlyCreatedHex.addGestureRecognizer(rotationGestureRecognizer)
            
            newlyCreatedHex.center = (imageView?.center)!
            newlyCreatedHex.center.y += drawerView.frame.origin.y
            newlyCreatedHexOriginalCenter = newlyCreatedHex.center

            newlyCreatedHex.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            newlyCreatedHex.transform = newlyCreatedHex.transform.scaledBy(x: 0.5, y: 0.5)
            
            view.addSubview(newlyCreatedHex)
            
        }
        if sender.state == .changed {
            newlyCreatedHex.center = CGPoint(x: newlyCreatedHexOriginalCenter.x, y: newlyCreatedHexOriginalCenter.y)
        }
        if sender.state == .ended {
            newlyCreatedHex.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            newlyCreatedHex.transform = newlyCreatedHex.transform.scaledBy(x: 0.5, y: 0.5)
            newlyCreatedHex.layer.zPosition = -1

        }
    }
    
    func didTap(sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        let point = location
        let imageView = sender.view as! UIImageView
        imageView.transform = imageView.transform.rotated(by: 1.0472)
        print("Tapped")
    }

    func didPan(sender: UIPanGestureRecognizer) {
        let location = sender.location(in: view)
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            print("Gesture began")
            sender.view?.center = sender.location(in: view)
        } else if sender.state == .changed {
            print("Gesture is changing")
            sender.view?.center = sender.location(in: view)
        } else if sender.state == .ended {
            print("Gesture ended")
        }
    }
    
    func didRotate(sender: UIRotationGestureRecognizer) {
        print("DID ROTATE")
        let rotation = sender.rotation
        let imageView = sender.view as! UIImageView
        imageView.transform = imageView.transform.rotated(by: rotation)
        sender.rotation = 0
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
