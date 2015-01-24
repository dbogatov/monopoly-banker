//
//  InAppPurchasesController.swift
//  Monopoly Banker
//
//  Created by Dmytro Bogatov on 1/23/15.
//  Copyright (c) 2015 Dmytro Bogatov. All rights reserved.
//

import UIKit
import StoreKit

class InAppPurchasesController: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
	
	let productId : NSString = "currenciesAndNoAd";
	var isPurchased : Bool?
	
	class var sharedInstance : InAppPurchasesController {
		struct Static {
			static let instance : InAppPurchasesController = InAppPurchasesController()
		}
		return Static.instance
	}
	
	override init() {
		super.init()
		
		SKPaymentQueue.defaultQueue().addTransactionObserver(self)
		
		let receiptURL : NSURL = NSBundle.mainBundle().appStoreReceiptURL!
		if let receiptData : NSData = NSData(contentsOfURL: receiptURL) {
			isPurchased = true
		} else {
			isPurchased = false
		}
	}
	
	//MARK: - Interface functions
	
	func isPurchased(productID: String = "currenciesAndNoAd") -> Bool {
		return isPurchased!
	}
	
	func buyConsumable(){
		println("About to fetch the products");
		// We check that we are allow to make the purchase.
		if (SKPaymentQueue.canMakePayments())
		{
			var productID : NSSet = NSSet(object: self.productId);
			var productsRequest : SKProductsRequest = SKProductsRequest(productIdentifiers: productID);
			productsRequest.delegate = self;
			productsRequest.start();
			println("Fething Products");
		}else{
			println("Can't make purchases");
		}
	}
	
	func restorePurchases() {
		SKPaymentQueue.defaultQueue().restoreCompletedTransactions()
	}
	
	//MARK: - Helper Methods
	
	func buyProduct(product: SKProduct){
		println("Sending the Payment Request to Apple");
		var payment = SKPayment(product: product)
		SKPaymentQueue.defaultQueue().addPayment(payment);
		
	}
	
	//MARK: - Delegate Methods for IAP
	
	func productsRequest(request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
		println("Got the request from Apple")
		var count : Int = response.products.count
		
		if (count > 0) {
			var validProducts = response.products
			var validProduct : SKProduct = response.products[0] as SKProduct
			
			if (validProduct.productIdentifier == self.productId) {
				
				println(validProduct.localizedTitle)
				println(validProduct.localizedDescription)
				println(validProduct.price)
				buyProduct(validProduct);
			} else {
				println(validProduct.productIdentifier)
			}
		} else {
			println("Nothing")
		}
	}
	
	
	func request(request: SKRequest!, didFailWithError error: NSError!) {
		println("Request!");
	}
	
	func paymentQueue(queue: SKPaymentQueue!, updatedTransactions transactions: [AnyObject]!)    {
		println("Received Payment Transaction Response from Apple");
		
		for transaction : AnyObject in transactions {
			
			if let trans : SKPaymentTransaction = transaction as? SKPaymentTransaction {
				
				switch trans.transactionState {
					case .Purchased:
						println("Product Purchased");
						SKPaymentQueue.defaultQueue().finishTransaction(transaction as SKPaymentTransaction)
						break;
					case .Failed:
						println("Purchased Failed");
						SKPaymentQueue.defaultQueue().finishTransaction(transaction as SKPaymentTransaction)
						break;
					case .Restored:
						SKPaymentQueue.defaultQueue().restoreCompletedTransactions()
						SKPaymentQueue.defaultQueue().finishTransaction(transaction as SKPaymentTransaction)
					default:
						break;
				}
			}
		}
	}
	
	func paymentQueueRestoreCompletedTransactionsFinished(queue: SKPaymentQueue!) {
		println("Transactions restored")
		
		for transaction in queue.transactions {
			var trans : SKPaymentTransaction = transaction as SKPaymentTransaction

			let prodID = trans.payment.productIdentifier as String
			
			if prodID == productId {
				isPurchased = true
				println("Purchased!!!")
			}
		}
	}
}
