//
//  TodoTableViewCell.swift
//  ToDoList
//
//  Created by Panda on 10/31/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var todoCellViewModel : TodoCellViewModel? {
        didSet{
            self.setupView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView(){
        // set the title
        self.titleLabel.text = todoCellViewModel?.todoTitle
        
        // set the date
        self.dateLabel.text = todoCellViewModel?.todoDate
    }

}
