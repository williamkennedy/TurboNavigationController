import Turbo
import TurboNavigator
import UIKit
import WebKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene
        else { fatalError("Expected a UIWindowScene.") }

        createWindow(in: windowScene)
    }

    // MARK: - Private

    private let baseURL = URL(string: "http://localhost:3000")!
    private lazy var turboNavigator = TurboNavigator(delegate: self, pathConfiguration: pathConfiguration)
    private lazy var pathConfiguration = PathConfiguration(sources: [
        .server(baseURL.appendingPathComponent("/configuration"))
    ])

    private func createWindow(in windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        window.backgroundColor = .white
        self.window = window

        window.makeKeyAndVisible()
        window.rootViewController = turboNavigator.rootViewController

        turboNavigator.route(baseURL)
    }
}

extension SceneDelegate: TurboNavigationDelegate {}
