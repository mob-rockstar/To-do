//
//  SortTypePopup.swift
//  ToDoList
//
//  Created by Panda on 10/31/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import UIKit

protocol SortPopupDelegate{
    func onSelectedSortType()
}

class SortTypePopup: UIView {

    
    @IBOutlet weak var sortByNameButton: UIButton!
    @IBOutlet weak var sortByDateButton: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    
    var delegate : SortPopupDelegate?
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        let view : UIView = loadViewFromNib()
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        
        addSubview(view)
        
        // Make the corner rounded view
        self.containerView.layer.cornerRadius = 10
        self.containerView.clipsToBounds = true
        
        self.initView()
    }
    
    func initView(){
        switch AppSession.sharedInstance.sortType {
        case .name:
            self.sortByNameButton.setImage(UIImage(named : "radio_on"), for: .normal)
            self.sortByDateButton.setImage(UIImage(named:"radio_off"), for: .normal)
            break
        case .date:
            self.sortByNameButton.setImage(UIImage(named : "radio_off"), for: .normal)
            self.sortByDateButton.setImage(UIImage(named:"radio_on"), for: .normal)
            break
        default:
            break
        }
    }
    
    func loadViewFromNib() -> UIView{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "SortTypePop", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    
    @IBAction func onSelectedSortByName(_ sender: Any) {
        self.sortByNameButton.setImage(UIImage(named : "radio_on"), for: .normal)
        self.sortByDateButton.setImage(UIImage(named:"radio_off"), for: .normal)
        AppSession.sharedInstance.sortType = .name
    }
    
    @IBAction func onSelectedSortByDate(_ sender: Any) {
        self.sortByNameButton.setImage(UIImage(named : "radio_off"), for: .normal)
        self.sortByDateButton.setImage(UIImage(named:"radio_on"), for: .normal)
        AppSession.sharedInstance.sortType = .date
    }
    
    @IBAction func onSelectedType(_ sender: Any) {
        if delegate != nil {
            delegate?.onSelectedSortType()
        }
    }
    
}
