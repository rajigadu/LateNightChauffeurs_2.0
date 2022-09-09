//
//  DashBoardViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 09/09/22.
//

import UIKit
import SideMenu
class DashBoardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       // setupSideMenu()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func setupSideMenu(_ sender : Any){
//        let Storyboard : UIStoryboard = UIStoryboard(name: "SideMenu", bundle: nil)
//        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
//        let menu = SideMenuNavigationController(rootViewController: nxtVC)
//        present(menu, animated: true, completion: nil)
    }
    
    private func setupSideMenu() {
        // Define the menus
        let Storyboard : UIStoryboard = UIStoryboard(name: "SideMenu", bundle: nil)
       // let nxtVC = Storyboard.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController

        
        SideMenuManager.default.leftMenuNavigationController = Storyboard.instantiateViewController(withIdentifier: "SideMenuViewController") as? SideMenuNavigationController
        SideMenuManager.default.rightMenuNavigationController = Storyboard.instantiateViewController(withIdentifier: "SideMenuViewController") as? SideMenuNavigationController
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)
    }

}
extension DashBoardViewController: SideMenuNavigationControllerDelegate {
    
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
    }
    
    func sideMenuDidAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appeared! (animated: \(animated))")
    }
    
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappearing! (animated: \(animated))")
    }
    
    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappeared! (animated: \(animated))")
    }
}
