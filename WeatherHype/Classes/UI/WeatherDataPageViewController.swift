//
//  WeatherDataPageViewController.swift
//  WeatherHype
//
//  Created by Carlo Pascoli on 28/09/2016.
//  Copyright © 2016 Carlo Pascoli. All rights reserved.
//

import UIKit

class WeatherDataPageViewController: UIPageViewController {

    var model:[WeatherData]? {
        didSet {
            setupViewControllers(with:model!)
        }
    }

    var weatherViewControllerArray:[WeatherViewController]!

    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]?) {
        
        // Here i changed the transition style: UIPageViewControllerTransitionStyle.Scroll
        super.init(transitionStyle: UIPageViewControllerTransitionStyle.scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.horizontal, options: options)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        self.view.backgroundColor = UIColor.orange
        if let firstViewController = weatherViewControllerArray.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    func setupViewControllers(with data:[WeatherData]) {
        
        var viewContollers = [WeatherViewController]()
        for dataItem in data {
           let viewController = weatherViewController()
            viewController.model = dataItem
            viewContollers.append(viewController)
        }
        self.weatherViewControllerArray = viewContollers
    }

    func weatherViewController() -> WeatherViewController {
        
        let viewContoller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Weather") as! WeatherViewController
        return viewContoller
        
    }
}



// MARK: UIPageViewControllerDataSource

extension WeatherDataPageViewController: UIPageViewControllerDataSource {
    
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
       
        guard let viewControllerIndex = weatherViewControllerArray?.index(of: viewController as! WeatherViewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        return weatherViewControllerArray[previousIndex]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
       
        guard let viewControllerIndex = weatherViewControllerArray?.index(of: viewController as! WeatherViewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        let viewControllersCount = viewControllers?.count
        
        guard nextIndex >= viewControllersCount! else {
            return nil
        }
        
        return weatherViewControllerArray[nextIndex]
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return weatherViewControllerArray.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
       
        guard let firstViewController = viewControllers?.first,
              let firstViewControllerIndex = weatherViewControllerArray.index(of: firstViewController as! WeatherViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
    
}
