//
//  UniversalAccess.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/24/22.
//

import Foundation

struct Keys{
    static let easyStreak = "Easy Streak"
    static let mediumStreak = "Medium Streak"
    static let hardStreak = "Hard Streak"
    static let squareStreak = "Square Streak"
    static let extremeStreak = "Extreme Streak"
    static let easyStreakTimed = "Easy Streak Timed"
    static let mediumStreakTimed = "Medium Streak Timed"
    static let hardStreakTimed = "Hard Streak Timed"
    static let squareStreakTimed = "Square Streak Timed"
    static let extremeStreakTimed = "Extreme Streak Timed"
    static let easyStreakMaxQ = "Easy Streak Max Questions"
    static let mediumStreakMaxQ = "Medium Streak Max Questions"
    static let hardStreakMaxQ = "Hard Streak Max Questions"
    static let squareStreakMaxQ = "Square Streak Max Questions"
    static let extremeStreakMaxQ = "Extreme Streak Max Questions"
}



let defaults = UserDefaults.standard
let keysEndless = [Keys.easyStreak, Keys.mediumStreak, Keys.hardStreak, Keys.squareStreak, Keys.extremeStreak]
let keysTimed = [Keys.easyStreakTimed, Keys.mediumStreakTimed, Keys.hardStreakTimed, Keys.squareStreakTimed, Keys.extremeStreakTimed]
let keysMaxQ = [Keys.easyStreakMaxQ, Keys.mediumStreakMaxQ, Keys.hardStreakMaxQ, Keys.squareStreakMaxQ, Keys.extremeStreakMaxQ]

enum Difficulty: String, CaseIterable, Identifiable {
    case easy, medium, hard, squares, extreme
    var id: Self { self }
}
