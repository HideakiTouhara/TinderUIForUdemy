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
    
    @IBOutlet weak var person1: UIView!
    @IBOutlet weak var person2: UIView!
    @IBOutlet weak var person3: UIView!
    @IBOutlet weak var person4: UIView!
    
    var people = [UIView]()
    
    var cardOfCenter: CGPoint!
    var selectedCardCount: Int = 0
    
    let name = ["ほのか", "あかね", "みほ", "カルロス"]
    var likedName = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardOfCenter = basicCard.center
        people.append(person1)
        people.append(person2)
        people.append(person3)
        people.append(person4)
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
        
        // カードを動かす
        card.center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        people[selectedCardCount].center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        
        card.transform = CGAffineTransform(rotationAngle: xFromCenter / (view.frame.width) / 2 * -0.785)
        people[selectedCardCount].transform = CGAffineTransform(rotationAngle: xFromCenter / (view.frame.width) / 2 * -0.785)
        
        if sender.state == UIGestureRecognizerState.ended {
            if card.center.x < 75 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.resetCard()
                    self.people[self.selectedCardCount].center = CGPoint(x: self.people[self.selectedCardCount].center.x - 250, y: self.people[self.selectedCardCount].center.y)
                })
                likeImageView.alpha = 0
                selectedCardCount += 1
                print("hidari")
                if selectedCardCount >= people.count {
                    print(likedName)
                }
                return
            } else if card.center.x > self.view.frame.width - 75 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.resetCard()
                    self.people[self.selectedCardCount].center = CGPoint(x: self.people[self.selectedCardCount].center.x + 250, y: self.people[self.selectedCardCount].center.y)
                })
                likedName.append(name[selectedCardCount])
                likeImageView.alpha = 0
                selectedCardCount += 1
                if selectedCardCount >= people.count {
                    print(likedName)
                }
                print("migi")
                return
            }
            
            UIView.animate(withDuration: 0.2, animations: {
                self.resetCard()
                self.likeImageView.alpha = 0
                self.people[self.selectedCardCount].center = self.cardOfCenter
                self.people[self.selectedCardCount].transform = .identity
            })
        }
    }
    
    // MARK: - アプリケーションロジック
    func resetCard() {
        basicCard.center = self.cardOfCenter
        basicCard.transform = .identity
    }
    


}

