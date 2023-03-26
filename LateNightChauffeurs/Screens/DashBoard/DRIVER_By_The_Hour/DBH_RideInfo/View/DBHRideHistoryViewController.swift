//
//  DBHRideHistoryViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 14/03/23.
//

import UIKit

class DBHRideHistoryViewController: UIViewController {
    
    @IBOutlet weak var view_HistoryRef:UIView!
    @IBOutlet weak var lbl_HistoryRef:UILabel!
    @IBOutlet weak var view_UpcomingRef:UIView!
    @IBOutlet weak var lbl_UpcomingRef:UILabel!
    @IBOutlet weak var tableview_RideInfoRef:UITableView!
    @IBOutlet weak var lbl_NoListRef:UILabel!
    
    var rideInfoArray:[DBH_RideHistoryDataR] = []
    var rideInfoEditButtonStatusArray:[DBH_Future_edit_ride_status] = []
    var selectedRideInfoDict:DBH_RideHistoryDataR?
    var PaymentInfoArray:[PaymentHistoryDatar] = []
    var str_DriverRating = ""
    var isRideInfoEnabled = true
    var str_SelectedRideID = ""
    var str_BookingId = ""
    
    lazy var viewModel = {
        DBH_RideInfoViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.swipeRight()
        
        self.tableview_RideInfoRef.estimatedRowHeight = 1000
        self.tableview_RideInfoRef.rowHeight = UITableView.automaticDimension
        self.title = "Driver By The Hour"
        //        if ([_str_CmgType  isEqual: @"RideHistory"]){
        //            str_SelectedType = @"Ride History";
        //        }
        self.view_HistoryRef.backgroundColor = .white
        self.lbl_HistoryRef.backgroundColor = .white
        self.view_UpcomingRef.backgroundColor = .red
        self.lbl_UpcomingRef.backgroundColor = .red
        self.lbl_NoListRef.isHidden = true
        //        self.tableview_RideInfoRef.isHidden = true
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isRideInfoEnabled {
            self.userRideListAPI()
        } else {
            self.currentRideWithFutureAcceptedListAPI()
        }
    }
    
    @IBAction func MenuBtn(_ sender: Any) {
        self.navigateToSideMenu()
    }
    
    @IBAction func btn_UpcomingRef(_ sender: Any){
        
        isRideInfoEnabled = true
        self.view_UpcomingRef.backgroundColor = .red
        self.lbl_UpcomingRef.backgroundColor = .red
        self.view_HistoryRef.backgroundColor = .white
        self.lbl_HistoryRef.backgroundColor = .white
        //User Ride History API Calling...............
        self.rideInfoArray = []
        self.rideInfoEditButtonStatusArray = []
        self.PaymentInfoArray = []
        self.tableview_RideInfoRef.reloadData()
        self.userRideListAPI()
    }
    
