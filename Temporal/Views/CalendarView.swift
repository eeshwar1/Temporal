//
//  CalendarView.swift
//  Temporal2
//
//  Created by Venky Venkatakrishnan on 7/23/18.
//  Copyright © 2018 Venky UL. All rights reserved.
//

import Cocoa

class CalendarView: NSView {

    @IBOutlet var calendarViewItem: NSView!
    @IBOutlet weak var buttonMonthName: NSButton!
    
    @IBOutlet weak var buttonPrevMonth: VButton!
    @IBOutlet weak var buttonNextMonth: VButton!
    
    @IBOutlet weak var buttonPrevYear: VButton!
    @IBOutlet weak var buttonNextYear: VButton!
    
    fileprivate var clockThemes: [String] = []
    
    fileprivate var dates: [Int] = Array(1...31)
    
    fileprivate var dayNames: [String] = ["Su","Mo","Tu","We","Th","Fr","Sa"]
    
    var itemSizeFactor: CGFloat = 7.5
    {
        didSet {
          configureCollectionView()
        }
    }
    var datesPerSection: Int = 7
    var numOfRows: Int = 7
    
    
    @IBOutlet weak var collectionView: NSCollectionView!
    
    var calendarMonth: CalendarMonth = CalendarMonth()
    
    var todayDay: Int = 0
    var todayMonth: Int = 0
    var todayYear: Int = 0
    
    var displayMonth: Int = 0
    var displayYear: Int = 0
    
    var theme: String = "Night"
    
    required init?(coder decoder: NSCoder) {
        
        super.init(coder: decoder)
       
       commonInit()
        
    }
    
    required override init(frame frameRect: NSRect) {
        
        super.init(frame: frameRect)
        
        commonInit()
    }
    
    func commonInit()
    {
        Bundle.main.loadNibNamed("CalendarView", owner: self, topLevelObjects: nil)
        
        let contentFrame = NSMakeRect(0, 0, frame.size.width, frame.size.height )
        
        self.calendarViewItem.frame = contentFrame
        
        configureCollectionView()
        
        self.addSubview(self.calendarViewItem)

        setDate(date: Date())
        
        let trackingArea = NSTrackingArea(rect: self.bounds, options: [.activeAlways, .mouseEnteredAndExited, .mouseMoved], owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea)
        
            
    }
    
    func hideControls()
    {
        self.buttonNextYear.isHidden = true
        self.buttonPrevYear.isHidden = true
        self.buttonNextMonth.isHidden = true
        self.buttonPrevMonth.isHidden = true
        
        self.setNeedsDisplay(bounds)
    }
    
    func setDate(date: Date)
    {
      
        let calendar = Calendar.current
        
        self.todayDay = calendar.component(.day, from: date)
        self.todayMonth = calendar.component(.month, from: date)
        self.todayYear = calendar.component(.year, from: date)
        
        self.displayYear = self.todayYear
        self.displayMonth = self.todayMonth
        
        self.displayCalendar()
        
        
    }
    
    func displayCalendar()
    {
        
        self.setToday()
        
        self.calendarMonth.setMonthAndYear(month: self.displayMonth,year: self.displayYear)
        
        self.collectionView.reloadData()
        
        self.buttonMonthName.title = calendarMonth.monthAndYear
    }

