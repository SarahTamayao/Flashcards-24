import UIKit

struct Flashcard {
    var question: String
    var answer: String
    var option1: String
    var option2: String
}

class ViewController: UIViewController {
    @IBOutlet weak var Screen: UIView!
    @IBOutlet weak var Question: UILabel!
    @IBOutlet weak var Answer: UILabel!
    
    @IBOutlet weak var Button1_Deco: UIButton!
    @IBOutlet weak var Button2_Deco: UIButton!
    @IBOutlet weak var Button3_Deco: UIButton!
    
    @IBOutlet weak var Reset_Deco: UIButton!
    @IBOutlet weak var Next_Deco: UIButton!
    @IBOutlet weak var Prev_Deco: UIButton!
    @IBOutlet weak var Delete_Deco: UIButton!
    
    var flashcards = [Flashcard]() // array to hold our flashcards
    var currentIndex = 0 // current question
    
    // Initialization flashcard questions, will fix the code soon
    let card1 = Flashcard(question: "In March 2022, which artist became the most certified artist for singles in RIAA Gold & Platinum program history?", answer: "Eminem", option1: "Drake", option2: "Kanye West")
    let card2 = Flashcard(question: "Which rapper below is not Vietnamese?", answer: "Vaanda", option1: "Kid Trunks", option2: "Tyga")
    let card3 = Flashcard(question: "Which rapper won the most Grammy Award wins?", answer: "Jay-z", option1: "Eminem", option2: "Kanye West")
    // When click 3 buttons
    @IBAction func Button1(_ sender: Any) {
        Button1_Deco.layer.borderWidth = 5
        if (Button1_Deco.titleLabel?.text == Answer.text){
            Button1_Deco.layer.borderColor = #colorLiteral(red: 0, green: 0.9342876673, blue: 0, alpha: 1)
            Answer.textColor = #colorLiteral(red: 0, green: 0.9342876673, blue: 0, alpha: 1)
            flipFlashcard()
        }
        else {Button1_Deco.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0.1733349173, alpha: 1)}
    }
    @IBAction func Button2(_ sender: Any) {
        Button2_Deco.layer.borderWidth = 5
        if (Button2_Deco.titleLabel?.text == Answer.text){
            Button2_Deco.layer.borderColor = #colorLiteral(red: 0, green: 0.9342876673, blue: 0, alpha: 1)
            Answer.textColor = #colorLiteral(red: 0, green: 0.9342876673, blue: 0, alpha: 1)
            flipFlashcard()
        }
        else {Button2_Deco.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0.1733349173, alpha: 1)}
    }
    @IBAction func Button3(_ sender: Any) {
        Button3_Deco.layer.borderWidth = 5
        if (Button3_Deco.titleLabel?.text == Answer.text){
            Button3_Deco.layer.borderColor = #colorLiteral(red: 0, green: 0.9342876673, blue: 0, alpha: 1)
            Answer.textColor = #colorLiteral(red: 0, green: 0.9342876673, blue: 0, alpha: 1)
            flipFlashcard()
        }
        else {Button3_Deco.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0.1733349173, alpha: 1)}
    }
    // When click reset button
    @IBAction func ButtonReset(_ sender: Any) {
        viewDidLoad()
    }
    @IBAction func ButtonNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        flipFlashcard()
        setupAnswers(position: currentIndex)
        updateNextPrevButtons()
    }
    @IBAction func ButtonPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        setupAnswers(position: currentIndex)
        flipFlashcard()
        updateNextPrevButtons()
    }
    
    @IBAction func ButtonDelete(_ sender: Any) {
        let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure to delete this question?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in self.deleteCurrentFlashcard()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func deleteCurrentFlashcard(){
        flashcards.remove(at: currentIndex)
        if (flashcards.count == 0){ // check there are no cards remaining
            currentIndex = 0
            Question.text = "Click + below to add more questions"
            Answer.text = "Click + below to add more questions"
            Button1_Deco.titleLabel?.text = "All cards deleted"
            Button2_Deco.titleLabel?.text = "Click + to add more"
            Button3_Deco.titleLabel?.text = "Re-open to restart"
        } else if (currentIndex == flashcards.count){ // check the last index is deleted
            currentIndex = flashcards.count - 1
            setupAnswers(position: currentIndex)
        } else { // index is between 2 ends
            setupAnswers(position: currentIndex)
        }
        saveAllFlashcardsToDisk()
        updateNextPrevButtons()
        Question.isHidden = false
    }
    
    func updateNextPrevButtons(){
        if (currentIndex == flashcards.count - 1) {
            Next_Deco.isEnabled = false
        } else {
            Next_Deco.isEnabled = true
        }
        if (currentIndex == 0){
            Prev_Deco.isEnabled = false
        } else {
            Prev_Deco.isEnabled = true
        }
        if (flashcards.count == 0){
            Next_Deco.isEnabled = false
            Prev_Deco.isEnabled = false
            Delete_Deco.isEnabled = false
        } else {
            Delete_Deco.isEnabled = true
        }
    }
    
    @IBAction func TapScreen(_ sender: Any) {
        Answer.textColor = #colorLiteral(red: 0, green: 0.9342876673, blue: 0, alpha: 1)
        flipFlashcard()
        Next_Deco.isHidden = false
    }
    
    func setupAnswers(position: Int){
        let buttons = [Button1_Deco, Button2_Deco, Button3_Deco]
        var count:[Int] = [0, 1, 2]
        let currentFlashcard = flashcards[position]
        
        Question.text = currentFlashcard.question
        Answer.text = currentFlashcard.answer
        
        let first = count.randomElement()!
        count = count.filter {$0 != first}
        buttons[first]?.setTitle(currentFlashcard.answer, for: .normal)
        let second = count.randomElement()!
        count = count.filter {$0 != second}
        buttons[second]?.setTitle(currentFlashcard.option1, for: .normal)
        let third = count[0]
        count = count.filter {$0 != third}
        buttons[third]?.setTitle(currentFlashcard.option2, for: .normal)
        //------------------------------------------------------
        // Button 1 setup
        Button1_Deco.titleLabel?.textColor = .black
        Button1_Deco.backgroundColor = UIColor(red: 0xe2/255, green: 0xfe/255, blue: 0xff/255, alpha: 1.0)
        Button1_Deco.layer.cornerRadius = 5
        Button1_Deco.clipsToBounds = true
        Button1_Deco.layer.borderWidth = 0
        // Button 2 setup
        Button2_Deco.titleLabel?.textColor = .black
        Button2_Deco.backgroundColor = UIColor(red: 0xe2/255, green: 0xfe/255, blue: 0xff/255, alpha: 1.0)
        Button2_Deco.layer.cornerRadius = 5
        Button2_Deco.clipsToBounds = true
        Button2_Deco.layer.borderWidth = 0
        // Button 3 setup
        Button3_Deco.titleLabel?.textColor = .black
        Button3_Deco.backgroundColor = UIColor(red: 0xe2/255, green: 0xfe/255, blue: 0xff/255, alpha: 1.0)
        Button3_Deco.layer.cornerRadius = 5
        Button3_Deco.clipsToBounds = true
        Button3_Deco.layer.borderWidth = 0
    }
    
    func updateFlashcard(question: String, answer: String, option1: String, option2: String){
        let flashcard = Flashcard(question: question, answer: answer, option1: option1, option2: option2)
        flashcards.append(flashcard)
        updateNextPrevButtons()
        saveAllFlashcardsToDisk()
    }
    
    func flipFlashcard() {
        if (Question.isHidden == false){
            UIView.transition(with: Answer, duration: 0.3, options: .transitionFlipFromTop, animations: {self.Question.isHidden = !self.Question.isHidden
            })
            Next_Deco.isHidden = false
        }
        else {
            UIView.transition(with: Answer, duration: 0.3, options: .transitionFlipFromBottom, animations: {self.Question.isHidden = !self.Question.isHidden
            })
            Next_Deco.isHidden = true
        }
    }
    
    func saveAllFlashcardsToDisk(){
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer, "option1": card.option1, "option2": card.option2]
        }
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("Card saved")
    }
    
    func readSavedFlashcards(){
        let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards")
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]{
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, option1: dictionary["option1"]!, option2: dictionary["option2"]!)
            }
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Back Screen set up
        Screen.backgroundColor = UIColor(red: 0xf7/255, green: 0xed/255, blue: 0xe2/255, alpha: 1.0)
        Screen.layer.shadowRadius = 15.0
        Screen.layer.shadowOpacity = 0.2
        // Question set up
        Question.textColor = .black
        Question.layer.cornerRadius = 10 // border radius
        Question.clipsToBounds = true // border radius
        Question.backgroundColor = UIColor(red: 0xff/255, green: 0xc5/255, blue: 0x95/255, alpha: 1.0)
        Question.isHidden = false
        // Answer setup
        Answer.textColor = .black
        Answer.layer.cornerRadius = 10 // border radius
        Answer.layer.masksToBounds = true // border radius
        Answer.backgroundColor = UIColor(red: 0xff/255, green: 0xc5/255, blue: 0x95/255, alpha: 1.0)
        
        updateNextPrevButtons()
        // Button RESET setup
        Reset_Deco.isHidden = true
        Reset_Deco.backgroundColor = UIColor(red: 0xff/255, green: 0x8b/255, blue: 0x51/255, alpha: 1.0)
        Reset_Deco.layer.cornerRadius = 5
        Reset_Deco.clipsToBounds = true
        Reset_Deco.titleLabel?.textColor = .white
        // Button NEXT setup
        Next_Deco.backgroundColor = UIColor(red: 0xf6/255, green: 0xbd/255, blue: 0x60/255, alpha: 1.0)
        Next_Deco.layer.cornerRadius = 5
        Next_Deco.clipsToBounds = true
        Next_Deco.titleLabel?.textColor = .white
        Next_Deco.isHidden = true
        // Button PREV setup
        Prev_Deco.backgroundColor = UIColor(red: 0xf6/255, green: 0xbd/255, blue: 0x60/255, alpha: 1.0)
        Prev_Deco.layer.cornerRadius = 5
        Prev_Deco.clipsToBounds = true
        Prev_Deco.titleLabel?.textColor = .white
        
        currentIndex = 0
        readSavedFlashcards()
        if (flashcards.count == 0){
            updateFlashcard(question: card1.question, answer: card1.answer, option1: card1.option1, option2: card1.option2)
            updateFlashcard(question: card2.question, answer: card2.answer, option1: card2.option1, option2: card2.option2)
            updateFlashcard(question: card3.question, answer: card3.answer, option1: card3.option1, option2: card3.option2)
            setupAnswers(position: 0)
            saveAllFlashcardsToDisk()
        }
        else {
            setupAnswers(position: 0)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // We know the desitnation of the seque is the Navigation Controller
        let navigationController = segue.destination as! UINavigationController
        // We know the Navigation Controller only contains a Creation View Controller
        let creationController = navigationController.topViewController as! CreationViewController
        // We set the flashcardsController property to self
        creationController.flashcardsController = self
    }
}
