//
//  BaseballGame.swift
//  baseballGame
//
//  Created by 변지혜 on 8/26/25.
//

import Foundation

class BaseballGame {
    
    
    func start() {
        let intro: String = "야구게임 시작! ⚾️ 숫자를 3개 입력해주세요."
        print(intro)
        
        
        let randomAnswer = makeAnswer()
        
        while true {
            let userAnswer = inputAnswer()
            var strike = 0 // 스트라이크용 변수
            var ball = 0 // 볼용 변수

            for i in 0..<userAnswer.count {
                // 같은자리, 같은 숫자 카운트
                if userAnswer[i] == randomAnswer[i] {
                    strike += 1
                    
                // 다른자리의 숫자 카운트
                } else if randomAnswer.contains(userAnswer[i]) {
                    ball += 1
                }
            }
      
            
            // 결과 출력 조건문. 개수로 계산하여 0일 경우 Nothig, 0보다 클 경우 나머지
            
            if strike == 0 && ball == 0 {
                print("실패! Nothing 🥲")
            } else if strike > 0 && ball == 0 {
                print("\(strike) 스트라이크!")
            } else if strike == 0 && ball > 0 {
                print("\(ball)볼!")
            } else {
                print("\(strike)스트라이크 \(ball)볼 🔥")
            }
            
            // 3 스트라이크 시 조건문 탈출
            if strike == 3 {
                print("정답! 🎉 3 스트라이크!")
                break
            }
        }
    }
    
    // 입력값 받기
    func inputAnswer() -> [Int] {
        if let input = readLine() {
            let nums = input.compactMap { Int(String($0)) }
            
            if nums.count == 3 {
                print("입력한 숫자 👉 \(nums)")
               // _ = makeAnswer()
                return nums
            } else {
                print("숫자를 다시 입력해주세요. 세 개의 숫자만 가능합니다. 🥲")
                return inputAnswer()
            }
        }
        return []
    }
    
    // 랜덤 숫자 출력
    func makeAnswer() -> [Int] {
        var pickNumbers: Set<Int> = []
        
        while pickNumbers.count < 3 {
            let randomNum = Int.random(in: 1...9)
            pickNumbers.insert(randomNum)
        }
        return Array(pickNumbers)
    }
    
}

