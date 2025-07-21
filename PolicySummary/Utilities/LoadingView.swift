
import UIKit

class LoadingView: UIView {

    static let shared = LoadingView()
    private let activityView = UIActivityIndicatorView(style: .medium)
    private let backgroundView = UIView(frame: UIScreen.main.bounds)

    private override init(frame: CGRect) {
        super.init(frame: frame)

        activityView.backgroundColor = Theme.lightRed.withAlphaComponent(0.8)
        activityView.frame.size = CGSize(width: 60, height: 60)
        activityView.layer.cornerRadius = 7
        activityView.center = backgroundView.center
        activityView.startAnimating()
        activityView.color = Theme.pureWhite

        backgroundView.backgroundColor = Theme.darkBlue.withAlphaComponent(0.1)
        backgroundView.addSubview(activityView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func topMostViewController() -> UIViewController? {
        guard let keyWindow = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow }) else { return nil }

        var topController = keyWindow.rootViewController
        while let presentedVC = topController?.presentedViewController {
            topController = presentedVC
        }
        return topController
    }

    func start() {
        DispatchQueue.main.async {
            guard let topVC = self.topMostViewController() else { return }
            self.backgroundView.frame = topVC.view.bounds
            topVC.view.addSubview(self.backgroundView)
        }
    }

    func stop() {
        DispatchQueue.main.async {
            self.backgroundView.removeFromSuperview()
        }
    }
}
