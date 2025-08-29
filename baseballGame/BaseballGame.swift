//
//  BaseballGame.swift
//  baseballGame
//
//  Created by 변지혜 on 8/26/25.
//

import Foundation

class BaseballGame {
    
    
    func start() {
        
//        let intro: String = "야구게임 시작! ⚾️ 숫자를 3개 입력해주세요."
//        print(intro)
        
        
        // 1,2,3 배열로 두고 스위치로 인덱스 접근해서 그에 맞는 코드 실행시키기

        let randomAnswer = makeAnswer()
       // print(randomAnswer)
        
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
                print("2번 실행") // 아직 작동 안 함 (Lv5 추가예정)
            case "3":
                print("3번 실행") // 아직 작동 안 함
            default:
                print("nothing")
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
                    print("정답! 🎉 3 스트라이크!")
                    break
                }
            }
        }
    }
    
    
    // 입력값 받기
    func inputAnswer() -> [Int] {
        if let input = readLine() {
            
            let nums = input.compactMap { Int(String($0)) }
            
            if nums[0] == 0 {
                print("맨 앞자리는 0이될 수 없습니다.")
                return inputAnswer()
            }
            
            if nums.count == 3 {
                print("입력한 숫자 👉 \(nums)")
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
        
        // 인덱스 0번째 자리 0 금지
        while pickNumbers.count == 0 {
            let randomNum = Int.random(in: 1...9)
            pickNumbers.insert(randomNum)
        }
        
        // 나머지 인덱스 숫자 채우기
        while pickNumbers.count < 3 {
            let randomNum = Int.random(in: 0...9)
            pickNumbers.insert(randomNum)
        }
        return Array(pickNumbers)
        
        
    }
    
}

