//
//  ViewController.swift
//  CremosaApp
//
//  Created by Ricardo Ferreira on 11/01/18.
//  Copyright © 2018 Ricardo Ferreira. All rights reserved.
//

import UIKit
import CoreML

class ViewController: UIViewController {
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var predictLabel: UILabel!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var imgHumor: UIImageView!
    @IBOutlet weak var imgHumor2: UIImageView!
    @IBOutlet weak var shareSats: UIButton!
    @IBOutlet weak var shareInd: UIButton!
    @IBOutlet weak var kiddingImage1: UIImageView!
    @IBOutlet weak var kiddingImage2: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.frame
        gradientLayer.zPosition = 0
        gradientLayer.colors = [UIColor(red: 47/255.5, green: 180/255.5, blue: 255/255.5, alpha: 1.0).cgColor, UIColor(red:40/255.5, green:260/255.5, blue:255/255.5, alpha: 1.0).cgColor]
        self.gradientView.layer.addSublayer(gradientLayer)
        imgHumor.isHidden = true
        shareInd.isHidden = true
        imgHumor2.isHidden = true
        shareSats.isHidden = true
        
        messageTextField.delegate = self as? UITextFieldDelegate
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(messageTextField: UITextField) -> Bool
    {
        messageTextField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func predictButton(_ sender: UIButton) {
        let enteredMessage = messageTextField.text!
        if(enteredMessage != ""){
            predictLabel.text = ""
        }
        let vec = tfidf(sms: enteredMessage)
        do {
            
            print("tamanho é \(vec.count)")
            
            
            let input = SpamMessageClassifierInput(message: vec)
            let prediction = try SpamMessageClassifier().prediction(input: input).spam_or_not
            print(prediction)
            if (prediction == "taTeEnganando"){
                predictLabel.text = "HMMMMM, TÁ SENDO ENGANADINHO(A)"
//                imgHumor.image = UIImage(named: "evil")
                imgHumor.isHidden = false
                shareInd.isHidden = false
                imgHumor2.isHidden = true
                shareSats.isHidden = true
                
            }
            else if (prediction == "taSuaveCremosaVerdadeira"){
                predictLabel.text = "PÔ, CREMOSA(O) VERDADEIRA(O) TOP10 CONFIA!"
//                imgHumor.image = UIImage(named: "angel")
                imgHumor.isHidden = true
                shareInd.isHidden = true
                imgHumor2.isHidden = false
                shareSats.isHidden = false
            }
        }
        catch let error{
            print(error)
            predictLabel.text = "Aí azedou né parça"
        }
    }
    func tfidf(sms: String) -> MLMultiArray{
        //get path for files
        let wordsFile = Bundle.main.path(forResource: "wordlistFinal", ofType: "txt")
        let smsFile = Bundle.main.path(forResource: "desculpas", ofType: "txt")
        do {
            //read words file
            let wordsFileText = try String(contentsOfFile: wordsFile!, encoding: String.Encoding.utf8)
            var wordsData = wordsFileText.components(separatedBy: .newlines)
            wordsData.removeLast() // Trailing newline.
            //read spam collection file
            let smsFileText = try String(contentsOfFile: smsFile!, encoding: String.Encoding.utf8)
            var smsData = smsFileText.components(separatedBy: .newlines)
            smsData.removeLast() // Trailing newline.
            let wordsInMessage = sms.split(separator: " ")
            //create a multi-dimensional array
            print("Lista é \(wordsData.count)")
            let vectorized = try MLMultiArray(shape: [NSNumber(integerLiteral: wordsData.count)], dataType: MLMultiArrayDataType.double)
            for i in 0..<wordsData.count{
                let word = wordsData[i]
                if sms.contains(word){
                    var wordCount = 0
                    for substr in wordsInMessage{
                        if substr.elementsEqual(word){
                            wordCount += 1
                        }
                    }
                    let tf = Double(wordCount) / Double(wordsInMessage.count)
                    var docCount = 0
                    for sms in smsData{
                        if sms.contains(word) {
                            docCount += 1
                        }
                    }
                    let idf = log(Double(smsData.count) / Double(docCount))
                    vectorized[i] = NSNumber(value: tf * idf)
                } else {
                    vectorized[i] = 0.0
                }
            }
            return vectorized
        } catch {
            return MLMultiArray()
        }
    }
    @IBAction func shareImageInd(_ sender: Any) {
        let activityView = UIActivityViewController(activityItems: [self.kiddingImage1.image!], applicationActivities: nil)
        
        activityView.popoverPresentationController?.sourceView = self.view
        
        self.present(activityView, animated: true, completion: nil)
    }
    @IBAction func shareImageSats(_ sender: Any) {
        let activityView = UIActivityViewController(activityItems: [self.kiddingImage2.image!], applicationActivities: nil)
        
        activityView.popoverPresentationController?.sourceView = self.view
        
        self.present(activityView, animated: true, completion: nil)
    }
    
    

}

