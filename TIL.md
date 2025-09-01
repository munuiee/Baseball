# ch 2. 프로그래밍 심화 주차 과제

## Swift로 야구게임 만들기

### 개발 환경

Xcode Command Line Tool

### 트러블 슈팅
👇 개발 과정 중 내가 만난 이슈들
[Baseball project](https://github.com/users/munuiee/projects/2)



<br>

## 필수 구현 기능 가이드

### Lv1 (-0826 완료)

- 1에서 9까지의 서로 다른 임의의 수 3개를 정하고 맞추는 게임입니다.
- 정답은 랜덤으로 만듭니다. (1에서 9까지의 서로 다른 임의의 수 3자리)

---

파트별로 나눠서 구현할 방법을 생각해보았다.

✅ 1에서 9까지의 숫자 중 서로 다른 임의의 수 3개 출력 → 반복문 사용하기, 출력 후 3개 배열로 묶기(배열로 묶어야 인덱스 비교가 가능할 듯하다.)

✅ 정답은 랜덤으로 → `Int.random(in:)`

우선 1에서 9까지의 수를 뽑으려면 반복문을 써야 한다고 판단을 했다. 숫자 뽑는 데엔 for문을 주로 써왔는데 내가 이제껏 쓴 for문은 1씩 증가되며 하나의 숫자만 출력하는 것이었다. 

그런데 이번 조건은 3개의 숫자를 출력해야 한다. 랜덤 출력은 `Int.random(in:)` 으로 할 거라, 3개까지만 출력이 반복될 수 있는 조건만 정해주면 되지 않을까 싶었다. 그리고 서로 다른 임의의 수를 출력해야 하기 때문에 중복되지 않은 수가 출력될 때까지 반복을 해주고 싶었다.

그래서 생각해낸 것은 `while문`

반복 횟수가 정해져 있지 않고 특정 조건이 참일 동안 반복할 때 사용하는 코드이다. 사용자가 특정 조건을 만족하거나, 게임의 메인 루프처럼 계속 실행해야 할 때 많이 사용한다고 한다.

이런식으로 방향은 정했으나 어떻게 틀을 잡아야할지 어려웠다. 아직 구조를 잡는 게 어렵게 느껴져서 힌트를 참고하였다.

<br>

```swift
// main.swift 파일
// 프로젝트 생성시 자동 생성됨

let game = BaseballGame()
game.start() // BaseballGame 인스턴스를 만들고 start 함수를 구현하기


// BaseballGame.swift 파일 생성
class 혹은 struct {
	func start() {
		let answer = makeAnswer() // 정답을 만드는 함수
	}
	
	func makeAnswer() -> Int {
		// 함수 내부를 구현하기
	}
}
```

<br>

Class를 써서 코드를 구현하기로 하였다. `makeAnswer()`에 랜덤 숫자 출력 코드를 넣었다.

```swift
func makeAnswer() -> [Int]
```

우선 내 목표는 랜덤값이 출력될 때 배열로 출력되는 것이다. 그래야 카운트 코드를 써서 사용자가 입력한 수와 컴퓨터가 랜덤으로 출력한 수가 일치하는지 확인할 수 있을 것 같았기 때문이다. 

사용자가 입력한 수를 담는 변수를 `pickNumbers`로 칭하였다.

```swift
var pickNumbers: Set<Int> = []
```
중복을 막기 위해 `Set`을 사용하였다.  


<br>

```swift
while pickNumbers.count < 3 {
	let randomNum = Int.random(in: 1...9)
	pickNumbers.insert(randomNum)
}
return Array(pickNumbers)
```
배열을 세는 `.count` 코드를 사용하여 `pickNumbers`가 세 개 미만일 때 `Int.random`이 1에서 9까지의 숫자의 출력을 반복한다. 


<br>
<br>

### Lv2. (-0828 완료)

- 정답을 맞추기 위해 3자리수를 입력하고 힌트를 받습니다.
    - 힌트는 야구용어인 볼과 스트라이크입니다.
    - 같은 자리에 같은 숫자가 있는 경우 스트라이크, 다른 자리에 숫자가 있는 경우 볼입니다.
    - 만약 올바르지 않은 입력값에 대해서는 오류 문구를 보여주세요.
- 3자리 숫자가 정답과 같은 경우 게임이 종료됩니다.

---
인덱스, 숫자가 전부 일치해야 하므로 사용자 입력값도 배열로 받기로 했다. 입력값 받는 함수는 `inputAnswer()`

```swift
func inputAnswer() -> [Int] {
    if let input = readLine() {
       let nums = input.compactMap { Int(String($0)) }
            
         // 개수가 3개일 때 출력한다.
         if nums.count == 3 {
            print("입력한 숫자: \(nums)")
            _ = makeAnswer()
            return nums
         } else {
            print("숫자를 다시 입력해주세요. 세 개의 숫자만 가능합니다.")
            return inputAnswer()
         }
     }
     return []
 }
```

입력은 `readLine()`을 사용했다. `readLine()` 자체가 옵셔널이라 `if let` 으로 안전하게 옵셔널 언래핑을 해주었다. 

우선 사용자가 입력할 값은 Int로 해주고 입력값이 들어오면서 배열로 바꿔주고 싶었다. `readLine()`은 String으로 한 번 변환 후 Int로 변환이 된다 한다. 구글링을 해서 `compactMap { Int(String($0)) }` 이 코드를 알아냈다. 이 또한 옵셔널이라 `map`으로 하게되면 Optional 상태로 반환이 되어, `compactMap` 을 사용해서 nil 제거 및 옵셔널 바인딩 처리를 해주었다.

<br>

> 사용자가 0을 입력하는 경우
 

```swift
// 사용자가 0을 입력하는 경우
if nums.contains(0) {
     print("0은 입력될 수 없습니다.")
     return inputAnswer()
}

// 중복 제거 및 숫자 3개인 경우에만 출력
if nums.count == 3 && Set(nums).count == 3{
 print("입력한 숫자 👉 \(nums)")
 _ = recordManager.add()
 return nums
```

요구사항 중에 ‘사용자가 0을 입력하는 경우’와 ‘사용자가 중복값을 입력하는 경우’에 대한 코드 구현을 빼먹었다는 걸 알게되었다.

코드리뷰를 통해서 팀원분 코드를 공부하며 비슷하게 구현해보았다!

---

배열끼리 비교하는 코드를 만들면서 굉장히 오랜 시간을 쏟았다. `for문`과 `.count`를 이용해서 비교하는 것까지는 생각했으나 이걸 코드로 구현하는 게 너무 어려웠다!!

힌트에 `while true`가 있길래 이게 어떤 건가 싶어 검색을 해봤더니 조건이 참인 경우에만 무한 반복하는 코드라고 한다. 이 힌트를 사용해보기로했다. 🤓

```swift
func start() {
        let intro: String = "숫자를 입력하세요"
        print(intro)
        //let userAnswer = inputAnswer() // 리턴값 없는 경우엔 상수 선언 안 해줘도 됨!
        
        
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
                print("Nothing")
            } else if strike > 0 && ball == 0 {
                print("\(strike)스트라이크")
            } else if strike == 0 && ball > 0 {
                print("\(ball)볼")
            } else {
                print("\(strike)스트라이크 \(ball)볼")
            }
        }
    }
```


`for문` 으로 배열을 비교하기로 했다. 이때 `contains` 는 랜덤값에 사용자 입력값과 같은 숫자가 들어있나 보는 것인데, 자리까지 확인하지 않고 같은 숫자의 존재 유무만 확인하여 볼을 출력한다.

출력값은 조건문을 통해 출력된다. 

- `if strike == 0 && ball == 0` → 반복문을 통해 확인된 수가 둘 다 0일 때

- `else if strike > 0 && ball == 0` → 스트라이크가 0 이상, 볼이 0일 때

- `else if strike == 0 && ball > 0` → 스트라이크가 0, 볼이 0 이상일 때

- `else` → 스트라이크가 0 이상, 볼이 0 이상일 때

<br>

```swift
if strike == 3 {
    print("정답! 🎉 3 스트라이크!")
    break
}
```

보니까 조건문에 `break`를 안 썼다는 것을 알게 되었다.. 3 스트라이크가 나오면 종료가 되어야 하는데 내 코드는 계속 돌아가고 있었다. 3 스트라이크용 조건문을 따로 넣어주고 3 스트라이크 시 바로 조건문을 빠져나가게 수정했다.

```swift
 if nums.count == 3 {
      print("입력한 숫자 👉 \(nums)")
      // _ = makeAnswer()
      return nums
```

`start()` 함수 안에 `makeAnswer()`이 있으므로 두 번 호출되지 않도록 조건문에서 호출문을 제거했다.

<br>
<br>

### Lv3.

- 정답이 되는 숫자를 0에서 9까지의 서로 다른 3자리의 숫자로 바꿔주세요.
- 맨 앞자리에 0이 오는 것은 불가능합니다.
    - 092 → 불가능
    - 870 → 가능
    - 300 → 불가능
 
---

```swift
 // makeAnswer()
while pickNumbers.count == 0 {
  let randomNum = Int.random(in: 1...9)
  pickNumbers.insert(randomNum)
}
```
<br>

‼️ 테스트를했을 때 0으로 시작하는 랜덤값이 나오는 상황이 발생했다.

```swift
while pickNumbers.first == 0
```

이렇게 변경했다. 근데 이렇게 했는데도 자꾸 0이 나온다.

이유는 `Set`이 순서가 없는 값이라서 그렇다고 한다. 그래서 `puckNumbers`를 배열로 바꾸고 0이 있다면 지우는 방식으로 바꿨다.

<br>

```swift
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
```


<br>

```swift
// inputAnswer()
 if nums.first == 0 {
    print("앞자리에 0은 입력될 수 없습니다.")
    return inputAnswer()
}

```
첫 번째 자리에만 1-9까지 숫자 출력, 나머지는 전부 0-9까지 출력하는 코드를 만들어주었다. 

그리고 사용자가 맨 처음 0을 입력하는 것을 방지하기 위해 `inputAnswer()` 에도 코드 추가

<br>
<br>

### Lv4.
- 프로그램을 시작할 때 안내문구를 보여주세요.

```swift
// 예시
환영합니다! 원하시는 번호를 입력해주세요
1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기
```

- 1번 ‘게임 시작하기’의 경우 ‘필수 구현 기능’의 예시처럼 게임이 진행됩니다.
    - 정답을 맞혀 게임이 종료된 경우 위 안내문구를 다시 보여주세요.

```swift
// 예시
환영합니다! 원하시는 번호를 입력해주세요
1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기
1 // 1번 게임 시작하기 입력

< 게임을 시작합니다 >
숫자를 입력하세요
.
.
.
```

---

1, 2, 3을 배열로 두고 Switch문으로 인덱스에 접근해서 그에 맞는 코드를 실행시키려 했으나 배열 인덱스에 접근하는 방식이 꽤나 복잡해서 또 한참을 고민했었다. 그리고 결국 숫자를 문자열로 사용하기로 했다.

```swift
 while true {
            let introMent: String = """
                환영합니다! 원하시는 번호를 입력해주세요.
                1. 게임 시작하기 2. 게임 기록 보기 3. 종료하기
                """
            print(introMent)
            let userSelect = readLine()
            
            switch userSelect {
            case "1":
                print("야구게임 시작! ⚾️ 숫자를 3개 입력해주세요.")
            case "2":
                print("2번 실행")
            case "3":
                print("3번 실행")
            default:
                print("nothing")
            }
            break
        }
```

<br>

여기서 하나의 문제가 발생한다. 3 스트라이크로 조건문에서 탈출하면 다시 `introMent` 가 출력이 되어야 하는데, 지금 이 코드로는 방법을 못 찾았다. 

1. 원래 결과 출력을 위해 존재하던 `while true`에 위의 코드를 넣어보았다. 바로 `introMent`가 나오긴 하지만, 게임이 딱 한 번 밖에 진행이 되지 않았다. 
2. `while true`를 하나 더 만들어서 결과 출력 `while true` 를 감싸주었다. 중첩 while문을 만들어주니 원하던대로 결과가 출력된다!

```swift
while true {
            let introMent: String = """
                환영합니다! 원하시는 번호를 입력해주세요.
                1. 게임 시작하기 2. 게임 기록 보기 3. 종료하기
                """
            print(introMent)
            let userSelect = readLine()
            
            switch userSelect {
            case "1":
                print("야구게임 시작! ⚾️ 숫자를 3개 입력해주세요.")
            case "2":
                print("2번 실행")
            case "3":
                print("3번 실행")
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
```

<br>
<br>

### Lv5.
- 2번 게임 기록 보기의 경우 완료한 게임들에 대해 시도 횟수를 보여줍니다

```swift
// 예시
환영합니다! 원하시는 번호를 입력해주세요
1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기
2 // 2번 게임 기록 보기 입력

< 게임 기록 보기 >
1번째 게임 : 시도 횟수 - 14
2번째 게임 : 시도 횟수 - 9
3번째 게임 : 시도 횟수 - 12
.
.
.
```

---

Class용 파일을 하나 생성하여 `RecordManager`클래스를 만들어주었다.

```swift
// RecordManager.swift
import Foundation

class RecordManager {
    var trialCount: Int = 0// 1회 게임에서의 시도 횟수
    
    func add() -> Int {
        trialCount += 1
        return trialCount
    }
    
    func showRecrods() {
        
    }
}

```

`trialCount`에 기본값을 주고 `add()`함수에 카운팅을 하도록 구현했다.

```swift
var recordManager = RecordManager()
```

`BaseballGame` 파일에 `RecordManager` 파일을 인스턴스로 가져와주었다.

<br>

```swift
if strike == 3 {
  print("""
    정답! 🎉 3 스트라이크!
    게임이 종료되었어요.
    현재 시도 횟수: \(recordManager.trialCount)
  """)
  break
                    
}
```

횟수가 잘 찍히는지 조건문 탈출 전에 출력되도록 시도했다.

<img width="179" height="99" alt="스크린샷 2025-08-29 오후 5 35 07" src="https://github.com/user-attachments/assets/09421d4c-b400-4d18-afbc-f2163111a49f" />


카운팅이 잘 된다!

<br>

```swift
func gameAdd() -> Int {
        gameCount += 1
        return gameCount
    }
    
    
// BaseballGame.swift
case "1":
 print("야구게임 시작! ⚾️ 숫자를 3개 입력해주세요.")
 recordManager.gameAdd()
 print("\(recordManager.gameCount)번째 게임")
```

`gameAdd()` → 게임 횟수 카운팅

출력문이 다시 나올 때마다 카운팅하기 위해 스위치문 안에 적어주었다.


<img width="288" height="144" alt="스크린샷 2025-08-29 오후 7 01 50" src="https://github.com/user-attachments/assets/ce0cd132-a884-4052-86a3-ac7832076f7e" />

<br>

이제 이 둘을 합쳐야하는데 사실 정말 어려웠다. 일단 ‘Swift 누적 저장’ 등등 검색을 하며 알아보았다. 그러다가 `enumerated()` 함수를 알게 되었다. 튜플로 출력을 해주는 건데 각각의 인덱스와 배열값에 접근하는 코드이다.

<br>

```swift
var records: [Int] = []

func showRecords() {
  for (i, count) in records.enumerated() {
  print("\(i + 1)번째 게임: 시도 횟수 - \(count)회")
  }
}
```

이렇게 구현을 해두고 

```swift
 // 게임 종료용
    func endGame() {
        records.append(trialCount)
        trialCount = 0
    }
```
<br>

게임 종료용 함수를 따로 만들어 둘 다 호출해주었다.
이 과정에서 자꾸만 `showRecords` 함수가 실행이 안 돼 호출이 안 되나 싶어 테스트용으로 프린트를 넣고 출력을 해보았다. 결과가 잘 나오는 것으로 보아 호출은 잘 되는 것 같아 원인을 찾아보았더니 `endGame()`을 호출해주지 않았다는 것을 알게되었다. 

`append`를 이용해 `trialCount`를 `records` 에 담고, 게임이 종료되면 초기화하도록 구현하였다.

