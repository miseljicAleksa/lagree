//
//  IntroPageController.swift
//  Lagree
//
//  Created by alk msljc on 9/13/19.
//  Copyright © 2019 Arsen Leontijevic. All rights reserved.
//

import UIKit

class IntroPageController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var controllers = [IntroContentController1.self,IntroContentController2.self]
    let startIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        self.setViewControllers([getFirstController()] as [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        //let currController = pageViewController.viewControllers!.first as! ContentController
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        var pageContentViewController:UIViewController?
        
        if viewController is IntroContentController1 {
            pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "IntroContentController2") as! IntroContentController2
        }
        if viewController is IntroContentController2 {
            pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "IntroContentController1") as! IntroContentController1
        }
        return pageContentViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        var pageContentViewController:UIViewController?
        if viewController is IntroContentController1 {
            pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "IntroContentController2") as! IntroContentController2
        }
        if viewController is IntroContentController2 {
            pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "IntroContentController1") as! IntroContentController1
        }
        return pageContentViewController
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        self.setupPageControl()
        return self.controllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.startIndex
    }
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor(hex: "#616C6F")
        appearance.currentPageIndicatorTintColor = UIColor.white
    }
    
    func getFirstController() -> IntroContentController1
    {
        // Create a new view controller and pass suitable data.
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "IntroContentController1") as! IntroContentController1
        return pageContentViewController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
