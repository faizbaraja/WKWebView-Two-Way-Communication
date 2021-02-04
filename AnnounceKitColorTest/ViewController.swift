//
//  ViewController.swift
//  AnnounceKitColorTest
//
//  Created by Faiz on 04/02/2021.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    @IBOutlet var colorControlButton:UIButton!
    @IBOutlet var webContainerView:UIView!
    lazy var colorTestWebView:WKWebView = WKWebView()
    
    let pageURL = URL(string: "https://s3.eknkc.com/x/2021/02/04/colortest.html")!
    let colorChangeHandlerName = "listenColorChange"
    let colorChangeControlMethod = "window.toggleRun()"
        
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        colorControlButton.setTitleColor(.white, for: .normal)
        colorControlButton.setTitle("Pause / Resume", for: .normal)
        colorControlButton.addTarget(self, action: #selector(changeWebColor), for: .touchUpInside)
        
        setupWebView()
    }
    
    private func setupWebView() {
        let contentController = WKUserContentController();
        contentController.add(self, name: colorChangeHandlerName)
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        colorTestWebView = WKWebView(frame: webContainerView.bounds, configuration: config)
        colorTestWebView.navigationDelegate = self
        webContainerView.addSubview(colorTestWebView)
        colorTestWebView.translatesAutoresizingMaskIntoConstraints = false
        colorTestWebView.pinToSuperView()
        
        colorTestWebView.load(URLRequest(url: pageURL))
    }
    
    @objc private func changeWebColor() {
        colorTestWebView.evaluateJavaScript(colorChangeControlMethod, completionHandler: nil)
    }

}

extension ViewController:WKScriptMessageHandler, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("""
                window.listenColorChange(function(color) {
                    window.webkit.messageHandlers.\(colorChangeHandlerName).postMessage(color)
                });
                """, completionHandler: nil)
    }
    
   func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == colorChangeHandlerName, let hexColor = message.body as? String {
            print("color \(hexColor)")
            colorControlButton.backgroundColor = UIColor(hexString: hexColor)
        }
    }
}
