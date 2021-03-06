//
//  ApologiesAppolViewController.swift
//  CremosaApp
//
//  Created by Ricardo Ferreira on 23/01/18.
//  Copyright © 2018 Ricardo Ferreira. All rights reserved.
//

import UIKit

class ApologiesAppolViewController: UIViewController {

    
    @IBOutlet weak var phrase: UILabel!
    @IBOutlet weak var btCop: UIButton!
    let phrases = ["Tenho que trabalhar","Estou sem dinheiro","Tô doente, não quero passar para vocês.","Comi alguma coisa que não caiu legal. Estou passando mal.", "Tenho que levar minha vó no muay thai", "Tenho que levar minha vó pra andar de skate", "Tenho que treinar meu cachorro", "Vou ver naruto.", "Minha mãe não deixou", "tenho que fazer muitas coisas em casa", "não tenho dinheiro, gastei pra ir pra praia", "bateram no carro da minha mãe", "vou ajudar minha mãe com o armário", "eu tenho que tirar um retrato em família", "Aconteceu um imprevisto", "O uber capotou", "Vou para a guerra", "Acabou a energia", "Saiu uma série top no netflix", "Me machuquei imitando o Charlie Brown"]
    @IBOutlet weak var gradientView: UIView!
    var diceRoll:Int {
        get{
            return Int(arc4random_uniform(20))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.frame
        gradientLayer.zPosition = 0
        gradientLayer.colors = [UIColor(red: 47/255.5, green: 180/255.5, blue: 255/255.5, alpha: 1.0).cgColor, UIColor(red:40/255.5, green:260/255.5, blue:255/255.5, alpha: 1.0).cgColor]
        self.gradientView.layer.addSublayer(gradientLayer)
        btCop.isHidden = true
        

        // Do any additional setup after loading the view.
    }

    @IBAction func getRandom(_ sender: Any) {
//        phrase.text = "\(diceRoll)"
        phrase.text = phrases[diceRoll]
        btCop.isHidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func copyBtn(_ sender: Any) {
        UIPasteboard.general.string = phrase.text
        let alertController = UIAlertController(title: "", message: "Mensagem copiada, basta mandar pro alvo!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        present(alertController, animated: true, completion: nil)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
