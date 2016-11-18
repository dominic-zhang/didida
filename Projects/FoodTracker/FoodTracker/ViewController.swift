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
	UINavigationControllerDelegate {

	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var photoImageView: UIImageView!
	@IBOutlet weak var ratingControl: RatingControl!
	@IBOutlet weak var saveButton: UIBarButtonItem!
	@IBOutlet weak var commentView: UITextView!

	var meal: Meal?

	override func viewDidLoad() {
		super.viewDidLoad()

		nameTextField.delegate = self
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

