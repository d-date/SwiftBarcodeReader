import UIKit
import AVFoundation

protocol DMCodeCaptureDelegate {
    func codeCapture(handler: DMCodeCaptureHandler, didCapture type:AVMetadataObjectType, value: String?)
}

class DMCodeCaptureHandler: NSObject {
    static let shared = DMCodeCaptureHandler()
    var session = AVCaptureSession()
    var delegate: DMCodeCaptureDelegate?
    var metadataObjectTypes: [AVMetadataObjectType]!
    private var currentInput: AVCaptureDeviceInput?
    
    private override init(){}
        
    func prepareCaptureSession(position: AVCaptureDevicePosition) {
        prepareInputDevice(position: position)
        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        guard session.canAddOutput(output) else{
            print("cannot add Output")
            return
        }
        session.addOutput(output)
        print("available types:\(output.availableMetadataObjectTypes)")
        output.metadataObjectTypes = metadataObjectTypes.map{ return $0.stringValue }
        print("metadata object types:\(output.metadataObjectTypes!)")
    }
    
    func switchInputDevice(for position: AVCaptureDevicePosition) {
        session.beginConfiguration()
        if session.inputs.count > 0 { session.removeInput(currentInput) }
        prepareInputDevice(position: position)
        session.commitConfiguration()
    }
    
    func prepareInputDevice(position: AVCaptureDevicePosition) {
        
        let devices = AVCaptureDevice.devices() as! [AVCaptureDevice]
        var device: AVCaptureDevice? = devices.filter({ $0.position == position }).first! as AVCaptureDevice
        
        if device == nil {
            device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
            print("set default device")
        }
        
        do {
            currentInput = try AVCaptureDeviceInput(device: device)
        } catch {
            fatalError("Could not create capture device input.")
        }
        
        guard session.canAddInput(currentInput) else {
            fatalError("Could not add capture device input.")
        }
        session.addInput(currentInput)
    }
}

extension DMCodeCaptureHandler: AVCaptureMetadataOutputObjectsDelegate {
    internal func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        for data: AVMetadataObject in metadataObjects as! [AVMetadataObject] {
            
            guard data.isKind(of: AVMetadataMachineReadableCodeObject.self) else { return }
            let readableValue: String = (data as! AVMetadataMachineReadableCodeObject).stringValue
            
            guard let type = AVMetadataObjectType(data.type) else { return }
            
            if delegate != nil {
                delegate!.codeCapture(handler: self, didCapture: type, value: readableValue)
            }
        }
    }
}
