import UIKit

// Structure: 구조체, 관계가 있는 것들을 묶어서 표현함
// 예제 : 편의점 3사에 대한 정보를 구조체로 만드시오
// 1사분면 위에 편의점 위치정보 포함

//좌표값들을 구조체로 묶기
struct Location {
    let x: Int
    let y: Int
}

struct Store {
    let loc: Location
    let name: String
    let deliveryRange = 2.0
    
    func isDeliverbleToMyLoc(userLoc: Location) -> Bool {
        let distanceToStore = distance(current: userLoc, target: loc)
        return distanceToStore < deliveryRange
    }
}
// 각 변수 안에 흩어진 정보를 묶어서 의미단위로 편성할 수 있음
/* 단순 정보의 나열에서 데이터가 가진 의미를 묶고 관계성을 갖는 형태로 구성 및 표현
 let store1 = (x: 3, y: 5, name: "CU")
 let store2 = (x: 4, y: 6, name: "GS25")
 let store3 = (x: 1, y: 7, name: "SevenEleven")
 
 */
// store1-3 변수들은 파라미터가 3개에서 2개가 됨
let store1 = Store(loc: Location(x: 3, y: 5), name: "CU")
let store2 = Store(loc: Location(x: 4, y: 6), name: "GS25")
let store3 = Store(loc: Location(x: 1, y: 7), name: "SevenEleven")

// 각 편의점 간 거리를 구하는 함수 (삼각함수)
//---수정: 좌표를 받는 파라미터를 구조체 Location으로 변경
func distance (current: Location, target: Location) -> Double {
    let distanceX = Double(target.x - current.x)
    let distanceY = Double(target.y - current.y)
    //피타고라스의 정리 a2+b2=C2
    let distance = sqrt(distanceX * distanceX + distanceY * distanceY)
    return distance
}

// 현재 내 위치에서 가장 가까운 편의점을 찾아주는 함수
// 내 위치를 받아서 distance 함수를 사용해 계산한 후 가장 가까운 값을 찾아 출력


func printNearbyCVS (currentLocation: Location, CVSData: [Store]) {
    // 구조체 Store에 store1-3을 넣었기 때문에 CVSData는 Store로 튜플 구성
 
    var nearbyCVSName = ""
    var nearbyCVSDistance =  Double.infinity
    var isDeliverble = false
    
    
    for CVS in CVSData {
        let distanceToCVS = distance(current: currentLocation, target: CVS.loc)
        nearbyCVSDistance = min(distanceToCVS, nearbyCVSDistance)
        if nearbyCVSDistance == distanceToCVS {
            nearbyCVSName = CVS.name
            isDeliverble = CVS.isDeliverbleToMyLoc(userLoc: currentLocation)
        }
    }
    print("가장 가까운 편의점은 \(nearbyCVSName) 입니다.")
    print("거리값 \(nearbyCVSDistance)")
    if isDeliverble == false {
        print("현재 위치까지는 배달이 불가합니다.")
    } else {
        print("현재 위치까지 배달 가능합니다.")
    }
}

let myLocation = Location(x: 3, y: 6)
let stores = [store1, store2, store3]

printNearbyCVS(currentLocation: myLocation, CVSData: stores)
