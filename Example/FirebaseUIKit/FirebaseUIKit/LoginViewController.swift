import UIKit
import FirebaseAuth
import CrossClassify

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        CrossClassify.shared.track(pageName: "login", formName: "login", view: view)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        CrossClassify.shared.stopTrack()
    }
    
    @IBAction func login(_ sender: UIButton) {
        Auth.auth()
            .signIn(withEmail: email.text!, password: password.text!) {
                [weak self] authResult, error in
                
                guard let strongSelf = self else { return }
                
                guard let user = authResult?.user, error == nil else {
                    strongSelf.didNotAuth(error)
                    return
                }
                strongSelf.didAuth(user)
        }
    }
    
    private func didAuth(_ user: User) {
        performSegue(withIdentifier: "login", sender: self)
    }
    
    private func didNotAuth(_ error: Error?) {
        let alert = UIAlertController(title: "Error",
                          message: error!.localizedDescription,
                          preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
