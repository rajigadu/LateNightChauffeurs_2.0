//
//  DatePickerHelper.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 19/09/22.
//

import Foundation
import UIKit

protocol SKUIDatePickerDelegate:AnyObject {
    func getDate(_ sKUIDatePicker:SKUIDatePicker, date:String, SelectedDate: Date)
    func cancel(_ sKUIDatePicker:SKUIDatePicker)
}

protocol SKUITimePickerDelegate:AnyObject {
    func getTime(_ sKUIDatePicker:SKUITimePicker, time:String)
    func cancel(_ sKUIDatePicker:SKUITimePicker)
}

class SKUIDatePicker:UIView {
    
    private let datePicker = UIDatePicker()
    private var dateFormate = "dd-MM-yyyy"
    weak var delegate:SKUIDatePickerDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = UIScreen.main.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showDatePicker(txtDatePicker:UITextField){
        //Formate Date
        datePicker.minimumDate = Date()
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action:       #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem:       UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action:       #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated:false)
        
        txtDatePicker.inputAccessoryView = toolbar
        txtDatePicker.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormate
        let result = formatter.string(from: datePicker.date)
        self.delegate?.getDate(self, date: result, SelectedDate: datePicker.date)
        
    }
    
    @objc func cancelDatePicker(){
        self.delegate?.cancel(self)
    }
}


class SKUITimePicker:UIView {
    private let timePicker = UIDatePicker()
    private var timeFormate = "hh:mm a"
    weak var delegate:SKUITimePickerDelegate?
    
    private var dateFormate = "dd-MM-yyyy"
   // var selectedDate: Date?
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
       // self.selectedDate = selectedDate
        // self.frame = UIScreen.main.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func showTimePicker(txtTimePicker:UITextField,selectedDate : Date){
       // self.selectedDate = selectedDate
        
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormate
        guard let changedSelectedDate = formatter.string(from: selectedDate) as? String else{return}
        guard let changedTodayDate = formatter.string(from: Date()) as? String  else{return}
        
        formatter.dateFormat =  "HH:mm"

        let min = formatter.date(from: "00:00")      //createing min time

        
        if changedSelectedDate != changedTodayDate {
            timePicker.minimumDate = min
        } else {
            timePicker.minimumDate = Date()
        }
        timePicker.datePickerMode = .time
        if #available(iOS 13.4, *) {
            timePicker.preferredDatePickerStyle = .wheels
        }
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action:       #selector(doneTimePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem:       UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action:       #selector(cancelTimePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated:false)
        
        txtTimePicker.inputAccessoryView = toolbar
        txtTimePicker.inputView = timePicker
        
    }
    
    @objc func doneTimePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = timeFormate
        let result = formatter.string(from: timePicker.date)
        self.delegate?.getTime(self, time: result)
    }
    
    @objc func cancelTimePicker(){
        self.delegate?.cancel(self)
    }
}

extension Date {
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
