//
//  PagedScrollViewController.swift
//  CremosaApp
//
//  Created by Ricardo Ferreira on 29/01/18.
//  Copyright © 2018 Ricardo Ferreira. All rights reserved.
//

import UIKit

class PagedScrollViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let page1: UIView! = Bundle.main.loadNibNamed("Page1", owner: self, options: nil)![0] as! UIView
        let page2: UIView! = Bundle.main.loadNibNamed("Page2", owner: self, options: nil)![0] as! UIView
        let page3: UIView! = Bundle.main.loadNibNamed("Page3", owner: self, options: nil)![0] as! UIView
        let page4: UIView! = Bundle.main.loadNibNamed("Page4", owner: self, options: nil)![0] as! UIView
        
        let pages: [UIView?] = [page1,page2,page3,page4]
        // Do any additional setup after loading the view.
        pageControl.currentPage = 0
        pageControl.numberOfPages = pages.count
        
        // Adicionar as páginas no scrollview
        for page in pages {
            
            // Calcula um novo frame para a página deslocando em X o tamanho de uma página
            // para colocar as views lado a lado
            page?.frame = (page?.frame.offsetBy(dx: scrollView.contentSize.width, dy: 0))!
            
            // adiciona a página na scrollview
            scrollView.addSubview(page!)
            
            // calcula o tamanho do conteúdo da scrollview
            scrollView.contentSize = CGSize(width: scrollView.contentSize.width + self.view.frame.width, height: (page?.frame.height)!)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // calcula o numero da página baseado no quanto o scrollview está deslocado em X
        let page = floor(scrollView.contentOffset.x / self.view.frame.width)
        
        // Para atualizar o current page é necessário converter o float para Int
        pageControl.currentPage = Int(page)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
