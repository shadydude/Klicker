import UIKit

class ClickerViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var labelCount: UILabel!
    @IBOutlet var labelTime: UILabel!
    @IBOutlet var buttonTimer: UIButton!
    
    // MARK: - Properties
    var count: Int = 0
    var timer: Timer?
    var time: Double = 0.0
    
    // MARK: - Overrides
    /// Configures the status bar to change from black (default) to white.
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Functions
    @objc func configureTimer() {
        time += 0.1
        labelTime.text = "\(String(format: "%.1f", time)) seconds"
    }
    
    // MARK: - Actions
    @IBAction func tappedScreen(_ sender: UITapGestureRecognizer) {
        /// Add 1 to the count
        count += 1
        labelCount.text = String(count)
        
        if count == 30 {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBAction func buttonTimer(_ sender: UIButton) {
        /// Configures time
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(configureTimer), userInfo: nil, repeats: true)
        
        /// Disables buttonTimer
        buttonTimer.isEnabled = false
    }

}

