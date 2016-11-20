//
//  ViewController.swift
//  FoodTracker
//
//  Created by Fan Zhang on 7/10/2016.
//  Copyright © 2016 Fan Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
	UITextFieldDelegate,
	UIImagePickerControllerDelegate,
	UINavigationControllerDelegate,
	UITextViewDelegate {

	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var photoImageView: UIImageView!
	@IBOutlet weak var ratingControl: RatingControl!
	@IBOutlet weak var saveButton: UIBarButtonItem!
	@IBOutlet weak var commentView: UITextView!

	/// Used to adjust the text view's height when the keyboard hides and shows.
	@IBOutlet weak var textViewBottomLayoutGuideConstraint: NSLayoutConstraint!

	var meal: Meal?
	var activeField: AnyObject?

	override func viewDidLoad() {
		super.viewDidLoad()

		nameTextField.delegate = self
		commentView.delegate = self
		commentView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
		commentView.layer.borderWidth = 1.0
		commentView.layer.cornerRadius = 5

		// Set up views if editing an existing Meal
		if let meal = meal {
			navigationItem.title = meal.name
			nameTextField.text = meal.name
			photoImageView.image = meal.photo
			ratingControl.rating = meal.rating
			commentView.text = meal.comments
		}

		checkMealName()
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

		if sender as? UIBarButtonItem === saveButton! {
			let name = nameTextField.text ?? ""
			let photo = photoImageView.image
			let rating = ratingControl.rating
			let comments = commentView.text ?? ""

			meal = Meal(name: name, photo: photo, rating: rating, comments: comments)
		}
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		// Listen for changes to keyboard visibility so that we can adjust the text view accordingly.
		let notificationCenter = NotificationCenter.default

		notificationCenter.addObserver(self, selector: #selector(ViewController.handleKeyboardNotification(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)

		notificationCenter.addObserver(self, selector: #selector(ViewController.handleKeyboardNotification(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
	}

	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)

		let notificationCenter = NotificationCenter.default

		notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)

		notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
	}

	// MARK: - Keyboard Event Notifications

	func handleKeyboardNotification(_ notification: Notification) {
		if (activeField as? UITextView != commentView!) {
			return
		}
		let userInfo = notification.userInfo!

		// Get information about the animation.
		let animationDuration: TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue

		let rawAnimationCurveValue = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).uintValue
		let animationCurve = UIViewAnimationOptions(rawValue: rawAnimationCurveValue)

		// Convert the keyboard frame from screen to view coordinates.
		let keyboardScreenBeginFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
		let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue

		let keyboardViewBeginFrame = view.convert(keyboardScreenBeginFrame, from: view.window)
		let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
		let originDelta = keyboardViewEndFrame.origin.y - keyboardViewBeginFrame.origin.y

		// The text view should be adjusted, update the constant for this constraint.
		textViewBottomLayoutGuideConstraint.constant -= originDelta

		// Inform the view that its autolayout constraints have changed and the layout should be updated.
		view.setNeedsUpdateConstraints()

		// Animate updating the view's layout by calling layoutIfNeeded inside a UIView animation block.
		let animationOptions: UIViewAnimationOptions = [animationCurve, .beginFromCurrentState]
		UIView.animate(withDuration: animationDuration, delay: 0, options: animationOptions, animations: {
			self.view.layoutIfNeeded()
		}, completion: nil)

		// Scroll to the selected text once the keyboard frame changes.
		let selectedRange = commentView.selectedRange
		commentView.scrollRangeToVisible(selectedRange)
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		nameTextField.resignFirstResponder()
		return true
	}

	func textFieldDidEndEditing(_ textField: UITextField) {
		checkMealName()
		navigationItem.title = textField.text
	}

	func textFieldDidBeginEditing(_ textField: UITextField) {
		saveButton.isEnabled = false
	}

	func textViewDidEndEditing(_ textView: UITextView) {
		activeField = nil
	}

	func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
		activeField = commentView
		return true
	}

	func checkMealName() {
		let name = nameTextField.text ?? ""
		saveButton.isEnabled = !name.isEmpty
	}

	@IBAction func cancel(_ sender: UIBarButtonItem) {
		// Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in
		// two different ways
		let isPresentingInAddMealMode = presentingViewController is UINavigationController
		if isPresentingInAddMealMode {
			dismiss(animated: true, completion: nil)
		}
		else {
			navigationController!.popViewController(animated: true)
		}
	}
	@IBAction func selectImage(_ sender: UITapGestureRecognizer) {
		nameTextField.resignFirstResponder()
		commentView.resignFirstResponder()

		let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action) in
		})
		let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default, handler: {(action) in
			self.selectImageFromSource(.camera)
		})
		let choosePhotoAction = UIAlertAction(title: "Choose Photo From Library", style: .default, handler:{(action) in
			self.selectImageFromSource(.photoLibrary)
		})

		alertController.addAction(takePhotoAction)
		alertController.addAction(choosePhotoAction)
		alertController.addAction(cancelAction)

		present(alertController, animated: true, completion: nil)
	}

	func selectImageFromSource(_ sourceType: UIImagePickerControllerSourceType) {
		if UIImagePickerController.isSourceTypeAvailable(sourceType) {
			let imagePickerController = UIImagePickerController()
			imagePickerController.sourceType = sourceType
			imagePickerController.delegate = self
			present(imagePickerController, animated: true)
		}
	}

	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		dismiss(animated: true)
	}

	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		let selectedImage = info[UIImagePickerControllerOriginalImage]
		photoImageView.image = selectedImage as! UIImage?
		dismiss(animated: true)
	}
}

