//
//  TimerDemoStore.swift
//  TimerDemo
//
//  Created by KyleLearnedThis on 4/28/22.
//

import Combine
import UserNotifications

class TimerDemoStore: ObservableObject {
    func createNotificationTrigger(seconds: Int) {
        if seconds <= 0 {
            return
        }
        let center = UNUserNotificationCenter.current()
        // Ask Permission
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            print("=== ask permission ===")
            if granted {
                print("===== Yay! =====")
            } else {
                print("===== D'oh =====")
            }
        }
        // Create Notification content
        let content = UNMutableNotificationContent()
        content.title = "TimerDemo app"
        content.body = "It's been \(seconds) seconds!!!"

        // Create Trigger
        let date = Date().addingTimeInterval(TimeInterval(seconds))
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        // Create Request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)

        center.add(request) { (error) in
            print("=== added request ===")
        }
    }
}
