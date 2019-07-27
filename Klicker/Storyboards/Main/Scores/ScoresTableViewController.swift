import UIKit

class ScoresTableViewController: UITableViewController {
    
    // MARK: - Properties
    var scores: [Double] = []
    var score: Double = 0.0
    
    // MARK: - Overrides
    /// Configures the status bar to change from black (default) to white.
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Cuts off excess lines in the Table View.
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table View Overrides
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "score", for: indexPath)

        /// Configures the content of the cells to adapt accordingly to the indexPath.row value.
        cell.textLabel?.text = "\(scores[indexPath.row]) seconds"
        cell.detailTextLabel?.text = "Attempt \(indexPath.row + 1)"

        return cell
    }
    
    /// Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            scores.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Actions
    @IBAction func unwindToScoresTVC(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source as? ClickerViewController
        score = sourceViewController!.time
        
        /// Adds the new score retrieved from ClickerViewController and reloads the Table View.
        scores.append(round(score * 10)/10)
        tableView.reloadData()
    }

}
