
import UIKit

class automaticGate {
    
    enum Station {
        case Tokyo
        case Nagoya
        case Osaka
        case Kyoto
    }
    
    var cardBalance: Int = 100
    var currentStation: Station?
    
    //ここでtrue/falseが返せるように
    func enterGate(from: Station) -> Bool {
        currentStation = from
        if cardBalance < 100 {
            print("残高を100円以上にしてください")
            return false
        } else {
            print("乗車時：残高は\(cardBalance)円です")
            return true
        }
    }
    
    //func exitGate(arrivedat: Station, payment: ticketPrice) -> String {
    func exitGate(arrivedAt: Station) -> String {
        guard let start = currentStation else {
            return "乗車駅の情報がありません。"
        }
        let payment = ticketPrice(start: start, arrived: arrivedAt)
        let shortage = payment - cardBalance
        if cardBalance < payment {
            return "残高が\(shortage)円不足しています。チャージしてください"
        } else {
            cardBalance -= payment
            let startingStationName = whichStation(station: start)
            let arrivingStationName = whichStation(station: arrivedAt)
            return "乗車駅：\(startingStationName) 下車駅：\(arrivingStationName) 運賃：\(payment) 残高\(cardBalance)円"
        }
    }
    
    //運賃の設定
    func ticketPrice(start: Station, arrived: Station) -> Int {
        switch (start, arrived) {
        case (.Tokyo, .Tokyo), (.Nagoya, .Nagoya), (.Osaka, .Osaka), (.Kyoto, .Kyoto):
            print("運賃は0円です。移動していません")
            return 0
        case (.Kyoto, .Tokyo), (.Tokyo, .Kyoto):
            return 300
        case (.Kyoto, .Nagoya), (.Nagoya, .Kyoto):
            return 200
        case (.Kyoto, .Osaka), (.Osaka, .Kyoto):
            return 100
        case (.Osaka, .Tokyo), (.Tokyo, .Osaka):
            return 200
        case (.Osaka, .Nagoya), (.Nagoya, .Osaka), (.Nagoya, .Tokyo), (.Tokyo, .Nagoya):
            return 100
        }
    }
    
    //乗車駅、下車駅を表示させる用
    func whichStation(station: Station) -> String {
        switch station {
        case .Tokyo:
            return "東京"
        case .Nagoya:
            return "名古屋"
        case .Osaka:
            return "大阪"
        case .Kyoto:
            return "京都"
        }
    }
}

let gate = automaticGate()
if gate.enterGate(from: .Tokyo) {
    print(gate.exitGate(arrivedAt: .Osaka))
}

/*
 乗車時：残高は1000円です
 乗車駅：東京 下車駅：大阪 運賃：200 残高800円
 */


