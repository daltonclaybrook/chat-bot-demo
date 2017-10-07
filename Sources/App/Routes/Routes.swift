import Vapor

extension Droplet {
    func setupRoutes() throws {
        let intent = IntentController()
        post("intent", handler: intent.handleRequest)
    }
}
