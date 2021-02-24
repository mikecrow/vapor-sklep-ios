import Fluent

struct CreateProdukt: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("produkt")
            .id()
            .field("title", .string, .required)
            .field("description", .string, .required)
            .field("image", .string, .required)
            .field("quantity", .int, .required)
            .field("kategoria_id", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("produkt").delete()
    }
}
