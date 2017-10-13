//
//  ViewController.swift
//  TinderUI
//
//  Created by HideakiTouhara on 2017/10/10.
//  Copyright © 2017年 HideakiTouhara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var basicCard: UIView!
    @IBOutlet weak var likeImageView: UIImageView!
    
    var cardOfCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardOfCenter = basicCard.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBAction
    @IBAction func swipeCard(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        
        let xFromCenter = card.center.x - view.center.x
        
        if xFromCenter > 0 {
            likeImageView.image = #imageLiteral(resourceName: "good")
            likeImageView.tintColor = UIColor.red
            likeImageView.alpha = 1
        } else {
            likeImageView.image = #imageLiteral(resourceName: "bad")
            likeImageView.tintColor = UIColor.blue
            likeImageView.alpha = 1
        }
        
        card.center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        card.transform = CGAffineTransform(rotationAngle: xFromCenter / (view.frame.width) / 2 * -0.785)
        
        if sender.state == UIGestureRecognizerState.ended {
            if card.center.x < 75 {
                UIView.animate(withDuration: 0.2, animations: {
                    card.center = CGPoint(x: card.center.x - 250, y: card.center.y)
                })
                print("hidari")
                return
            } else if card.center.x > self.view.frame.width - 75 {
                UIView.animate(withDuration: 0.2, animations: {
                    card.center = CGPoint(x: card.center.x + 250, y: card.center.y)
                })
                print("migi")
                return
            }
            
            UIView.animate(withDuration: 0.2, animations: {
                card.center = self.cardOfCenter
                card.transform = .identity
                self.likeImageView.alpha = 0
            })
        }
    }
    


}

