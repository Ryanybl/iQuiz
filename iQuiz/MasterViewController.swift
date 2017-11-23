//
//  MasterViewController.swift
//  iQuiz
//
//  Created by Ryan Liang on 11/7/17.
//  Copyright © 2017 Ryan Liang. All rights reserved.
//

import UIKit
class MasterViewController : UITableViewController, UIPopoverPresentationControllerDelegate{
    
    
    
    struct Quiz: Decodable {
        let title: String
        let desc: String
        let questions: [Questions]
    }
    struct Questions: Decodable {
        let text: String
        let answer: String
        let answers: Array<String>
    }
    var detailViewController: DetailViewController? = nil
    var jsonData : [Quiz] = []
    var subjects : [String] = []
    var subtitles : [String] = []
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl){
        loadData()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControlEvents.valueChanged)
        loadData()
        // Do any additional setup after loading the view, typically from a nib.

        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        //clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = jsonData[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                var quiz : [Dictionary<String,Any>] = []
                for x in object.questions {
                    var element : Dictionary<String,Any> = [:]
                    element["text"] = x.text
                    element["answers"] = x.answers
                    element["answer"] = x.answer
                    quiz.append(element)
                }
                controller.questions = quiz
                controller.totalNumberOfQuestions = object.questions.count
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }else if segue.identifier == "settingsPopover" {
            let popoverViewController = segue.destination
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.popover
            popoverViewController.popoverPresentationController!.delegate = self as UIPopoverPresentationControllerDelegate
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let object = subjects[indexPath.row]
        let subtitle = subtitles[indexPath.row]
        cell.imageView?.image = UIImage(named: subjects[indexPath.row] )
        cell.textLabel!.text = object
        cell.detailTextLabel?.text = subtitle
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            subjects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    


    
    func loadData(){
        jsonData = []
        subjects = []
        subtitles = []
        let url = URL(string: "http://tednewardsandbox.site44.com/questions.json")
            //fetching the data from the url
            URLSession.shared.dataTask(with: url!) {(data, response, error) in
                let httpResponse = response as? HTTPURLResponse
                if (httpResponse != nil && (httpResponse?.statusCode)! >= 200 && (httpResponse?.statusCode)! < 300) {
                    self.decode(data: data!)
                }
                else {
                    let path = Bundle.main.path(forResource: "quizes", ofType: "json")
                    let localData = try? Data(contentsOf: URL(fileURLWithPath: path!))
                    self.decode(data: localData!)
                }
                DispatchQueue.main.sync {
                    self.tableView.reloadData()
                }
            }.resume()

        
    }
    
    func decode(data: Data){
        if let jsonObj = try? JSONDecoder().decode([Quiz].self, from: data) {
            for n in jsonObj {
                self.subjects.append(n.title)
                self.subtitles.append(n.desc)
                
            }
            self.jsonData = jsonObj
        }
    }
}

