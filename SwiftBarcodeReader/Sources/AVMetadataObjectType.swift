import Foundation
import AVFoundation

public enum AVMetadataObjectType {
    case UPCECode
    case Code39Code
    case Code39Mod43Code
    case EAN13Code
    case EAN8Code
    case Code93Code
    case Code128Code
    case PDF417Code
    case QRCode
    case AztecCode
    case Interleaved2of5Code
    case ITF14Code
    case DataMatrixCode
    
    init?(_ type: String){
        switch type {
        case AVMetadataObjectTypeUPCECode:              self = .UPCECode
        case AVMetadataObjectTypeCode39Code:            self = .Code39Code
        case AVMetadataObjectTypeCode39Mod43Code:       self = .Code39Mod43Code
        case AVMetadataObjectTypeEAN13Code:             self = .EAN13Code
        case AVMetadataObjectTypeEAN8Code:              self = .EAN8Code
        case AVMetadataObjectTypeCode93Code:            self = .Code93Code
        case AVMetadataObjectTypeCode128Code:           self = .Code128Code
        case AVMetadataObjectTypePDF417Code:            self = .PDF417Code
        case AVMetadataObjectTypeQRCode:                self = .QRCode
        case AVMetadataObjectTypeAztecCode:             self = .AztecCode
        case AVMetadataObjectTypeInterleaved2of5Code:   self = .Interleaved2of5Code
        case AVMetadataObjectTypeITF14Code:             self = .ITF14Code
        case AVMetadataObjectTypeDataMatrixCode:        self = .DataMatrixCode
        default: return nil
        }
    }
    
    var stringValue: String {
        switch self {
        case .UPCECode:             return AVMetadataObjectTypeUPCECode
        case .Code39Code:           return AVMetadataObjectTypeCode39Code
        case .Code39Mod43Code:      return AVMetadataObjectTypeCode39Mod43Code
        case .EAN13Code:            return AVMetadataObjectTypeEAN13Code
        case .EAN8Code:             return AVMetadataObjectTypeEAN8Code
        case .Code93Code:           return AVMetadataObjectTypeCode93Code
        case .Code128Code:          return AVMetadataObjectTypeCode128Code
        case .PDF417Code:           return AVMetadataObjectTypePDF417Code
        case .QRCode:               return AVMetadataObjectTypeQRCode
        case .AztecCode:            return AVMetadataObjectTypeAztecCode
        case .Interleaved2of5Code:  return AVMetadataObjectTypeInterleaved2of5Code
        case .ITF14Code:            return AVMetadataObjectTypeITF14Code
        case .DataMatrixCode:       return AVMetadataObjectTypeDataMatrixCode
        }
    }
}
