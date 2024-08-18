//
//  DataModel.swift
//  exerciese
//
//  Created by Sambhav Singh on 25/05/24.
//

import Foundation
import UIKit

//struct UserInfo{
//    var name:String
//    var age:Int
//    var phoneNumber:Int
//}

struct DoctorData {
    var doctorName : String
    var doctorQualification : String
    var doctorRating : String
    var doctorExperience : String
    var doctorPhoto : String
    var PhoneNumber:String
    var Email:String
}

let weekDays = WeekDay.allCases

enum WeekDay: String, Comparable, CaseIterable {
    
    static func < (lhs: WeekDay, rhs: WeekDay) -> Bool {
        weekDays.firstIndex(of: lhs)!.magnitude < weekDays.firstIndex(of: rhs)!.magnitude
    }
    
    case monday = "Mon"
    case tuesday = "Tue"
    case wednesday = "Wed"
    case thursday = "Thu"
    case friday = "Fri"
    case saturday = "Sat"
    case sunday = "Sun"
}

struct WordCount: Identifiable {
    var id = UUID()
    var stutterCount = 0
    var noStutterCount = 0
}

enum SectionType {
    case number
    case imageLabel
    case imageOnly
}

struct Section {
    let type: SectionType
    var items: [Any]
    init(type: SectionType, items: [Any]) {
            self.type = type
            self.items = items
    }
}

struct NumberItem {
    let id: UUID
    let value: Int
    var isSelected: Bool
    
    init(id: UUID = UUID(), value: Int, isSelected: Bool) {
        self.id = id
        self.value = value
        self.isSelected = isSelected
    }
}

class ImageLabelItem {
    var imageName: String
    var labelText: String
    var duration: String
    var audioFileURLs: [URL]
    var currentAudioIndex: Int
    
    init(imageName: String, labelText: String, duration: String, audioFileURLs: [URL]) {
        self.imageName = imageName
        self.labelText = labelText
        self.duration = duration
        self.audioFileURLs = audioFileURLs
        self.currentAudioIndex = 0
   }
    
func getCurrentAudioURL() -> URL? {
        guard currentAudioIndex >= 0 && currentAudioIndex < audioFileURLs.count else {
            return nil
        }
        return audioFileURLs[currentAudioIndex]
    }
}
        
struct ImageOnlyItem {
    var id = UUID()
    let imageName: String
    init(imageName: String) {
    self.imageName = imageName
    }
}

