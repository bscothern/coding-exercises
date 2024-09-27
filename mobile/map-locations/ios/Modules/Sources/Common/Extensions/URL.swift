//
//  URL.swift
//  Voze Coding Exercise
//
//  Created by Braden Scothern on 9/25/24.
//

import Foundation

extension URL {
    /// This type of pattern lets you use doy syntax so anywhere expecting a URL you can now use it like this:
    /// someFunc(url: .app.someURL)
    public static var app: Constant.AppURL.Type { Constant.AppURL.self }
}
