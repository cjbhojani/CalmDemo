//
//  ViewController.swift
//  Calm demo
//
//  Created by Chirag Bhojani on 28/12/22.
//

import UIKit
import FSCalendar
import Lottie

class ViewController: UIViewController {
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var stackLocation: UIStackView!
    
    
    
//    calendar selection stack
    @IBOutlet weak var stackTripLocation: UIStackView!
    @IBOutlet weak var viewTripHeader: UIView!
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var viewTripCalendar: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var btnFive: UIButton!
    @IBOutlet weak var btnTwelve: UIButton!
    @IBOutlet weak var btnSix: UIButton!
    @IBOutlet weak var constHeightCalendarView: NSLayoutConstraint!
    var strTime = ""
    
    
    // Age selection stack
    @IBOutlet weak var stackAgeSelection: UIStackView!
    @IBOutlet weak var viewParentPicker: UIView!
    @IBOutlet weak var lblTotalMember: UILabel!
    @IBOutlet weak var lblHowManyParent: UILabel!
    @IBOutlet weak var viewChildPicker: UIView!
    @IBOutlet weak var imgCheckMark: UIImageView!
    @IBOutlet weak var constHeightParentAgeView: NSLayoutConstraint!
    @IBOutlet weak var constHeightChildAgeView: NSLayoutConstraint!
    var rotationAngle: CGFloat! = -90  * (.pi/180)
    var parentAgePicker: UIPickerView!
    var childAgePicker: UIPickerView!
    var parentAge = ["12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25"]
    var childAge = ["1", "2", "3", "4", "5", "6", "7","8", "9", "10", "11"]
    var intParentAge = ""
    var intChildAge = ""
    
    // Pay selection stack
    @IBOutlet weak var stackPay: UIStackView!
    @IBOutlet weak var viewPayHeader: UIView!
    @IBOutlet weak var viewApplePay: UIView!
    @IBOutlet weak var lottieView: UIView!
    @IBOutlet weak var imgAerrow: UIImageView!
    private let animationView = LottieAnimationView()
    
