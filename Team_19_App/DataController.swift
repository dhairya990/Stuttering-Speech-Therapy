import Foundation
import UIKit

class DataController {
    
    // Todo - Save in firestore
    var wordCountPerDay = [
        WordCount(),
        WordCount(),
        WordCount(),
        WordCount(),
        WordCount(),
        WordCount(),
        WordCount()
    ]
    
    func getStutterCount(for weekDay: WeekDay) -> Int {
        wordCountPerDay[weekDays.firstIndex(of: weekDay)!].stutterCount
    }
    
    func getNoStutterCount(for weekDay: WeekDay) -> Int {
        wordCountPerDay[weekDays.firstIndex(of: weekDay)!].noStutterCount
    }
    
    func setStutterCount(to count: Int, for weekDay: WeekDay) {
        wordCountPerDay[weekDays.firstIndex(of: weekDay)!].stutterCount = count
    }
    
    func setNoStutterCount(to count: Int, for weekDay: WeekDay) {
        wordCountPerDay[weekDays.firstIndex(of: weekDay)!].noStutterCount = count
    }
    
    static let shared = DataController()
    private init(){
        loadInitialData()
    }
    
    let doctorData = [ DoctorData(doctorName: "Dr. Gupta", doctorQualification: "Phd Child Specialist", doctorRating: "4.3 ⭐️", doctorExperience: "10+ years of experience", doctorPhoto: "Image 10" ,PhoneNumber: "876487432",Email: "john@gmail.com"),
        
        DoctorData(doctorName: "Dr. Priya", doctorQualification: "MBBS", doctorRating: "4.1 ⭐️", doctorExperience: "5+ year", doctorPhoto: "Image 11",PhoneNumber: "876487432",Email: "priya@gmail.com")
        ]
    
    let items = ["100+" , "50+"]
    
    
    var numbers: [NumberItem] = []
    var imageLabels: [ImageLabelItem] = []
    private(set) var imageOnlyItems: [ImageOnlyItem] = []

    // Load initial data
    private func loadInitialData() {
        numbers = (1...30).map { NumberItem(value: $0, isSelected: false) }

        imageLabels = [
            ImageLabelItem(imageName: "open-book", labelText: "Introduction", duration: "15 min", audioFileURLs: []),
            ImageLabelItem(imageName: "practice 2", labelText: "Module", duration: "20 min", audioFileURLs: []),
            ImageLabelItem(imageName: "Practice", labelText: "Practice", duration: "30 min", audioFileURLs: []),
            ImageLabelItem(imageName: "conclusion", labelText: "Conclusion", duration: "45 min", audioFileURLs: [])
        ]
        
        let currentHour = Calendar.current.component(.hour, from: Date())
        var imageName: String

        if (6..<12).contains(currentHour) {
            imageName = "Image"
        } else if (12..<18).contains(currentHour) {
            imageName = "Image"
        } else {
            imageName = "image6"
        }
        imageOnlyItems = [ImageOnlyItem(imageName: imageName)]
    }
}
