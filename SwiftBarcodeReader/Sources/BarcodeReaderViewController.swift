import UIKit
import AVFoundation

internal class BarcodeReaderViewController: UIViewController {
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var barBaseView: UIView!

    var scanType: [AVMetadataObjectType]! {
        didSet {
            DMCodeCaptureHandler.shared.metadataObjectTypes = scanType
        }
    }
    
    var needChangePositionButton: Bool = false
    
    private let changePositionButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(BarcodeReaderViewController.onClickedRightBarButton(sender:)))
    }()
    
    private var cameraPosition: AVCaptureDevicePosition = .back
    var successClosure: (( AVMetadataObjectType, String ) -> ())?
    var failureClosure: (( Bool, Error? ) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if needChangePositionButton {
            navigationBar.topItem?.rightBarButtonItem = changePositionButton
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DMCodeCaptureHandler.shared.delegate = self
        startCodeCapture(position: cameraPosition, captureType: scanType)
        view.bringSubview(toFront: barBaseView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onClickedLeftBarButton(sender: UIBarButtonItem) {
        endCodeCapture()
        if failureClosure != nil { failureClosure!(true, nil) }
       dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func onClickedRightBarButton(sender: UIBarButtonItem) {
        cameraPosition = (cameraPosition == .front) ? .back : .front
        switchCamera(to: cameraPosition)
    }
}

extension BarcodeReaderViewController: DMCodeCaptureDelegate{
    func codeCapture(handler: DMCodeCaptureHandler, didCapture type: AVMetadataObjectType, value: String?) {
        endCodeCapture()
        if successClosure != nil { successClosure!(type, value!) }
        
        dismiss(animated: true, completion: nil)
    }
}
