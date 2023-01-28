
import Foundation
import UIKit

// MARK: Add & Build varible [from JSON-file]

struct HeroStats:Decodable {
    
    let localized_name: String
    let primary_attr:   String
    let attack_type:    String
    let img :          String
    let legs:          Int
}
