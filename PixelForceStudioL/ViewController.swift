//
//  ViewController.swift
//  verificacion
//
//  Created by DanielApps on 27/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let wordsForTheGame = ["algorithm", "language", "compiler", "variable", "function", "loop", "class", "object", "inheritance", "polymorphism", "encapsulation", "modularity", "debugging", "integration", "development", "frontend", "backend", "database", "API", "framework", "library", "programmer", "syntax", "compilation", "interpretation", "link", "optimization", "repository", "constant"]
    
    var numberOfAttempts: Int = 8
    var arrayToGuessResult: [Character] = []
    var secretWord: String = ""
    
    @IBOutlet var labelSecretWordView: UILabel!
    @IBOutlet weak var labelNumberOfAttemptsAvailable: UILabel!
    @IBOutlet weak var commentsView: UILabel?
    @IBAction func startNewWord(_ sender: UIButton) {
        startNewGame()
    }
    @IBAction func letterEnteredUser(_ sender: UIButton) {
        guard let buttonText = sender.titleLabel?.text?.lowercased().first else {
            commentsView?.text = "No hay letra"
            return
        }
        handleLetterInput(buttonText)
    }
    func handleLetterInput(_ letter: Character) {
        // Verifica si ya no hay más intentos
        guard numberOfAttempts > 0 else {
            commentsView?.text = "¡Game Over! La palabra era: \(secretWord)"
            return // Impide que el jugador haga más intentos después de Game Over
        }
        // Resto del código para manejar la entrada del usuario
        if secretWord.contains(letter) && !arrayToGuessResult.contains(letter) {
            arrayToGuessResult.append(letter)
        } else {
            numberOfAttempts -= 1
        }
        updateUI()
    }
    func startNewGame() {
        numberOfAttempts = 8
        arrayToGuessResult = []
        labelSecretWordView.text = ""
        secretWord = generateRandomWord(wordsForTheGame)
        updateUI()
    }
    
    func generateRandomWord(_ wordsForTheGame: [String]) -> String {
        let randomWord = wordsForTheGame.randomElement() ?? ""
        return randomWord.lowercased()
    }
    func updateUI() {
        var secretWordText = ""
        for letter in secretWord {
            if arrayToGuessResult.contains(letter) {
                secretWordText.append(letter)
            } else {
                secretWordText.append("_ ")
            }
        }
        labelSecretWordView.text = secretWordText
        updateGameStatus(secretWordText: secretWordText)
    }
    func updateGameStatus(secretWordText: String) {
        labelNumberOfAttemptsAvailable.text = "Tienes \(numberOfAttempts) Intentos"
        
        if secretWordText == secretWord {
            commentsView?.text = "¡Felicidades! Has adivinado la palabra: \(secretWord)"
        } else if numberOfAttempts <= 0 {
            commentsView?.text = "¡Game Over! La palabra era: \(secretWord)"
        } else {
            commentsView?.text = "Buena suerte"
        }
    }
}

