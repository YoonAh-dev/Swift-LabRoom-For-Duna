//
//  ViewController.swift
//  Counting-ReSwift
//
//  Created by SHIN YOON AH on 2021/12/02.
//

import UIKit
import ReSwift

class ViewController: UIViewController, StoreSubscriber {
    typealias StoreSubscriberStateType = AppState

    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStore.subscribe(self)
    }
    
    func newState(state: AppState) {
        countLabel.text = "\(mainStore.state.counter)"
    }

    @IBAction func clickedUp(_ sender: Any) {
        mainStore.dispatch(CounterActionIncrease())
    }
    
    @IBAction func clickedDown(_ sender: Any) {
        mainStore.dispatch(CounterActionDecrease())
    }
    
}

