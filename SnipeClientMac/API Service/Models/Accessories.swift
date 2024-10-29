struct AccessoriesResponse: Codable {
    let total: Int
    let rows: [Accessory]
}

struct Accessory: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let image: String?
    let company: AccessoryCompany?
    let manufacturer: AccessoryManufacturer?
    let supplier: AccessorySupplier?
    let modelNumber: String?
    let category: AccessoryCategory?
    let location: AccessoryLocation?
    let notes: String?
    let qty: Int?
    let purchaseDate: AccessoryDateInfo? // Optional to handle null
    let purchaseCost: String?
    let orderNumber: String?
    let minQty: Int?
    let remainingQty: Int?
    let usersCount: Int?
    let createdAt: AccessoryDateInfo?
    let updatedAt: AccessoryDateInfo?
    let availableActions: AccessoryAvailableActions?
    let userCanCheckout: Bool?
    
    enum CodingKeys: String, CodingKey, Equatable {
        case id, name, image, company, manufacturer, supplier
        case modelNumber = "model_number"
        case category, location, notes, qty
        case purchaseDate = "purchase_date"
        case purchaseCost = "purchase_cost"
        case orderNumber = "order_number"
        case minQty = "min_qty"
        case remainingQty = "remaining_qty"
        case usersCount = "users_count"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case availableActions = "available_actions"
        case userCanCheckout = "user_can_checkout"
    }
}

struct AccessoryCompany: Codable, Equatable {
    let id: Int?
    let name: String?
}

struct AccessoryManufacturer: Codable, Equatable {
    let id: Int?
    let name: String?
}

struct AccessorySupplier: Codable, Equatable {
    let id: Int?
    let name: String?
}

struct AccessoryCategory: Codable, Equatable {
    let id: Int?
    let name: String?
}

struct AccessoryLocation: Codable, Equatable {
    let id: Int?
    let name: String?
}

struct AccessoryDateInfo: Codable, Equatable {
    let datetime: String?
    let formatted: String?
}

struct AccessoryAvailableActions: Codable, Equatable {
    let checkout: Bool
    let checkin: Bool
    let update: Bool
    let delete: Bool
    let clone: Bool
}
