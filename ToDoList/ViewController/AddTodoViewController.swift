//
//  AddTodoViewController.swift
//  ToDoList
//
//  Created by Panda on 10/31/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import UIKit

protocol AddTodoViewControllerDelegate {
    func onCreatedTodo(_ title : String)
}

class AddTodoViewController: UIViewController {

    @IBOutlet weak var titleText: UITextField!
    var delegate : AddTodoViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // display the top title
        self.navigationItem.title = "Add Todo"
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.titleText.delegate = self
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
    
    @IBAction func onAddTodo(_ sender: Any) {
        if (self.titleText.text?.isEmpty)! {
            self.showSimpleAlert(title: "", message: "Please enter the title", complete: nil)
            return
        }
        
        // save current Todo item
        self.addTodoItem()
    }
    
    func addTodoItem(){
        if delegate != nil {
            delegate.onCreatedTodo(self.titleText.text!)
            
            // Go to main screen
            self.navigationController?.popViewController(animated: true)
        }
    }

}

extension AddTodoViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
