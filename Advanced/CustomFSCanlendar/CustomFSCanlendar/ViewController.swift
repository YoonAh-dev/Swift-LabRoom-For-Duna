//
//  ViewController.swift
//  CustomFSCanlendar
//
//  Created by SHIN YOON AH on 2021/06/21.
//

import UIKit
import FSCalendar

class ViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    @IBOutlet weak var calendar: FSCalendar!
    
    let dateFormatter = DateFormatter()
    var events: [Date] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.delegate = self
        calendar.dataSource = self
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // header 설정하기
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 18)
        
        // 윗 상단 한국말로 바꾸기
        calendar.appearance.headerDateFormat = "YYYY.MM"
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.calendarWeekdayView.weekdayLabels[0].text = "일"
        calendar.calendarWeekdayView.weekdayLabels[1].text = "월"
        calendar.calendarWeekdayView.weekdayLabels[2].text = "화"
        calendar.calendarWeekdayView.weekdayLabels[3].text = "수"
        calendar.calendarWeekdayView.weekdayLabels[4].text = "목"
        calendar.calendarWeekdayView.weekdayLabels[5].text = "금"
        calendar.calendarWeekdayView.weekdayLabels[6].text = "토"
        
        // 양 옆 흐릿한 글자 지우기
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        
        // 이벤트 추가해주는 코드
        setUpEvents()
    }

    // 날짜 선택 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 선택됨")
    }
    // 날짜 선택 해제 시 콜백 메소드
    public func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 해제됨")
    }
    
    // DataFormatter를 활용해서 이벤트 날짜를 추가해주는 코드
    func setUpEvents() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
        
        let xmas = formatter.date(from: "2021-06-25")
        let sampledate = formatter.date(from: "2021-09-13")
        events = [xmas!, sampledate!]
    }
    
    // 버튼을 사용해서 캘린더 움직이기
    private func moveCurrentPage(moveUp: Bool) {
//        dateComponents.month = moveUp ? 1 : -1
////        self.currentPage = calendarCurrent.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
//        self.calendar.setCurrentPage(self.currentPage!, animated: true)
    }
    
    @objc func tappedPrevBtn(_ sender: Any) {
        self.moveCurrentPage(moveUp: false)
    }
    
    @objc func tappedNextBtn(_ sender: Any) {
        self.moveCurrentPage(moveUp: true)
    }
}

extension ViewController {
    //이벤트 표시 개수
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if self.events.contains(date) {
            return 6
        } else {
            return 0
        }
    }
}
