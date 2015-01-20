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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func feedbackPressed(sender: UIButton) {
		let mailComposeViewController = configuredMailComposeViewController()
		if MFMailComposeViewController.canSendMail() {
			self.presentViewController(mailComposeViewController, animated: true, completion: nil)
		} else {
			self.showSendMailErrorAlert()
		}
	}

	
	@IBAction func removeAdsPressed(sender: UIButton) {
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
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
