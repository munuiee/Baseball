//
//  BaseballGame.swift
//  baseballGame
//
//  Created by 변지혜 on 8/26/25.
//

import Foundation

class BaseballGame {
    
    var recordManager = RecordManager()
    
    func start() {
        
        let randomAnswer = makeAnswer()
        
        while true {
            let introMent: String = """
                환영합니다!👋 원하시는 번호를 입력해주세요.
                1️⃣ 게임 시작하기 2️⃣ 게임 기록 보기 3️⃣ 종료하기
                """
            print(introMent)
            let userSelect = readLine()
            
            switch userSelect {
            case "1":
                print("야구게임 시작! ⚾️ 숫자를 3개 입력해주세요.")
            case "2":
                print("내 기록 🕹️") 
                recordManager.showRecords()
            case "3":
                print("숫자 야구 게임을 종료합니다.") // Lv6 해결 안 됨
            default:
                print("올바른 숫자를 입력해주세요!")
            }
            
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
                    print("""
                    정답! 🎉 3 스트라이크!
                    게임이 종료되었어요.
                    """)
                    recordManager.endGame()
                    break
                    
                }
            }
        }
    }
    
    
    // 입력값 받기
    func inputAnswer() -> [Int] {
        if let input = readLine() {
            
            let nums = input.compactMap { Int(String($0)) }
            
            if nums.first == 0 {
                print("앞자리에 0은 입력될 수 없습니다.")
                return inputAnswer()
            }
            
            // 중복 제거 및 숫자 3개인 경우만 출력
            if nums.count == 3 && Set(nums).count == 3{
                print("입력한 숫자 👉 \(nums)")
                _ = recordManager.add()
                return nums
            } else {
                print("숫자를 다시 입력해주세요. 중복 제외, 세 개의 숫자만 가능합니다. 🥲")
                return inputAnswer()
            }
            
        }
        return []
    }
    
    
    // 랜덤 숫자 출력
    func makeAnswer() -> [Int] {
        var pickNumbers: Set<Int> = []
        
//        // 인덱스 0번째 자리 0 금지
//        while pickNumbers.first == 0 {
//            let randomNum = Int.random(in: 1...9)
//            pickNumbers.insert(randomNum)
//        }
        
        // 나머지 인덱스 숫자 채우기
        while pickNumbers.count < 3 {
            let randomNum = Int.random(in: 0...9)
            pickNumbers.insert(randomNum)
        }
        var mainNumbers = Array(pickNumbers)
        while mainNumbers.first == 0 {
            pickNumbers.remove(0)
            pickNumbers.insert(Int.random(in: 0...9))
            mainNumbers = Array(pickNumbers)
        }
        
        return mainNumbers
    }
    
}
