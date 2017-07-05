import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputField: UITextField!
    private let defaults = UserDefaults.standard
    private let previous = "previous"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let previousInput = defaults.string(forKey: previous) else { return }
        inputField.text = previousInput
    }
    
    @IBAction func doStuff() {
        let sharedApp = UIApplication.shared
        
        guard let userInput = inputField.text, let urlString = URL(string:userInput) else {
            defaults.set("", forKey: previous)
            defaults.synchronize()
            return
        }
        
        if #available(iOS 10.0, *) {
            sharedApp.open(urlString, options: [:], completionHandler: nil)
        } else {
            sharedApp.openURL(urlString)
        }
        
        defaults.set(userInput, forKey: previous)
        defaults.synchronize()
        inputField.resignFirstResponder()
    }
}
