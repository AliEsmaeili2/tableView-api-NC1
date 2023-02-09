
import Foundation
import UIKit

// MARK: Add important varible [from API]

struct Hero: Decodable {
    
    let localized_name : String
    let img :           String
    var primary_attr :   String
    let attack_type :    String
    let roles :         [String]
}
