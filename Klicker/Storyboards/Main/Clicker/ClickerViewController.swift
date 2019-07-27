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
    
    // MARK: - Functions
    @objc func configureTimer() {
        time += 0.1
        labelTime.text = "\(String(format: "%.1f", time)) seconds"
    }
    
    // MARK: - Actions
    @IBAction func tappedScreen(_ sender: UITapGestureRecognizer) {
        /// Adds 1 to the total count and reflects the change on labelCount.
        count += 1
        labelCount.text = String(count)
        
        /// Dismisses the View Controller when count reaches 30, effectively finishing and stopping the task.
        if count == 30 {
            self.performSegue(withIdentifier: "unwind", sender: nil)
        }
        
    }
    
    @IBAction func swipeCancel(_ sender: UISwipeGestureRecognizer) {
        if time > 0.0 {
            let warningAlert = UIAlertController(title: NSLocalizedString("Proceed and return?", comment: "Prompts the user if they wish to continue to cancel and return."), message: NSLocalizedString("Any progress currently made will be lost.", comment: "Explain what will happen when the cancelling occurs; progress will be lost."), preferredStyle: .alert)
            warningAlert.addAction(UIAlertAction(title: NSLocalizedString("Proceed", comment: "Cancels and stops the clicker."), style: .destructive, handler: { (_) in
                self.dismiss(animated: true, completion: nil)
            }))
            warningAlert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancels the cancellation and resumes."), style: .cancel, handler: { (_) in
                self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.configureTimer), userInfo: nil, repeats: true)
            }))
            
            self.timer?.invalidate()
            self.present(warningAlert, animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func buttonTimer(_ sender: UIButton) {
        /// Configures the timer to start counting per 0.1 seconds.
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(configureTimer), userInfo: nil, repeats: true)
        
        /// Disables buttonTimer (invisible button) to repeat timer configuration.
        buttonTimer.isEnabled = false
    }

}

