//
//  ViewController.swift
//  UIView Animations
//
//  Created by Brian Sakhuja on 3/20/19.
//  Copyright © 2019 Brian Sakhuja. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var labels = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 200
        
        
        initLabels()
        
        // Animation chaining
        //        UIView.animate(withDuration: 1, delay: 0, animations: {
        //            self.myView.transform = .identity
        //        }, completion: { [weak myView] completed in
        //            guard completed, let myView = myView else { return }
        //
        //            myView.transform = CGAffineTransform(scaleX: 2, y: 2)
        //
        //            UIView.animate(withDuration: 1, delay: 0, animations: {
        //                self.myView.transform = .identity
        //            }, completion: nil)
        //        })
        
        
    }
    
    func initLabels() {
        labels.append("Simple animation")
        labels.append(".curveLinear option")
        labels.append(".curveEaseInOut option")
        labels.append(".autoreverse option")
        labels.append("usingSpringWithDampening parameter")


    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimationCell") as! AnimationTableViewCell
        if indexPath.row == 0 {
            cell.myView.transform = CGAffineTransform(scaleX: 0, y: 0)
            
            UIView.animate(withDuration: 1, delay: 0, options: .repeat, animations: {
                cell.myView.transform = .identity
            }, completion: nil)
            
        }
        
        if indexPath.row == 1 {
            cell.myView.transform = CGAffineTransform(scaleX: 0, y: 0)
            
            UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .curveLinear], animations: {
                cell.myView.transform = .identity
            }, completion: nil)
            
        }
        
        if indexPath.row == 2 {
            cell.myView.transform = CGAffineTransform(scaleX: 0, y: 0)
            
            UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .curveEaseInOut], animations: {
                cell.myView.transform = .identity
            }, completion: nil)
            
        }
        
        if indexPath.row == 3 {
            cell.myView.transform = CGAffineTransform(scaleX: 0, y: 0)
            
            UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse], animations: {
                cell.myView.transform = .identity
            }, completion: nil)
            
        }
        
        if indexPath.row == 3 {
            cell.myView.transform = CGAffineTransform(scaleX: 0, y: 0)
            
            UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse], animations: {
                cell.myView.transform = .identity
            }, completion: nil)
            
        }
        
        if indexPath.row == 4 {
            cell.myView.transform = CGAffineTransform(scaleX: 0, y: 0)
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .repeat, animations: {
                cell.myView.transform = .identity
            }, completion: nil)
            
        }
        
        cell.myLabel.text = labels[indexPath.row]
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count
    }
    
    
    
    
    
}