    func setToday()
    {
        
         let today = Date()
         let calendar = Calendar.current
        
         let todayMonth = calendar.component(.month, from: today)
         let todayYear =  calendar.component(.year, from: today)
         let todayDay =  calendar.component(.day, from: today)
         
         self.todayMonth = todayMonth
         self.todayYear = todayYear
         self.todayDay = todayDay
    
         
        
    }
    private func configureCollectionView() {
        
        let flowLayout = NSCollectionViewFlowLayout()
        
        let cView = collectionView!
        
        let itemWidth = cView.frame.width / self.itemSizeFactor
        
        let itemHeight = cView.frame.height / self.itemSizeFactor * 0.95
    
        flowLayout.itemSize = NSSize(width: itemWidth,
                                     height: itemHeight)
        
        // print("Flow Layout Item Size: \(flowLayout.itemSize)")
     
        // let hInset = cView.frame.width / 100
        // let vInset = cView.frame.height / 100
        
        let hInset: CGFloat = 1.0
        let vInset: CGFloat = 1.0
        
        flowLayout.sectionInset = NSEdgeInsets(top: vInset,
                                              left: hInset,
                                              bottom: vInset,
                                              right: hInset)

        // flowLayout.minimumInteritemSpacing = flowLayout.itemSize.width/20
        
        flowLayout.minimumInteritemSpacing = 1.0
        flowLayout.minimumLineSpacing = 1.0
        
        // print("Minimum Interitem Spacing: \(flowLayout.minimumInteritemSpacing)")
        
        // flowLayout.minimumLineSpacing = cView.frame.height / 1000
        
        // flowLayout.minimumLineSpacing = flowLayout.itemSize.width/10
        
        cView.collectionViewLayout = flowLayout
        
        cView.wantsLayer = true
        
        cView.layer?.backgroundColor = NSColor.windowFrameColor.cgColor
        
    }
    
    func setTheme(theme: String)
    {
        if Themes.calendarThemeColors[theme] != nil
        {
            self.theme  = theme
            self.displayCalendar()
        }
        
    }
    
    // Actions
    
    @IBAction func clickNextMonth(_ sender: Any) {
        
        
        var dateComponents = DateComponents()
        dateComponents.month = self.calendarMonth.month
        dateComponents.year = self.calendarMonth.year
        dateComponents.day  = 1
        
        let calendar = Calendar.current
        
        let date = calendar.date(from: dateComponents)!
        
        dateComponents.month = 1
        dateComponents.day = 0
        dateComponents.year = 0
        
        let nextMonthDate = calendar.date(byAdding: dateComponents, to: date)!
        
        let nextMonthDateMonth = calendar.component(.month, from: nextMonthDate)
        let nextMonthDateYear = calendar.component(.year, from: nextMonthDate)
        
        self.displayMonth = nextMonthDateMonth
        self.displayYear = nextMonthDateYear
        
        self.displayCalendar()
     
    }
    
    @IBAction func clickPrevMonth(_ sender: Any) {
        
        
        var dateComponents = DateComponents()
        dateComponents.month = self.calendarMonth.month
        dateComponents.year = self.calendarMonth.year
        dateComponents.day  = 1
        
        let calendar = Calendar.current
        
        let date = calendar.date(from: dateComponents)!
        
        dateComponents.month = -1
        dateComponents.day = 0
        dateComponents.year = 0
        
        let prevMonthDate = calendar.date(byAdding: dateComponents, to: date)!
        
        let prevMonthDateMonth = calendar.component(.month, from: prevMonthDate)
        let prevMonthDateYear = calendar.component(.year, from: prevMonthDate)
        
        self.displayMonth = prevMonthDateMonth
        self.displayYear = prevMonthDateYear
        
        self.displayCalendar()
        
    }
    
    @IBAction func clickPrevYear(_ sender: Any) {
        
        
        var dateComponents = DateComponents()
        dateComponents.month = self.calendarMonth.month
        dateComponents.year = self.calendarMonth.year
        dateComponents.day  = 1
        
        let calendar = Calendar.current
        
        let date = calendar.date(from: dateComponents)!
        
        dateComponents.month = 0
        dateComponents.day = 0
        dateComponents.year = -1
        
        let prevYearDate = calendar.date(byAdding: dateComponents, to: date)!
        
        let prevYearDateMonth = calendar.component(.month, from: prevYearDate)
        let prevYearDateYear = calendar.component(.year, from: prevYearDate)
        
        self.displayMonth = prevYearDateMonth
        self.displayYear = prevYearDateYear
        
        self.displayCalendar()
        
    }
    
