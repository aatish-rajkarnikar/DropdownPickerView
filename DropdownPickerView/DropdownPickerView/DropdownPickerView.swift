//
//  DropdownPickerView.swift
//  DropdownPickerView
//
//  Created by Aatish Rajkarnikar on 2/8/17.
//  Copyright © 2017 Aatish Rajkarnikar. All rights reserved.
//

import UIKit
@objc protocol DropdownPickerViewDelegate {
    @objc optional
    func pickerView(didOpen pickerView:DropdownPickerView)
    func pickerView(didClose pickerView:DropdownPickerView)
    func pickerView(pickerView:DropdownPickerView,didSelectAt index:NSInteger,withValue value:String)
}

class DropdownPickerView: UIView {

    private let topView:UIView = UIView()
    private let bottomView:UIView = UIView()
    private let textLabel:UILabel = UILabel()
    private let tableView:UITableView = UITableView()
    
    @IBInspectable var defaultText:String?
    private var contentSize:CGSize = CGSize()
    
    private var isOpen:Bool = false
    private var expandableHeight:CGFloat = 200
    
    var dataSource:[String] = [String](){
        didSet{
            tableView.reloadData()
        }
    }
    var delegate:DropdownPickerViewDelegate?
    var selectedValue:String?{
        didSet{
            textLabel.text = selectedValue
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareViews()
        
        textLabel.text = defaultText
        layer.cornerRadius = 4
        clipsToBounds = true
        
        topView.addShadow()
        
        topView.backgroundColor = UIColor.white
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    override var intrinsicContentSize: CGSize{
        return contentSize
    }
    
    private func prepareViews(){
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        topView.addSubview(textLabel)
        bottomView.addSubview(tableView)
        addSubview(bottomView)
        addSubview(topView)
        
        
        let views = ["TopView" : topView, "BottomView" : bottomView, "TextLabel" : textLabel, "TableView" : tableView]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[TextLabel]-8-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[TextLabel]-8-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[TableView]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[TableView]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[TopView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[BottomView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[TopView][BottomView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        topView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(gesture:))))
        contentSize = topView.bounds.size
    }
    
    func tap(gesture:UITapGestureRecognizer){
        if isOpen {
            hidePicker()
        }else{
            showPicker()
        }
    }
    
    func showPicker(){
        contentSize.height = contentSize.height + expandableHeight
        invalidateIntrinsicContentSize()
        isOpen = true
    }
    
    func hidePicker(){
        contentSize.height = contentSize.height - expandableHeight
        invalidateIntrinsicContentSize()
        isOpen = false
    }
    
    func selectItem(at index:NSInteger, animated: Bool){
        
        tableView.selectRow(at:  NSIndexPath(row: index, section: 0) as IndexPath, animated: animated, scrollPosition: .top)
        selectedValue = dataSource[index]
    }
}

extension DropdownPickerView:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0)
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
}

extension DropdownPickerView:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.pickerView(pickerView: self, didSelectAt: indexPath.row, withValue: dataSource[indexPath.row])
        selectedValue = dataSource[indexPath.row]
    }
}

extension UIView{
    func addShadow(){
        layer.cornerRadius = 4
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 2
        layer.shadowOffset = CGSize(width: 0, height: 0)
        clipsToBounds = false
    }
}
