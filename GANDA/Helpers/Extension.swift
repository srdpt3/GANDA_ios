//
//  Extension.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/2/22.
//

import Foundation
import SwiftUI

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}

func timeAgoSinceDate(_ date:Date, currentDate:Date, numericDates:Bool) -> String {
    let calendar = Calendar.current
    let now = currentDate
    let earliest = (now as NSDate).earlierDate(date)
    let latest = (earliest == now) ? date : now
    let components:DateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.minute , NSCalendar.Unit.hour , NSCalendar.Unit.day , NSCalendar.Unit.weekOfYear , NSCalendar.Unit.month , NSCalendar.Unit.year , NSCalendar.Unit.second], from: earliest, to: latest, options: NSCalendar.Options())
    
    if (components.year! >= 2) {
        return "\(components.year!) 년 전"
    } else if (components.year! >= 1){
        if (numericDates){ return "1년 전"
        } else { return "Last year" }
    } else if (components.month! >= 2) {
        return "\(components.month!)달 전"
    } else if (components.month! >= 1){
        if (numericDates){ return "한달 전"
        } else { return "Last month" }
    } else if (components.weekOfYear! >= 2) {
        return "\(components.weekOfYear!)주일 전"
    } else if (components.weekOfYear! >= 1){
        if (numericDates){ return "일주일 전"
        } else { return "Last week" }
    } else if (components.day! >= 2) {
        return "\(components.day!)일 전"
    } else if (components.day! >= 1){
        if (numericDates){ return "하루 전"
        } else { return "Yesterday" }
    } else if (components.hour! >= 2) {
        return "\(components.hour!)시간 전"
    } else if (components.hour! >= 1){
        if (numericDates){ return "1시간 전"
        } else { return "An hour ago" }
    } else if (components.minute! >= 2) {
        return "\(components.minute!)분 전"
    } else if (components.minute! >= 1){
        if (numericDates){ return "1분 전"
        } else { return "A minute ago" }
    } else if (components.second! >= 3) {
        return "\(components.second!)초 전"
    } else { return "Just now" }
}

extension Array {
       func splited(into size:Int) -> [[Element]] {
         
         var splittedArray = [[Element]]()
         if self.count >= size {
                 
             for index in 0...self.count {
                if index % size == 0 && index != 0 {
                    splittedArray.append(Array(self[(index - size)..<index]))
                } else if(index == self.count) {
                    splittedArray.append(Array(self[index - 1..<index]))
                }
             }
         } else {
             splittedArray.append(Array(self[0..<self.count]))
         }
         return splittedArray
     }
}

extension String {
    func splitStringToArray() -> [String] {
        let trimmedText = String(self.filter { !" \n\t\r".contains($0) })
        var substringArray: [String] = []
        for (index, _) in trimmedText.enumerated() {
            let prefixIndex = index + 1
            let substringPrefix = String(trimmedText.prefix(prefixIndex)).lowercased()
            substringArray.append(substringPrefix)
        }
        return substringArray
    }
}

extension Encodable {
    func toDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}

extension Decodable {
    init(fromDictionary: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: fromDictionary, options: JSONSerialization.WritingOptions.prettyPrinted)
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: data)
    }
}


//extension Color {
//    static let neuBackground = Color(hex: "f0f0f3")
//    static let dropShadow = Color(hex: "aeaec0").opacity(0.4)
//    static let dropLight = Color(hex: "ffffff")
//    static let offwhite = Color(red: 255/255, green: 255/255, blue: 235/255)
//}


//extension Color {
//    init(hex: String) {
//        let scanner = Scanner(string: hex)
//        scanner.scanLocation = 0
//        var rgbValue: UInt64 = 0
//        scanner.scanHexInt64(&rgbValue)
//
//        let r = (rgbValue & 0xff0000) >> 16
//        let g = (rgbValue & 0xff00) >> 8
//        let b = rgbValue & 0xff
//
//        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
//    }
//}

extension Dictionary {
    subscript(i:Int) -> (key: Key, value: Value) {
        get {
            return self[index(startIndex, offsetBy : i)];
        }
    }
}



extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}
