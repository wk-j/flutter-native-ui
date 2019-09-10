import UIKit
import Flutter
import WebKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    let nativeViewFactory = FluffViewFactory()
    let pdfViewFactory = QPdfViewFactory()
    
    let plugin = registrar(forPlugin: "Runner")
    
    plugin.register(nativeViewFactory, withId: "FluffView")
    plugin.register(pdfViewFactory, withId: "PdfView")
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

public class QPdfViewFactory: NSObject, FlutterPlatformViewFactory {
    public func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
        ) -> FlutterPlatformView {
        
        return QPdfView(frame, viewId: viewId, args: args)
    }
}

public class QPdfView: NSObject, FlutterPlatformView {
    let frame: CGRect
    let viewId: Int64
    
    init(_ frame: CGRect, viewId: Int64, args: Any?) {
        self.frame = frame
        self.viewId = viewId
    }
    public func view() -> UIView {
        let url = Bundle.main.url(forResource: "tesla", withExtension: "pdf")
        guard let x = url else {
            return UISlider(frame: frame)
        }
        let webView = WKWebView(frame:  frame)
        let urlRequest = URLRequest(url: x)
        webView.load(urlRequest)
        return webView;
    }
}