    @IBAction func btn_HistoryActionRef(_ sender: Any){
        
        isRideInfoEnabled = false
        self.view_HistoryRef.backgroundColor = .red
        self.lbl_HistoryRef.backgroundColor = .red
        self.view_UpcomingRef.backgroundColor = .white
        self.lbl_UpcomingRef.backgroundColor = .white
        
        //User current Ride details API Calling...............
        self.rideInfoArray = []
        self.rideInfoEditButtonStatusArray = []
        self.PaymentInfoArray = []
        self.tableview_RideInfoRef.reloadData()
        self.currentRideWithFutureAcceptedListAPI()
    }
}
extension DBHRideHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if isRideInfoEnabled {
            return numberOfSections_nodata(in: tableView, ArrayCount: rideInfoArray.count, numberOfsections: 1, data_MSG_Str: "No Ride Request!")
        } else {
            return numberOfSections_nodata(in: tableView, ArrayCount: PaymentInfoArray.count, numberOfsections: 1, data_MSG_Str: "No Records Found!")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isRideInfoEnabled {
            return rideInfoArray.count
        } else {
            return PaymentInfoArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isRideInfoEnabled {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DBHRideHistoryTableViewCell2", for: indexPath) as? DBH_RideHistoryTableViewCell else { return UITableViewCell() }
            
            if let bookingType = rideInfoArray[indexPath.row].booking_type {
                //Check Ride is Driver By The Hour Ride Based on Booking Type
                if bookingType == "3" {
                    //otherdate
                    if let str_FutureRidedate = rideInfoArray[indexPath.row].otherdate,let str_FutureRideTime = rideInfoArray[indexPath.row].time {
                        let AttributeStr = "Ride Date : " + str_FutureRidedate + " " + str_FutureRideTime
                        let attrStri = NSMutableAttributedString.init(string:AttributeStr)
                        let nsRange = NSString(string: AttributeStr).range(of: "Ride Date :", options: String.CompareOptions.caseInsensitive)
                        attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: CGFloat(35.0/255.0), green: CGFloat(159.0/255.0), blue: CGFloat(98.0/255.0), alpha: CGFloat(1.0)), NSAttributedString.Key.font: UIFont.init(name: "Arial", size: 15.0) as Any], range: nsRange)
                        cell.lbl_DateRef.attributedText = attrStri
                    }
                    
                    //PickUP Location
                    if let JourneyStartFrom = rideInfoArray[indexPath.row].pickup_address
//                        ,let JourneyStartTo = rideInfoArray[indexPath.row].drop_address
                    {
                        let AttributeStr = "Pick Up Location : " + JourneyStartFrom + "\n"
                        //+ "Drop Location : " + JourneyStartTo
                        let attrStri = NSMutableAttributedString.init(string:AttributeStr)
                        var nsRange = NSString(string: AttributeStr).range(of: "Pick Up Location :", options: String.CompareOptions.caseInsensitive)
                        attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.green], range: nsRange)
                       // nsRange = NSString(string: AttributeStr).range(of: "Drop Location :", options: String.CompareOptions.caseInsensitive)
                       // attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.green], range: nsRange)
                        
                        cell.lbl_RideInfoRef.attributedText = attrStri
                    }
                    
                    // Ride booking status
                    if let FutureBookingRideStatus = rideInfoArray[indexPath.row].future_accept {
                        if FutureBookingRideStatus == "1" {
                            if let str_FutureRideStart = rideInfoArray[indexPath.row].ride_assign_status {
                                if str_FutureRideStart == "1" {
                                    let AttributeStr = "Ride Status : Accepted / Ride Started"
                                    let attrStri = NSMutableAttributedString.init(string:AttributeStr)
                                    let nsRange = NSString(string: AttributeStr).range(of: "Accepted", options: String.CompareOptions.caseInsensitive)
                                    attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.green], range: nsRange)
                                    
                                    cell.lbl_RideStatusRef.attributedText = attrStri
                                    cell.btn_ViewDetailRef.isHidden = false
                                } else {
                                    let AttributeStr = "Ride Status : Accepted"
                                    let attrStri = NSMutableAttributedString.init(string:AttributeStr)
                                    let nsRange = NSString(string: AttributeStr).range(of: "Accepted", options: String.CompareOptions.caseInsensitive)
                                    attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.green], range: nsRange)
                                    
                                    cell.lbl_RideStatusRef.attributedText = attrStri
                                    cell.btn_ViewDetailRef.isHidden = false
                                }
                                cell.btn_ViewDetailRef.setTitle("View Detail", for: .normal)
                                cell.btn_ViewDetailRef.layer.cornerRadius = 5.0
                                cell.btn_ViewDetailRef.layer.masksToBounds = true
                                cell.btn_ViewDetailRef.tag = indexPath.row
                            }
                        } else {
                            let AttributeStr = "Ride Status : Pending"
                            let attrStri = NSMutableAttributedString.init(string:AttributeStr)
                            let nsRange = NSString(string: AttributeStr).range(of: "Pending", options: String.CompareOptions.caseInsensitive)
                            attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.red], range: nsRange)
                            
                            cell.lbl_RideStatusRef.attributedText = attrStri
                            cell.btn_ViewDetailRef.isHidden = false
                            cell.btn_ViewDetailRef.layer.cornerRadius = 5.0
                            cell.btn_ViewDetailRef.layer.masksToBounds = true
                            cell.btn_ViewDetailRef.tag = indexPath.row
                            cell.btn_ViewDetailRef.setTitle("Edit Ride Info", for: .normal)
                        }
                        
                        if self.rideInfoEditButtonStatusArray.count == rideInfoArray.count {
                            if let EditButtonStatus = self.rideInfoEditButtonStatusArray[indexPath.row].future_edit_ride_status,let EditButtonStatusId = self.rideInfoEditButtonStatusArray[indexPath.row].id {
                                
                                if EditButtonStatusId == rideInfoArray[indexPath.row].id {
                                    if EditButtonStatus == "1" {
                                        cell.btn_ViewDetailRef.isHidden = false
                                        cell.btn_ViewDetailRef.layer.cornerRadius = 5.0
                                        cell.btn_ViewDetailRef.layer.masksToBounds = true
                                        cell.btn_ViewDetailRef.tag = indexPath.row
                                        cell.btn_ViewDetailRef.setTitle("Edit Ride Info", for: .normal)
                                        //cell.btn_ViewDetailRef.addTarget(self, action: #selector(editRideDetailsButtonClicked), for: .touchUpInside)
                                    } else {
                                        cell.btn_ViewDetailRef.setTitle("View Detail", for: .normal)
                                        cell.btn_ViewDetailRef.layer.cornerRadius = 5.0
                                        cell.btn_ViewDetailRef.layer.masksToBounds = true
                                        cell.btn_ViewDetailRef.tag = indexPath.row
                                        //cell.btn_ViewDetailRef.addTarget(self, action: #selector(viewDetailButtonClicked), for: .touchUpInside)
                                    }
                                }
                            }
                        }
                        
                        if rideInfoArray[indexPath.row].ride_assign_status == "1" {
                            cell.btn_ViewDetailRef.addTarget(self, action: #selector(viewDetailButtonClicked), for: .touchUpInside)
                        } else {
                            cell.btn_ViewDetailRef.addTarget(self, action: #selector(editRideDetailsButtonClicked), for: .touchUpInside)
                        }
                    }
                    
                    // Distance and Price
//                    if let Distance = rideInfoArray[indexPath.row].distance,let price = rideInfoArray[indexPath.row].estimation_price {
//                        var distanceStr = ""
//                        if let rideDoubleValue = Double(Distance) as? Double {
//                            let rideDistance  = String(format:"%.2f", rideDoubleValue)
//                            distanceStr =  rideDistance
//                        }
//                        let AttributeStr = "Distance : " + "\(distanceStr) Miles" + "\nRide Price : $" + price
//
//                        let attrStri = NSMutableAttributedString.init(string:AttributeStr)
//
//                        var nsRange = NSString(string: AttributeStr).range(of: "Distance :", options: String.CompareOptions.caseInsensitive)
//                        attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.green], range: nsRange)
//
//                        nsRange = NSString(string: AttributeStr).range(of: "Ride Price :", options: String.CompareOptions.caseInsensitive)
//                        attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.green], range: nsRange)
//
//                        cell.lbl_RideDistanceRef.attributedText = attrStri
//                    }
                    if let hourRate  = rideInfoArray[indexPath.row].hourly_rate_while_ride_completed as? String {
                        cell.lbl_RideDistanceRef.text = "Rate: $ \(hourRate)/Hrs"
                    }
                }
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DBH_RideHistoryTableViewCell", for: indexPath) as? DBH_RideHistoryTableViewCell else { return UITableViewCell()}
            // cell.btn_PaymentConstraintRef.constant = 41
            var str_CurrentRideDateTime = String()
            var str_PaymentDateTime = String()
            //Date and time
            let str_CurrentRidepaymentDate = PaymentInfoArray[indexPath.row].payment_date ?? ""
            let PayDateTime = PaymentInfoArray[indexPath.row].payDateTime ?? ""
            let str_CurrentRideDate = PaymentInfoArray[indexPath.row].otherdate ?? ""
            let str_CurrentRideTime = PaymentInfoArray[indexPath.row].time ?? ""
            
            // first date
            if let datestr = formattedDateFromString(dateString: str_CurrentRidepaymentDate, withFormat: "MM-dd-yyyy hh:mm a") {
                str_PaymentDateTime = datestr
            } else {
                str_PaymentDateTime = PayDateTime
            }
            
            var Bookingdate = str_CurrentRideDate + " " + str_CurrentRideTime
            
            var Journeystr = "Booking Date : " +  Bookingdate + "\nPayment Date : " + str_PaymentDateTime
            
            let attrStri = NSMutableAttributedString.init(string:Journeystr)
            
            var nsRange = NSString(string: Journeystr).range(of: "Booking Date :", options: String.CompareOptions.caseInsensitive)
            attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: CGFloat(35.0/255.0), green: CGFloat(159.0/255.0), blue: CGFloat(98.0/255.0), alpha: CGFloat(1.0)), NSAttributedString.Key.font: UIFont.init(name: "Arial", size: 15.0) as Any], range: nsRange)
            
            nsRange = NSString(string: Journeystr).range(of: "Payment Date :", options: String.CompareOptions.caseInsensitive)
            attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: CGFloat(35.0/255.0), green: CGFloat(159.0/255.0), blue: CGFloat(98.0/255.0), alpha: CGFloat(1.0)), NSAttributedString.Key.font: UIFont.init(name: "Arial", size: 15.0) as Any], range: nsRange)
            cell.lbl_JourneyDateRef.attributedText = attrStri
            
            //PickUP Location
            if let JourneyStartFrom = PaymentInfoArray[indexPath.row].pickup_address {
                let AttributeStr = "Pick Up Location : " + JourneyStartFrom
                let attrStri = NSMutableAttributedString.init(string:AttributeStr)
                let nsRange = NSString(string: AttributeStr).range(of: "Pick Up Location :", options: String.CompareOptions.caseInsensitive)
                attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.green], range: nsRange)
                
                cell.lbl_PickUpLocationRef.attributedText = attrStri
            }
            
            //Drop Location
            if let JourneyStartTo = PaymentInfoArray[indexPath.row].drop_address {
                let AttributeStr = "Drop Location : " + JourneyStartTo
                let attrStri = NSMutableAttributedString.init(string:AttributeStr)
                let nsRange = NSString(string: AttributeStr).range(of: "Drop Location :", options: String.CompareOptions.caseInsensitive)
                attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.green], range: nsRange)
                
                cell.lbl_DropLocationRef.attributedText = attrStri
                
            }
            
            //TransactionID, //Ride Waiting Charges...
            var str_RideTransactionID = PaymentInfoArray[indexPath.row].transaction_id ?? ""
            var str_RideWaitingCharges = PaymentInfoArray[indexPath.row].unplaned_waiting_amt ?? "0"
            var str_RideCompleteAmount = PaymentInfoArray[indexPath.row].amount ?? "0"
            var Str_AdminFare = PaymentInfoArray[indexPath.row].extra_charge ?? "0"
            //Ride Amount...
            var str_RideAmount = PaymentInfoArray[indexPath.row].ride_amt ?? str_RideCompleteAmount
            var str_city_charges = PaymentInfoArray[indexPath.row].city_charges ?? ""
            
            //            var result = Float(str_RideAmount ?? "0") ?? 0.0 + Float(Str_AdminFare ?? "0") ?? 0.0 + Float(str_city_charges ?? "0") ?? 0.0)
            var Str_promoCodevalue = PaymentInfoArray[indexPath.row].promo_amt ?? "0"
            
            
            var str_CompleteRideAmountWithTip = String()
            var str_RideTipAmount = PaymentInfoArray[indexPath.row].tip_ammount ?? ""
            if str_RideTipAmount == "" {
                str_RideTipAmount = "0"
                str_CompleteRideAmountWithTip = str_RideCompleteAmount
            } else {
                let tipAmount : Double = Double(str_RideTipAmount ?? "") ?? 0.0
                let totalamount: Double = Double(str_RideCompleteAmount ?? "") ?? 0.0
                let RideAmountWithTips: Double = tipAmount + totalamount
                
                str_CompleteRideAmountWithTip = String(RideAmountWithTips)
            }
            
            //Ride Complete (waiting Charges ) /Cancel By user(withAmount) or driver / Checking....
            var str_RideCompleteORpendingStatus = PaymentInfoArray[indexPath.row].status ?? ""
            if str_RideCompleteORpendingStatus == "2" {
                var distanceinFloat = PaymentInfoArray[indexPath.row].distance ?? ""
                var distanceStr = ""
                if let rideDoubleValue = Double(distanceinFloat) as? Double {
                    let rideDistance  = String(format:"%.2f", rideDoubleValue)
                    distanceStr =  rideDistance
                }
                
                var JourneyDistance = "Distance : " + "\(distanceStr)" + " Miles\nTransaction ID : " + str_RideTransactionID + "\nPromo Code : $" + Str_promoCodevalue + "\nTip Amount : $" + str_RideTipAmount + "\nRide Total Cost : $" + str_CompleteRideAmountWithTip
                
                let attrStri = NSMutableAttributedString.init(string:JourneyDistance)
                
                var nsRange = NSString(string: JourneyDistance).range(of: "Distance :", options: String.CompareOptions.caseInsensitive)
                attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.green], range: nsRange)
                
                nsRange = NSString(string: JourneyDistance).range(of: "Transaction ID :", options: String.CompareOptions.caseInsensitive)
                attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.green], range: nsRange)
                
                nsRange = NSString(string: JourneyDistance).range(of: "Promo Code :", options: String.CompareOptions.caseInsensitive)
                attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.green], range: nsRange)
                
                nsRange = NSString(string: JourneyDistance).range(of: "Tip Amount :", options: String.CompareOptions.caseInsensitive)
                attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.green], range: nsRange)
                
                nsRange = NSString(string: JourneyDistance).range(of: "Ride Total Cost :", options: String.CompareOptions.caseInsensitive)
                attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.green], range: nsRange)
                
                cell.lbl_DistanceRef.attributedText = attrStri
                
            } else if str_RideCompleteORpendingStatus == "4" {
                let distanceinFloat = PaymentInfoArray[indexPath.row].distance ?? ""
                var distanceStr = ""
                if let rideDoubleValue = Double(distanceinFloat) as? Double {
                    let rideDistance  = String(format:"%.2f", rideDoubleValue)
                    distanceStr =  rideDistance + " Miles"
                }
                
                var JourneyDistance = "Distance : " + distanceStr + "\nTransaction ID : " + str_RideTransactionID + "\nRide Cancellation Amount : $" + str_RideAmount
                
                let attrStri = NSMutableAttributedString.init(string:JourneyDistance)
                
                var nsRange = NSString(string: JourneyDistance).range(of: "Distance :", options: String.CompareOptions.caseInsensitive)
                attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.green], range: nsRange)
                
                nsRange = NSString(string: JourneyDistance).range(of: "Transaction ID :", options: String.CompareOptions.caseInsensitive)
                attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.green], range: nsRange)
                
                nsRange = NSString(string: JourneyDistance).range(of: "Ride Cancellation Amount :", options: String.CompareOptions.caseInsensitive)
                attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.green], range: nsRange)
                
                cell.lbl_DistanceRef.attributedText = attrStri
            }
            
            
            // Feed Back Btn ref
            let str_FeedBackTipStatus = PaymentInfoArray[indexPath.row].feedback_status ?? ""
            let str_cancelRideCheckStatus = PaymentInfoArray[indexPath.row].status ?? ""
            
            if str_FeedBackTipStatus == "" || str_FeedBackTipStatus == "0" {
                if str_cancelRideCheckStatus == "4" {
                    cell.GIVeFeedBackHeightRef.constant = 0
                } else {
                    cell.GIVeFeedBackHeightRef.constant = 40
                    cell.GiveFeedBackBtnref.layer.cornerRadius = 5.0
                    cell.GiveFeedBackBtnref.layer.masksToBounds = true
                    cell.GiveFeedBackBtnref.tag = indexPath.row
                    cell.GiveFeedBackBtnref.addTarget(self, action: #selector(feedbackButtonClicked), for: .touchUpInside)
                }
            } else {
                cell.GIVeFeedBackHeightRef.constant = 0
            }
            
            // add tip btn ref
            let str_tipBackTipStatus = PaymentInfoArray[indexPath.row].tip_ammount ?? ""
            if str_tipBackTipStatus == "1" || str_tipBackTipStatus == "" {
                if str_cancelRideCheckStatus == "4" || str_tipBackTipStatus.count >= 1{
                    cell.AddtipAmountHeightbtnref.constant = 0
                } else {
                    cell.AddtipAmountHeightbtnref.constant = 40
                    cell.AddTipAmountBtnref.layer.cornerRadius = 5.0
                    cell.AddTipAmountBtnref.layer.masksToBounds = true
                    cell.AddTipAmountBtnref.tag = indexPath.row
                    cell.AddTipAmountBtnref.addTarget(self, action: #selector(TipButtonClicked), for: .touchUpInside)
                }
            } else {
                cell.AddtipAmountHeightbtnref.constant = 0
            }
            
            cell.btn_PaymentRef.layer.cornerRadius = 5.0
            cell.btn_PaymentRef.layer.masksToBounds = true
            cell.btn_PaymentRef.tag = indexPath.row
            cell.btn_PaymentRef.addTarget(self, action: #selector(paymentSummaryButtonClicked), for: .touchUpInside)
            
            if !isRideInfoEnabled {
                cell.btn_PaymentRef.isHidden = false
            } else {
                cell.btn_PaymentRef.isHidden = true
            }
            
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isRideInfoEnabled {
            let Storyboard : UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
            let nxtVC = Storyboard.instantiateViewController(withIdentifier: "ShowRideLocationViewController") as! ShowRideLocationViewController
            nxtVC.ridePickUPLat = PaymentInfoArray[indexPath.row].pickup_lat ?? ""
            nxtVC.ridePickUPLong = PaymentInfoArray[indexPath.row].pickup_long ?? ""
            nxtVC.rideDropLat = PaymentInfoArray[indexPath.row].d_lat ?? ""
            nxtVC.rideDropLong = PaymentInfoArray[indexPath.row].d_long ?? ""
            nxtVC.rideDistance = PaymentInfoArray[indexPath.row].distance ?? ""
            self.navigationController?.pushViewController(nxtVC, animated: true)
            
        } else {
            
            if self.rideInfoEditButtonStatusArray.count == rideInfoArray.count {
                if let EditButtonStatus = self.rideInfoEditButtonStatusArray[indexPath.row].future_edit_ride_status,let EditButtonStatusId = self.rideInfoEditButtonStatusArray[indexPath.row].id {
                    
                    if EditButtonStatusId == rideInfoArray[indexPath.row].id {
                        if EditButtonStatus != "1" {
                            if let str_BookingType = rideInfoArray[indexPath.row].ride_assign_status, str_BookingType != "1" {
                                
                                if let str_BookingType = rideInfoArray[indexPath.row].booking_type, str_BookingType == "3" {
                                    let Storyboard : UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
                                    let nxtVC = Storyboard.instantiateViewController(withIdentifier: "DBHDriverDetailIsBookingViewController") as! DBHDriverDetailIsBookingViewController
                                    nxtVC.str_FutureRideStatus = rideInfoArray[indexPath.row].future_accept ?? ""
                                    nxtVC.str_FutureRideDate = rideInfoArray[indexPath.row].date ?? ""
                                    nxtVC.str_FutureRideTime = rideInfoArray[indexPath.row].time ?? ""
                                    nxtVC.str_FutureRideID = rideInfoArray[indexPath.row].id ?? ""
                                   // self.navigationController?.pushViewController(nxtVC, animated: true)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    @objc func viewDetailButtonClicked(sender: UIButton) {
        
        if let str_BookingType = rideInfoArray[sender.tag].booking_type, str_BookingType == "3" {
            let Storyboard : UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
            let nxtVC = Storyboard.instantiateViewController(withIdentifier: "DBHDriverDetailIsBookingViewController") as! DBHDriverDetailIsBookingViewController
            nxtVC.str_FutureRideStatus = rideInfoArray[sender.tag].future_accept ?? ""
            nxtVC.str_FutureRideDate = rideInfoArray[sender.tag].date ?? ""
            nxtVC.str_FutureRideTime = rideInfoArray[sender.tag].time ?? ""
            nxtVC.str_FutureRideID = rideInfoArray[sender.tag].id ?? ""
            self.navigationController?.pushViewController(nxtVC, animated: true)
        } else {
            self.EditRideConformationAPI(RideID:rideInfoArray[sender.tag].id ?? "")
        }
    }
    
    @objc func editRideDetailsButtonClicked(sender: UIButton) {
        if self.rideInfoEditButtonStatusArray.count == rideInfoArray.count {
            if let EditButtonStatus = self.rideInfoEditButtonStatusArray[sender.tag].future_edit_ride_status,let EditButtonStatusId = self.rideInfoEditButtonStatusArray[sender.tag].id {
                
                if EditButtonStatusId == rideInfoArray[sender.tag].id {
                    if EditButtonStatus == "1" {
                        if let str_BookingType = rideInfoArray[sender.tag].ride_assign_status, str_BookingType != "1" {
                            self.selectedRideInfoDict = rideInfoArray[sender.tag]
                            self.EditRideConformationAPI(RideID:rideInfoArray[sender.tag].id ?? "")
                        }
                    }
                }
            }
        }
    }
    
    @objc func feedbackButtonClicked(sender: UIButton) {
        let Storyboard : UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "RiseHistoryFeedBackViewController") as! RiseHistoryFeedBackViewController
        nxtVC.str_ComingFrom = "RideHistory"
        nxtVC.str_RideIDr = PaymentInfoArray[sender.tag].rideid ?? ""
        nxtVC.str_UserIDr = PaymentInfoArray[sender.tag].driver_id_for_future_ride ?? ""
        nxtVC.str_SelectedDriverFirstNameget = PaymentInfoArray[sender.tag].first_name ?? ""
        nxtVC.str_SelectedDriverLastNameget = PaymentInfoArray[sender.tag].last_name ?? ""
        nxtVC.str_SelectedDriverProfilepicget = PaymentInfoArray[sender.tag].profile_pic ?? ""
        nxtVC.isDBHRideStatus = "yes"
        self.navigationController?.pushViewController(nxtVC, animated: true)
        
    }
    
    @objc func TipButtonClicked(sender: UIButton) {
        
        let Storyboard : UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "RideHistoryTipViewController") as! RideHistoryTipViewController
        nxtVC.str_ComingFrom = "RideHistory"
        nxtVC.str_RideIDr = PaymentInfoArray[sender.tag].rideid ?? ""
        nxtVC.str_UserIDr = PaymentInfoArray[sender.tag].driver_id_for_future_ride ?? ""
        nxtVC.str_SelectedDriverFirstNameget = PaymentInfoArray[sender.tag].first_name ?? ""
        nxtVC.str_SelectedDriverLastNameget = PaymentInfoArray[sender.tag].last_name ?? ""
        nxtVC.str_SelectedDriverProfilepicget = PaymentInfoArray[sender.tag].profile_pic ?? ""
        self.navigationController?.pushViewController(nxtVC, animated: true)
        
    }
    
    @objc func paymentSummaryButtonClicked(sender: UIButton) {
        //PaymentSummaryViewController
        self.str_SelectedRideID = PaymentInfoArray[sender.tag].id ?? ""
        self.str_BookingId = PaymentInfoArray[sender.tag].rideid ?? ""
        
        self.paymentSummaryAPI()
    }
    
    
}

extension DBHRideHistoryViewController {
    //MARK: - Api Intigration
    func userRideListAPI(){
        guard let userID = UserDefaults.standard.string(forKey: "UserLoginID") else {return}
        indicator.showActivityIndicator()
        
        self.viewModel.RideInfoApiService(perams: ["userid":userID]) { success, model, error in
            if success, let UserData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if UserData.status == "1" {
                        if let dat = UserData.data?.ride {
                            self.rideInfoArray = dat
                            str_DriverRating = UserData.rating ?? ""
                            if let response = UserData.data?.future_edit_ride_status {
                                self.rideInfoEditButtonStatusArray = response
                            }
                            self.tableview_RideInfoRef.reloadData()
                        }
                     
                    } else{
                        ////                        self.tableview_RideInfoRef.isHidden = true
                        //                        self.lbl_NoListRef.isHidden = false
                        self.lbl_NoListRef.text = "No Ride History"
                    }
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? "Something went wrong.", font: .systemFont(ofSize: 12.0))
                }
            }
            
        }
    }
}
extension DBHRideHistoryViewController {
    //MARK: - Api Intigration
    func currentRideWithFutureAcceptedListAPI(){
        guard let userID = UserDefaults.standard.string(forKey: "UserLoginID") else {return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForPaymentHistoryAPIServices(perams: ["userid":userID]) { success, model, error in
            if success, let UserData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if UserData.status == "1" {
                        if let dat = UserData.data {
                            //                        self.tableview_RideInfoRef.isHidden = false
                            //                        self.lbl_NoListRef.isHidden = true
                            PaymentInfoArray = dat
                            self.tableview_RideInfoRef.reloadData()
                        }
                    } else{
                        //                        self.tableview_RideInfoRef.isHidden = true
                        //                        self.lbl_NoListRef.isHidden = false
                        self.lbl_NoListRef.text = "No Ride History"
                    }
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? "Something went wrong.", font: .systemFont(ofSize: 12.0))
                }
            }
            
        }
    }
}


extension DBHRideHistoryViewController {
    //MARK: - Api Intigration
    func paymentSummaryAPI(){
        guard let userID = UserDefaults.standard.string(forKey: "UserLoginID") else {return}
        indicator.showActivityIndicator()
        
        self.viewModel.DBHPaymentSummaryApiService(perams: ["userid":userID,"ride_id":self.str_BookingId]) { success, model, error in
            if success, let UserData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if UserData.status == "1" {
                        let Storyboard : UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
                        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "PaymentSummaryViewController") as! PaymentSummaryViewController
                        nxtVC.Str_BAsePrice = UserData.base_price ?? ""
                        nxtVC.Str_Totalfare = UserData.total_fare ?? ""
                        if let response = UserData.data?.ride?[0] {
                            nxtVC.PaymentInfoDict = response
                        }
                        self.navigationController?.pushViewController(nxtVC, animated: true)
                    } else {
                        self.showToast(message: UserData.message ?? "No records found.", font: .systemFont(ofSize: 12.0))
                    }
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? "Something went wrong.", font: .systemFont(ofSize: 12.0))
                }
            }
            
        }
    }
}


extension DBHRideHistoryViewController {
    //MARK: - Api Intigration
    func EditRideConformationAPI(RideID:String){
        indicator.showActivityIndicator()
        self.viewModel.EditRideConformationApiService(perams: ["ride_id":RideID]) { success, model, error in
            if success  {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    let Storyboard : UIStoryboard = UIStoryboard(name: "DashBoard", bundle: nil)
                    let nxtVC = Storyboard.instantiateViewController(withIdentifier: "ReservationForDriverByTheHour") as! ReservationForDriverByTheHour
                    nxtVC.dict_SelectedRideDetailsForEdit = selectedRideInfoDict
                    nxtVC.str_ComingFrom = "DBHRideHistory"
                    self.navigationController?.pushViewController(nxtVC, animated: true)
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.ShowAlert(message: error ?? "Not eligible for edit ride information")
                    // self.showToast(message: error ?? "Not eligible for edit ride information", font: .systemFont(ofSize: 12.0))
                }
            }
            
        }
    }
}
