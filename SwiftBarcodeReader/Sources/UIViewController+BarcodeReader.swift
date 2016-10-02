import UIKit
import AVFoundation

private var AssociationKey: UInt8 = 0
public extension UIViewController {
    var layer: AVCaptureVideoPreviewLayer! {
        get {
            return objc_getAssociatedObject(self, &AssociationKey) as? AVCaptureVideoPreviewLayer
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    //MARK: - Private
    private func addDeviceOrientationChangeNotification() {
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.onChangedOrientation), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    private func removeDeviceOrientationChangeNotification() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
    }
    
    @objc private func onChangedOrientation() {
        setDeviceOrientation(orientation: UIDevice.current.orientation)
    }
    
    private func setDeviceOrientation(orientation: UIDeviceOrientation) {
        
        if (orientation == .landscapeLeft) || (orientation == .landscapeRight) {
            layer.connection.videoOrientation = captureVideoOrientation(deviceOrientation: orientation)
        } else {
            layer.connection.videoOrientation = captureVideoOrientation(deviceOrientation: orientation)
        }
    }
    
    private func captureVideoOrientation(deviceOrientation: UIDeviceOrientation) -> AVCaptureVideoOrientation {
        var orientation: AVCaptureVideoOrientation
        switch deviceOrientation {
        case .portraitUpsideDown:   orientation = .portraitUpsideDown
        case .landscapeLeft:        orientation = .landscapeRight
        case .landscapeRight:       orientation = .landscapeLeft
        default:                    orientation = .portrait
        }
        return orientation
    }
    
    //MARK: - Public
    func presentBarcodeReader(scanTypes: [AVMetadataObjectType],
                              needChangePositionButton: Bool,
                              success: ((_ type:AVMetadataObjectType, _ value: String) -> ())?,
                              failure: @escaping ((_ cancel: Bool, _ error: Error?) -> ())) {
        let bundle = Bundle(identifier: "SBRResource")
        let storyboard = UIStoryboard(name: "BarcodeReader", bundle: bundle)
        let vc: BarcodeReaderViewController = storyboard.instantiateInitialViewController() as! BarcodeReaderViewController
        vc.successClosure = success
        vc.failureClosure = failure
        vc.scanType = scanTypes
        vc.needChangePositionButton = needChangePositionButton
        present(vc, animated: true, completion: nil)
    }
    
    func startCodeCapture(position: AVCaptureDevicePosition, captureType: [AVMetadataObjectType]) {
        addDeviceOrientationChangeNotification()
        if DMCodeCaptureHandler.shared.session.outputs.count == 0 {
            DMCodeCaptureHandler.shared.prepareCaptureSession(position: position)
        }
        layer = AVCaptureVideoPreviewLayer(session: DMCodeCaptureHandler.shared.session)
        layer.frame = view.bounds
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill
        setDeviceOrientation(orientation: UIDevice.current.orientation)
        view.layer.addSublayer(layer)
        DMCodeCaptureHandler.shared.session.startRunning()
    }
    
    func switchCamera(to position: AVCaptureDevicePosition) {
        DMCodeCaptureHandler.shared.switchInputDevice(for: position)
    }
    
    func endCodeCapture() {
        DMCodeCaptureHandler.shared.session.stopRunning()
        removeDeviceOrientationChangeNotification()
    }
}