    @IBAction func clickNextYear(_ sender: Any) {
        
        
        var dateComponents = DateComponents()
        dateComponents.month = self.calendarMonth.month
        dateComponents.year = self.calendarMonth.year
        dateComponents.day  = 1
        
        let calendar = Calendar.current
        
        let date = calendar.date(from: dateComponents)!
        
        dateComponents.month = 0
        dateComponents.day = 0
        dateComponents.year = 1
        
        let nextYearDate = calendar.date(byAdding: dateComponents, to: date)!
        
        let nextYearDateMonth = calendar.component(.month,
                                                   from: nextYearDate)
        let nextYearDateYear = calendar.component(.year,
                                                  from: nextYearDate)
        
        self.displayMonth = nextYearDateMonth
        self.displayYear = nextYearDateYear
        
        self.displayCalendar()

        
    }
    
    @IBAction func showToday(_ sender: Any)
    {
        
        self.displayMonth = self.todayMonth
        self.displayYear = self.todayYear
        
        self.displayCalendar()
        
    }
    
    override func mouseEntered(with event: NSEvent) {
       
        print("mouseEntered")
    }
    
    override func mouseExited(with event: NSEvent) {
    
        print("mouseExited")
        
    }
}

extension CalendarView: NSCollectionViewDataSource {
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
      
        return numOfRows
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return datesPerSection
        
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "CalendarDateItem"), for: indexPath)
    
        
        guard let calendarDateItem = item as? CalendarDateItem else { return item }
        
        var currentIndex: Int = 0
        
        calendarDateItem.setTheme(theme: self.theme)
        
        calendarDateItem.titleItem = false
        
        // Title row
        if indexPath.section == 0
        {
            calendarDateItem.dateText = dayNames[indexPath.item]
            calendarDateItem.titleItem = true
        }
        else if indexPath.section == 1
        {
            if indexPath.item < self.calendarMonth.firstDayOfMonthWeekDay - 1
            {
                
                let dateIndex = (self.calendarMonth.prevMonthDates.count - (self.calendarMonth.firstDayOfMonthWeekDay - indexPath.item - 1))
                
                let dateValue = self.calendarMonth.prevMonthDates[dateIndex]
                
                calendarDateItem.dateText  = "\(dateValue)"
                
             
                calendarDateItem.otherMonthDate = true
            }
            else
            {
                currentIndex = (indexPath.section  - 1) * 7 +
                    
                    indexPath.item - self.calendarMonth.firstDayOfMonthWeekDay + 1
                
                if currentIndex <= self.calendarMonth.dates.count - 1
                {
                    calendarDateItem.dateText = String(describing: self.calendarMonth.dates[currentIndex])
                }
                else
                {
                    calendarDateItem.dateText  = ""
                }
                
            }
            
        }
        else {
            
            currentIndex = (indexPath.section  - 1) * 7 +
                
                indexPath.item - self.calendarMonth.firstDayOfMonthWeekDay + 1
            
            if currentIndex <= self.calendarMonth.dates.count - 1
            {
                calendarDateItem.dateText = String(describing: self.calendarMonth.dates[currentIndex])
            }
            else
            {
                calendarDateItem.dateText  = ""
            }
            
            
        }
        
        // Check for today's date and set flag for highlighting
        if currentIndex <= self.calendarMonth.dates.count - 1 && calendarDateItem.titleItem == false
        {
            if self.calendarMonth.dates[currentIndex] == self.todayDay &&
                self.calendarMonth.month == self.todayMonth &&
                self.calendarMonth.year == self.todayYear
            {
                calendarDateItem.isToday = true
            }
            else
            {
                calendarDateItem.isToday = false
            }
        }
        
        if currentIndex >= self.calendarMonth.dates.count
        {
            let dateIndex = currentIndex - self.calendarMonth.dates.count
            
            let dateValue = self.calendarMonth.nextMonthDates[dateIndex]
            calendarDateItem.dateText = "\(dateValue)"
            calendarDateItem.otherMonthDate = true
        }
        
        return calendarDateItem
        
    }
    
}

