//
//  ViewController.swift
//  StopWatch
//
//  Created by Allen on 16/1/4.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    var Counter = 0.0
    var Timer = NSTimer()
    var IsPlaying = false
    var number = 1
    var ListArray: NSMutableArray = []
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {	
        timeLabel.text = String(Counter)
        super.viewDidLoad()
        timeRecordTable.delegate = self
        timeRecordTable.dataSource = self
    }
    
    @IBOutlet weak var timeRecordTable: UITableView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func resetButtonDidTouch(sender: AnyObject) {
        Timer.invalidate()
        IsPlaying = false
        Counter = 0
        ListArray.removeAllObjects()
        number = 1
        timeRecordTable.reloadData()
        timeLabel.text = String(Counter)
        playBtn.enabled = true
        pauseBtn.enabled = true
    }
    
    @IBAction func playButtonDidTouch(sender: AnyObject) {
        if(IsPlaying) {
            ListArray.addObject("No"+number.description + ": "+String(format: "%.1f",Counter))
            number++
            self.timeRecordTable.reloadData()
            let numberOfSections = self.timeRecordTable.numberOfSections
            let numberOfRows = self.timeRecordTable.numberOfRowsInSection(numberOfSections-1)
            let indexPath = NSIndexPath(forRow: numberOfRows-1, inSection: numberOfSections-1)
            self.timeRecordTable.scrollToRowAtIndexPath(indexPath, atScrollPosition:UITableViewScrollPosition.Middle, animated: true)
            return
        }
        //playBtn.enabled = false
        pauseBtn.enabled = true
        Timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: Selector("UpdateTimer"), userInfo: nil, repeats: true)
        IsPlaying = true
    }
    
    @IBAction func pauseButtonDidTouch(sender: AnyObject) {
        
        playBtn.enabled = true
        pauseBtn.enabled = false
        Timer.invalidate()
        IsPlaying = false
        
    }
    
    func UpdateTimer() {
        Counter = Counter + 0.05
        timeLabel.text = String(format: "%.1f", Counter)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return ListArray.count
    }
    
    //填充UITableViewCell中文字標簽的值
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = "\(ListArray.objectAtIndex(indexPath.row))"
        
        return cell
    }
    
}

