//
//  ResultsViewController.swift
//  iQuiz
//
//  Created by Ryan Liang on 11/14/17.
//  Copyright © 2017 Ryan Liang. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    var totalNumberOfQuestions : Int = 0
    var numberOfCorrectAnswers : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let label1 = self.view.viewWithTag(1) as? UILabel
        let label2 = self.view.viewWithTag(2) as? UILabel
        let score = Double(numberOfCorrectAnswers) / Double(totalNumberOfQuestions)
        if (score == 1){
            label1?.text = "Perfect!"
        }else if score > 0.9 {
            label1?.text = "Almost!"
        }else if score > 0.8 {
            label1?.text = "Good Job!"
        }else {
            label1?.text = "Try Again!"
        }
        label2?.text = "You got \(numberOfCorrectAnswers) / \(totalNumberOfQuestions) questions correct!"
        // Do any additional setup after loading the view.
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
