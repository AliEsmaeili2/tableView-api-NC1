
import Foundation
import UIKit

// MARK: Add & Build varible [from JSON-file]

struct HeroStats:Decodable {
    
    let localized_name : String
    let primary_attr :   String
    let attack_type :    String
    let img :           String
    let attack_range :   Int
    let move_speed :     Int
    let base_health :    Int
    let base_mana :      Int
    let base_str :       Int
    let base_agi :       Int
    let base_int :       Int
    let base_attack_min : Int
    let base_attack_max : Int
    
}
