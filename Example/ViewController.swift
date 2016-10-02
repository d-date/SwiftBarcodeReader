import UIKit
import SwiftBarcodeReader

class ViewController: UIViewController {

    @IBOutlet weak var showReaderButton: UIButton!{
        didSet{
            showReaderButton.addTarget(self, action: #selector(onSelectedShowReader), for: .touchUpInside)
        }
    }
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func onSelectedShowReader(){
        presentBarcodeReader(scanTypes: [.EAN13Code],
                             needChangePositionButton: true,
                             success: {[unowned self] (type, value) in
            print("type:\(type) value:\(value)")
            self.resultLabel.text = "\(value)"

        }) {(canceled, error) in
            
            //cancel handler when tapped back button
            if canceled {
                print("canceled")
            }
            
            //error handler when occured some error
            if error != nil {
                print("error:\(error)")
            }
        }
    }

}

