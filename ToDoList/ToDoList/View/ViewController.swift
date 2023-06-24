import UIKit

final class ViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        let table = UIViewController()
        let task = TaskViewController()
        let navigationController = UINavigationController(rootViewController: task)
        present(navigationController, animated: true)
        
    }

}
