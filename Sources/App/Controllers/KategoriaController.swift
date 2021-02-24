import Fluent
import Vapor

struct KategoriaController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let kategorie = routes.grouped("kategoria")
        kategorie.get(use: index)
        kategorie.post(use: create)
        kategorie.group(":kategoriaID") { todo in
            todo.delete(use: delete)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<[Kategoria]> {
        return Kategoria.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Kategoria> {
        let kategoria = try req.content.decode(Kategoria.self)
        return kategoria.save(on: req.db).map { kategoria }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Kategoria.find(req.parameters.get("todoID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
