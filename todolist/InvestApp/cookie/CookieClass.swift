//
//  CookieClass.swift
//  todolist
//
//  Created by Артем Аверьянов on 07.03.2024.
//

import Foundation

class CookieClass {
    static func saveCookies() {
        if let cookies = HTTPCookieStorage.shared.cookies {
            let data = try? NSKeyedArchiver.archivedData(withRootObject: cookies, requiringSecureCoding: false)
            UserDefaults.standard.set(data, forKey: "savedCookies")
        }
    }
    
    static func loadCookies() {
        if let data = UserDefaults.standard.object(forKey: "savedCookies") as? Data,
           let cookies = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, HTTPCookie.self], from: data) as? [HTTPCookie] {
            cookies.forEach { HTTPCookieStorage.shared.setCookie($0) }
        }
    }
}
