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
    
    var flashcards = [Flashcard]() // array of contents
    var currentIndex = 0 // current question
    
    // Initialization flashcard questions, will fix the code soon
    let card1 = Flashcard(question: "In March 2022, which artist became the most certified artist for singles in RIAA Gold & Platinum program history?", answer: "Eminem", option1: "Drake", option2: "Kanye West")
    let card2 = Flashcard(question: "Which rapper below is not Vietnamese?", answer: "Vaanda", option1: "Kid Trunks", option2: "Tyga")
    let card3 = Flashcard(question: "Which rapper won the most Grammy Award wins?", answer: "Jay-z", option1: "Eminem", option2: "Kanye West")
    
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
    
    func setupOptions(){
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
    
    @IBAction func ButtonReset(_ sender: Any) {
        viewDidLoad()
    }
    @IBAction func ButtonNext(_ sender: Any) {
        if (currentIndex < flashcards.count - 1){
            currentIndex = currentIndex + 1
            flipFlashcard()
            setupAnswers(position: currentIndex)
            setupOptions()
        }
        else {
            Answer.text = "THE END!\nPress RESET or + to insert your question"
            Answer.textColor = .red
            Button1_Deco?.setTitle("Thanks for", for: .normal)
            Button2_Deco?.setTitle("visiting", for: .normal)
            Button3_Deco?.setTitle("2DT Official", for: .normal)
            setupOptions()
        }
        Next_Deco.isHidden = true
    }
    
    @IBAction func TapScreen(_ sender: Any) {
        Answer.textColor = #colorLiteral(red: 0, green: 0.9342876673, blue: 0, alpha: 1)
        flipFlashcard()
        Next_Deco.isHidden = false
    }
    
    func setupAnswers(position: Int){
        var buttons = [Button1_Deco, Button2_Deco, Button3_Deco]
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
    }
    
    func updateFlashcard(question: String, answer: String, option1: String, option2: String){
        let flashcard = Flashcard(question: question, answer: answer, option1: option1, option2: option2)
        flashcards.append(flashcard)
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
        
        setupOptions() // Button OPTIONS setup
        
        // Button RESET setup
        Reset_Deco.backgroundColor = UIColor(red: 0xff/255, green: 0x8b/255, blue: 0x51/255, alpha: 1.0)
        Reset_Deco.layer.cornerRadius = 5
        Reset_Deco.clipsToBounds = true
        Reset_Deco.titleLabel?.textColor = .white
        
        // Button NEXT setup
        Next_Deco.backgroundColor = UIColor(red: 0xff/255, green: 0x8b/255, blue: 0x51/255, alpha: 1.0)
        Next_Deco.layer.cornerRadius = 5
        Next_Deco.clipsToBounds = true
        Next_Deco.titleLabel?.textColor = .white
        Next_Deco.isHidden = true
        
        currentIndex = 0
        if (flashcards.count == 0){
            flashcards.append(card1)
            flashcards.append(card2)
            flashcards.append(card3)
            setupAnswers(position: 0)
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
