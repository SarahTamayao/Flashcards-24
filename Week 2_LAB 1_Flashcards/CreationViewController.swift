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
    // Decoration
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var option1TextField: UITextField!
    @IBOutlet weak var option2TextField: UITextField!
 
    // Declare main screen
    var flashcardsController: ViewController!
    // Initial screen
    override func viewDidLoad() {
        setGradientBackground()
        super.viewDidLoad()
  
        questionTextField.frame.size.height = 40
        
        let alert = UIAlertController(title: "EDIT or ADD", message: "Edit current card or add new card?", preferredStyle: .alert)
        let editAction = UIAlertAction(title: "Edit", style: .destructive) { action in
            let currentCard = self.flashcardsController.flashcards[self.flashcardsController.currentIndex]
            self.questionTextField.text = currentCard.question
            self.answerTextField.text = currentCard.answer
            self.answerTextField.backgroundColor = .green
            self.option1TextField.text = currentCard.option1
            self.option2TextField.text = currentCard.option2
            self.check = "edit"
        }
        let addAction = UIAlertAction(title: "Add", style: .destructive){ action in
            self.questionTextField.isHidden = false
            self.answerTextField.isHidden = false
            self.option1TextField.isHidden = false
            self.option2TextField.isHidden = false
            self.check = "add"
        }
        alert.addAction(editAction)
        alert.addAction(addAction)
        present(alert, animated: true)
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
                flashcardsController.saveAllFlashcardsToDisk()
            }
            else if (check == "edit"){
                flashcardsController.flashcards[flashcardsController.currentIndex] = Flashcard(question: questionText!, answer: answerText!, option1: option1!, option2: option2!)
                flashcardsController.setupAnswers()
                flashcardsController.saveAllFlashcardsToDisk()
            }
            dismiss(animated: true)
        }
    }
}
