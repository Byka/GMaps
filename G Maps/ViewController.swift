//
//  ViewController.swift
//  G Maps
//
//  Created by Srinivasa Reddy on 15/04/18.
//  Copyright © 2018 BYKA. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let featuresArray = ["User current position", "Drag marker", "Route map"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      /*
        let myButton = UIButton()
        
        let width = self.view.frame.size.width/2
        let height = self.view.frame.size.height/2
        myButton.frame = CGRect(x: width-30, y: height-15, width:100, height: 50)
        
        myButton.backgroundColor = UIColor.black
       myButton.setTitle("Click", for: .normal)
        myButton.titleLabel?.textColor = UIColor.white
       
        myButton.titleLabel?.text = "Click"
        myButton.addTarget(self, action: #selector(changeView), for: .touchUpInside)
        
        self.view .addSubview(myButton)
        */
    }


    
    func changeView() {

    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let currentPositionVC = storyBoard.instantiateViewController(withIdentifier: "CurrentPositionViewController") as! CurrentPositionViewController

        self.present(currentPositionVC, animated:true, completion:nil)
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return featuresArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //var cell: UITableViewCell?
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = featuresArray[indexPath.row] as String
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let currentPositionVC = storyBoard.instantiateViewController(withIdentifier: "CurrentPositionViewController") as! CurrentPositionViewController
            
            self.present(currentPositionVC, animated:true, completion:nil)
            
        case 1:
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let ChangePositionVC = storyBoard.instantiateViewController(withIdentifier: "PositionChangeViewController") as! PositionChangeViewController
            
            self.present(ChangePositionVC, animated:true, completion:nil)
        
        case 2:
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let routeVC = storyBoard.instantiateViewController(withIdentifier: "RouteMapViewController") as! RouteMapViewController
            
            self.present(routeVC, animated:true, completion:nil)
        
        default:
            changeView()

        }
        
    }
    
    
    
    
}

