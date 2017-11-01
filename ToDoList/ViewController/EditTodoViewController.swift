//
//  EditTodoViewController.swift
//  ToDoList
//
//  Created by Panda on 10/31/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import UIKit

protocol EditTodoViewControllerDelegate {
    func onUpdatedTodo(_ updatedItem : TodoCellViewModel, title : String)
}

class EditTodoViewController: UIViewController {

    var selectedViewModel : TodoCellViewModel!
    var delegate : EditTodoViewControllerDelegate?
    
    @IBOutlet weak var titleText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // display the top title
        self.navigationItem.title = "Edit Todo"
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.titleText.delegate = self
        
        self.loadContent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadContent(){
        self.titleText.text = selectedViewModel.todoTitle
    }
    
    @IBAction func onUpdateTodo(_ sender: Any) {
        if (self.titleText.text?.isEmpty)! {
            self.showSimpleAlert(title: "", message: "Title is required", complete: nil)
            return
        }
        
        // update the current Todo
        if delegate != nil {
            delegate?.onUpdatedTodo(self.selectedViewModel, title: self.titleText.text!)
        }
        
        self.navigationController?.popViewController(animated: true)
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

extension EditTodoViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