    var isDone = false
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, d"
        return formatter
    }()
    
    private var firstDate: Date?
    private var lastDate: Date?
    var datesRange: [Date]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackAgeSelection.clipsToBounds = true
        stackAgeSelection.layer.cornerRadius = 24
        stackAgeSelection.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        stackPay.clipsToBounds = true
        stackPay.layer.cornerRadius = 24
        stackPay.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        setupAgePicker()
        setupCalendarView()
        setupLottieAnimation()
        viewChildPicker.isHidden = true
        viewParentPicker.isHidden = true
        self.constHeightChildAgeView.constant = 0
        self.constHeightParentAgeView.constant = 0
        viewApplePay.isHidden = true
        viewDate.isHidden = true
        manageExpandViews(index: 1)
    }
    
    func setupLottieAnimation() {
        animationView.frame = lottieView.bounds
        if let animation = LottieAnimation.named("pay_animation") {
          animationView.animation = animation
        }
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        lottieView.addSubview(animationView)
    }
    
    func setupCalendarView() {
        if (datesRange == nil || strTime == "") {
            UIView.animate(withDuration: 0.25, animations: {
                self.constHeightCalendarView.constant = 360
                self.viewTripCalendar.isHidden = false
                self.viewDate.isHidden = true
                self.view.layoutIfNeeded()
            })
        } else {
            UIView.animate(withDuration: 0.25, animations: {
                let dateRange = self.formatter.string(from: (self.datesRange?.first)!) + " - " + self.formatter.string(from: (self.datesRange?.last)!)
                self.lblDate.text = dateRange
                self.viewTripCalendar.isHidden = true
                self.viewDate.isHidden = false
                self.constHeightCalendarView.constant = 0
//                self.manageExpandViews(index: 2)
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func setupAgePicker() {
        parentAgePicker = UIPickerView()
        parentAgePicker.dataSource = self
        parentAgePicker.delegate = self
        parentAgePicker.backgroundColor = .clear
        self.viewParentPicker.addSubview(parentAgePicker)
        
        parentAgePicker.transform = CGAffineTransform(rotationAngle: rotationAngle)
        parentAgePicker.frame = CGRect(x: -150, y: 0, width: viewChildPicker.bounds.width + 300, height: 100)
        childAgePicker = UIPickerView()
        childAgePicker.dataSource = self
        childAgePicker.delegate = self
        childAgePicker.backgroundColor = .clear
        self.viewChildPicker.addSubview(childAgePicker)
        
        childAgePicker.transform = CGAffineTransform(rotationAngle: rotationAngle)
        childAgePicker.frame = CGRect(x: -150, y: 0, width: viewChildPicker.bounds.width + 300, height: 100)
    }
    
    func manageExpandViews(index: Int) {
        switch index {
//        case 1:
//            UIView.animate(withDuration: 0.25, animations: {
//                self.viewParentPicker.isHidden = true
//                self.viewChildPicker.isHidden = true
//                self.constHeightChildAgeView.constant = 0
//                self.constHeightParentAgeView.constant = 0
//                self.viewApplePay.isHidden = true
//                self.lottieView.isHidden = true
//                self.constHeightCalendarView.constant = 360
//                self.viewTripCalendar.isHidden = false
//                self.view.layoutIfNeeded()
//            })
//            break
        case 2:
            UIView.animate(withDuration: 0.25, animations: {
                self.constHeightCalendarView.constant = 0
                self.viewTripCalendar.isHidden = true
                self.viewApplePay.isHidden = true
                self.viewChildPicker.isHidden = true
                self.lottieView.isHidden = true
                self.viewParentPicker.isHidden = false
                self.constHeightChildAgeView.constant = 0
                self.constHeightParentAgeView.constant = 100
                self.view.layoutIfNeeded()
            })
            break
        case 3:
            UIView.animate(withDuration: 0.25, animations: {
                self.constHeightCalendarView.constant = 0
                self.viewTripCalendar.isHidden = true
                self.viewParentPicker.isHidden = true
                self.constHeightChildAgeView.constant = 0
                self.constHeightParentAgeView.constant = 0
                self.viewChildPicker.isHidden = true
                self.viewApplePay.isHidden = false
                self.lottieView.isHidden = false
                self.imgAerrow.image = (self.viewApplePay.isHidden) ? UIImage(named: "icoDown") : UIImage(named: "icoUp")
                self.view.layoutIfNeeded()
            })
            break
        default:
            break
        }
    }
}

extension ViewController {
    
    @IBAction func btnFiveClick(_ sender: UIButton) {
        strTime = "05 : 00 AM"
        self.setupButtonDesign(btn1: btnFive, btn2: btnTwelve, btn3: btnSix)
    }
    
    @IBAction func btnTwelveClick(_ sender: UIButton) {
        strTime = "12 : 30 PM"
        self.setupButtonDesign(btn1: btnTwelve, btn2: btnFive, btn3: btnSix)
    }
    
    @IBAction func btnSixClick(_ sender: UIButton) {
        strTime = "06 : 00 PM"
        self.setupButtonDesign(btn1: btnSix, btn2: btnFive, btn3: btnTwelve)
    }
    
    func setupButtonDesign(btn1: UIButton, btn2: UIButton, btn3: UIButton) {
        btn1.backgroundColor = Color.PinkColor.color()
        btn1.setTitleColor(Color.TextColor.color(), for: .normal)
        
        btn2.backgroundColor = .white.withAlphaComponent(0.15)
        btn2.setTitleColor(Color.DarkColor.color(), for: .normal)
        
        btn3.backgroundColor = .white.withAlphaComponent(0.15)
        btn3.setTitleColor(Color.DarkColor.color(), for: .normal)
//        self.setupCalendarView()
    }
    
    @IBAction func btnCalendarClick(_ sender: UIButton) {
//        manageExpandViews(index: 1)
    }
    
    @IBAction func btnHowManyAdultsClick(_ sender: UIButton) {
        if (datesRange == nil || strTime == "") {
            
        } else {
            setupCalendarView()
            if (intParentAge == "" && intChildAge == "") {
                manageExpandViews(index: 2)
            }
        }
    }
    
    @IBAction func btnChildrenClick(_ sender: UIButton) {
        UIView.animate(withDuration: 0.25, animations: {
            self.viewChildPicker.isHidden = (self.viewChildPicker.isHidden) ? false : true
            self.constHeightChildAgeView.constant = (self.viewChildPicker.isHidden) ? 0 : 100
            
            self.view.layoutIfNeeded()
        })
        self.imgCheckMark.image = (self.viewChildPicker.isHidden) ? UIImage(named: "icoUncheck") : UIImage(named: "icoCheck")
    }
    
    @IBAction func btnPayClick(_ sender: UIButton) {
        if intParentAge == "" && intChildAge == "" {
            self.lblTotalMember.text = "12 Years"
            self.lblHowManyParent.text = "How Many Adults?"
        } else {
            if isDone {
                self.dismiss(animated: true)
            } else {
                isDone = true
                self.lblTotalMember.text = intParentAge + " Parents, " + intChildAge + " Childrens"
                self.lblHowManyParent.text = ""
                manageExpandViews(index: 3)
            }
            
        }
    }
}



extension ViewController: FSCalendarDataSource, FSCalendarDelegate {
    func datesRange(from: Date, to: Date) -> [Date] {
        if from > to { return [Date]() }

        var tempDate = from
        var array = [tempDate]

        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }

        return array
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if firstDate == nil {
            firstDate = date
            datesRange = [firstDate!]
            return
        }

        if firstDate != nil && lastDate == nil {
            if date <= firstDate! {
                calendar.deselect(firstDate!)
                firstDate = date
                datesRange = [firstDate!]
                return
            }
            
            let range = datesRange(from: firstDate!, to: date)
            lastDate = range.last
            for d in range {
                calendar.select(d)
            }
            datesRange = range
            self.setupCalendarView()
            return
        }

        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            lastDate = nil
            firstDate = nil
            datesRange = []
        }
        
    }

    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }

            lastDate = nil
            firstDate = nil
            self.setupCalendarView()
            datesRange = []
        }
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == parentAgePicker {
            return parentAge.count
        } else {
            return childAge.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.backgroundColor = .clear
        pickerLabel.textColor = (row == pickerView.selectedRow(inComponent: component)) ? UIColor.white : Color.DarkColor.color()
        
        if pickerView == parentAgePicker {
            pickerLabel.text = parentAge[row]
        } else {
            pickerLabel.text = childAge[row]
        }
        pickerLabel.font = UIFont.boldSystemFont(ofSize: 60.0)
        pickerLabel.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
        pickerLabel.textAlignment = .center
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == parentAgePicker {
            intParentAge = parentAge[row]
            parentAgePicker.reloadComponent(component)
        } else {
            intChildAge = childAge[row]
            childAgePicker.reloadComponent(component)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
}

