//
//  TodoListViewController.swift
//  ToDoList
//
//  Created by Panda on 10/31/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel : TodosTableViewViewModel = TodosTableViewViewModel()
    var selectedData : TodoCellViewModel?
    
    let TAG_SORT_POPUP = 1001
    var sortPopup : SortTypePopup!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
      
        viewModel.getTodos(searchBar.text!) {
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    // gotoAddTodoVC
    // gotoEditTodoVC
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "gotoAddTodoVC",
            let destinationViewController = segue.destination as? AddTodoViewController {
           destinationViewController.delegate = self
        }
        
        if segue.identifier == "gotoEditTodoVC",
            let destinationViewController = segue.destination as? EditTodoViewController {
            destinationViewController.delegate = self
            destinationViewController.selectedViewModel = self.selectedData!
        }
    }
    
    
    // Show the result depending on search keyword
    func showSearchResult(_ searchKey : String){
        viewModel.getTodos(searchKey) {
            self.tableView.reloadData()
        }
    }
    
    // Called when clicked the "sort" button
    @IBAction func onSortTodos(_ sender: Any) {
        self.showPopup()
    }
    
    // Show the sort popup
    func showPopup(){
        sortPopup = SortTypePopup(frame: CGRect(x: 0, y: 0, width: (self.navigationController?.view.frame.width)!, height: (self.navigationController?.view.frame.height)!))
        sortPopup.delegate = self
        sortPopup.tag = TAG_SORT_POPUP
        
        self.navigationController?.view.addSubview(sortPopup)
    }
    
    // Dismiss the sort popup
    func dismissSortPopup(){
        if let dialogView = self.navigationController?.view.viewWithTag(TAG_SORT_POPUP) {
            dialogView.removeFromSuperview()
        }
    }
    

}

extension TodoListViewController : SortPopupDelegate {
    func onSelectedSortType() {
        // Dismiss the sort popup
        self.dismissSortPopup()
        
        viewModel.sortTodos {
            self.tableView.reloadData()
        }
    }
}

extension TodoListViewController : UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    // MARK : - UITableViewDelegate & DataSource
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        self.selectedData = viewModel.todoArray[indexPath.row]
        self.performSegue(withIdentifier: "gotoEditTodoVC", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.todoArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TodoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell", for: indexPath) as! TodoTableViewCell
        cell.todoCellViewModel = viewModel.todoArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteTodo(indexPath.row, completion: {
                self.tableView.reloadData()
            })
        }
    }
    
    // MARK: - UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.showSearchResult(searchBar.text!)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
}

extension TodoListViewController : AddTodoViewControllerDelegate {
    func onCreatedTodo(_ title: String) {
        viewModel.addNewTodo(title) {
            self.tableView.reloadData()
        }
    }
}

extension TodoListViewController : EditTodoViewControllerDelegate{
    func onUpdatedTodo(_ updatedItem: TodoCellViewModel, title : String) {
        viewModel.updateTodo(updatedItem, updatedTitle: title)
    }
}
