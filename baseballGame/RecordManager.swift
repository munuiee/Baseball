//
//  RecordManager.swift
//  baseballGame
//
//  Created by 변지혜 on 8/29/25.
//

import Foundation

class RecordManager {
    var trialCount: Int = 0 // 1회 게임에서의 시도 횟수
    var gameCount: Int = 0 // 게임 작동 횟수
    var records: [Int] = []
    
    // 시도횟수 증가
    func add() -> Int {
        trialCount += 1
        return trialCount
    }
   
    // i = 게임 횟수, count = 시도 횟수
    func showRecords() {
        for (i, count) in records.enumerated() {
            print("\(i + 1)번째 게임: 총 \(count)번의 도전 끝에 3스트라이크! 💫")
        }
    }
    
    // 게임 종료용
    func endGame() {
        records.append(trialCount)
        trialCount = 0
    }
}
