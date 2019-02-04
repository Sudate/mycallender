import Foundation
import RealmSwift

class Event: Object {
    
    @objc dynamic var date: String = ""
    @objc dynamic var FoodExpense: String = "0"
    @objc dynamic var EntertainmentExpenses: String = "0"
    @objc dynamic var event: String = "0"
    override static func primaryKey() -> String? {
        return "date"
        }
    
}
