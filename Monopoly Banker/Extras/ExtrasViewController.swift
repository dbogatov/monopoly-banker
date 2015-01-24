//
//  ExtrasViewController.swift
//  Monopoly Banker
//
//  Created by Dmytro Bogatov on 1/19/15.
//  Copyright (c) 2015 Dmytro Bogatov. All rights reserved.
//

import UIKit
import MessageUI

class ExtrasViewController: UIViewController, MFMailComposeViewControllerDelegate {

	@IBOutlet weak var buyButton: UIButton!
	@IBOutlet weak var restoreButton: UIButton!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

		buyButton.enabled = !InAppPurchasesController.sharedInstance.isPurchased()
		restoreButton.enabled = !InAppPurchasesController.sharedInstance.isPurchased()
		
		InAppPurchasesController.sharedInstance.parent = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func rateAppPressed(sender: UIButton) {
		UIApplication.sharedApplication().openURL(NSURL(string: "http://google.com")!);
	}
	
	@IBAction func feedbackPressed(sender: UIButton) {
		let mailComposeViewController = configuredMailComposeViewController()
		if MFMailComposeViewController.canSendMail() {
			self.presentViewController(mailComposeViewController, animated: true, completion: nil)
		} else {
			self.showSendMailErrorAlert()
		}
	}

	@IBAction func restorePurchasesPressed(sender: UIButton) {
		InAppPurchasesController.sharedInstance.restorePurchases()
	}
	
	@IBAction func removeAdsPressed(sender: UIButton) {
		InAppPurchasesController.sharedInstance.buyConsumable()
	}
	
	@IBAction func websitePressed(sender: UIButton) {
		UIApplication.sharedApplication().openURL(NSURL(string: "https://vk.com/dima4ka007")!);
	}
	
	@IBAction func facebookPressed(sender: UIButton) {
		UIApplication.sharedApplication().openURL(NSURL(string: "https://www.facebook.com/Dima4ka007")!);
	}
	
	@IBAction func backPressed(sender: UIButton) {
		self.dismissViewControllerAnimated(true, completion: nil)
	}
	
	func configuredMailComposeViewController() -> MFMailComposeViewController {
		let mailComposerVC = MFMailComposeViewController()
		mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
		
		mailComposerVC.setToRecipients(["dbogatov@wpi.edu"])
		mailComposerVC.setSubject("Monopoly Banker Feedback")
		mailComposerVC.setMessageBody("Dear Dmytro\n\n I am the user of your Monopoly Banker app and I want to provide a feedback.\n\n", isHTML: false)
		
		return mailComposerVC
	}
	
	func showSendMailErrorAlert() {
		let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
		sendMailErrorAlert.show()
	}
	
	// MARK: MFMailComposeViewControllerDelegate Method
	func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
		controller.dismissViewControllerAnimated(true, completion: nil)
	}
	
	func alertTransactionResult(text: String) {
		var alert = UIAlertController(title: "Transaction Info", message: text, preferredStyle: UIAlertControllerStyle.Alert)
		alert.addAction(UIAlertAction(title: "Okey", style: UIAlertActionStyle.Default, handler: nil))
		self.presentViewController(alert, animated: true, completion: nil)
	}

}
