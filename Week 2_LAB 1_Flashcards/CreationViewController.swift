import UIKit

class CreationViewController: UIViewController {
    var check: String!
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var option1TextField: UITextField!
    @IBOutlet weak var option2TextField: UITextField!
    @IBOutlet weak var screen: UIVisualEffectView!
    
    @IBOutlet weak var Edit_Deco: UIButton!
    @IBOutlet weak var Add_Deco: UIButton!
    
    var flashcardsController: ViewController!
    
    @IBAction func buttonEdit(_ sender: Any) {
        screen.isHidden = true
        questionTextField.isHidden = false
        answerTextField.isHidden = false
        option1TextField.isHidden = false
        option2TextField.isHidden = false
        check = "edit"
        let currentCard = flashcardsController.flashcards[flashcardsController.currentIndex]
        questionTextField.text = currentCard.question
        answerTextField.text = currentCard.answer
        answerTextField.backgroundColor = .green
        option1TextField.text = currentCard.option1
        option2TextField.text = currentCard.option2
    }
    @IBAction func buttonAdd(_ sender: Any) {
        screen.isHidden = true
        questionTextField.isHidden = false
        answerTextField.isHidden = false
        option1TextField.isHidden = false
        option2TextField.isHidden = false
        check = "add"
    }
    
    override func viewDidLoad() {
        setGradientBackground()
        super.viewDidLoad()
        screen.backgroundColor = UIColor(red: 0xf7/255, green: 0xed/255, blue: 0xe2/255, alpha: 1.0)
        questionTextField.isHidden = true
        answerTextField.isHidden = true
        option1TextField.isHidden = true
        option2TextField.isHidden = true
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = questionTextField.text
        let answerText = answerTextField.text
        let option1 = option1TextField.text
        let option2 = option2TextField.text
        
        let alert = UIAlertController(title: "Missing text", message: "Enter all of required information", preferredStyle: .alert)
        let continueAction = UIAlertAction(title: "Continue", style: .default)
        alert.addAction(continueAction)
        if (questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty || option1 == nil || option2 == nil || option1!.isEmpty || option2!.isEmpty) {
            present(alert, animated: true)
        }
        else {
            if (check == "add"){
                if (flashcardsController.currentIndex == flashcardsController.flashcards.count - 1){
                    flashcardsController.Next_Deco.isHidden = false
                }
                flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, option1: option1!, option2: option2!)
            }
            else if (check == "edit"){
                flashcardsController.flashcards[flashcardsController.currentIndex] = Flashcard(question: questionText!, answer: answerText!, option1: option1!, option2: option2!)
                flashcardsController.setupAnswers(position: flashcardsController.currentIndex)
                flashcardsController.setupOptions()
            }
            dismiss(animated: true)
        }
    }
}
