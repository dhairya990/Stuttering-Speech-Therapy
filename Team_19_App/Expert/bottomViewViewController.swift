//
//  bottomViewViewController.swift
//  Team_19_App
//
//  Created by Sambhav Singh on 11/06/24.
//

import UIKit

class bottomViewViewController: UIViewController {
    
    
    var doc:DoctorData?
    
       private let searchLabel = UILabel()
       private let resultCountLabel = UILabel()
       private let editSearchLabel = UILabel()
       private let closeButton = UIButton(type: .system)
       private let titleLabel = UILabel()
       private let distanceLabel = UILabel()
       private let typeLabel = UILabel()
       private let addressLabel = UILabel()
       private let statusLabel = UILabel()
       private let hoursLabel = UILabel()
       private let imageView = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       view.backgroundColor = .white
        
        configureSearchLabel()
        configureResultCountLabel()
        configureEditSearchLabel()
        configureCloseButton()
        configureTitleLabel()
        configureDistanceLabel()
        configureTypeLabel()
        configureAddressLabel()
        configureStatusLabel()
        configureHoursLabel()
        configureImageView()
        setupConstraints()

    }
    private func configureSearchLabel() {
            searchLabel.font = UIFont.boldSystemFont(ofSize: 18)
            searchLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(searchLabel)
        }
        
        private func configureResultCountLabel() {
            resultCountLabel.font = UIFont.systemFont(ofSize: 14)
            resultCountLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(resultCountLabel)
        }
        
        private func configureEditSearchLabel() {
            editSearchLabel.font = UIFont.systemFont(ofSize: 14)
            editSearchLabel.textColor = .blue
            editSearchLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(editSearchLabel)
        }
        
        private func configureCloseButton() {
            closeButton.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(closeButton)
        }
        
        private func configureTitleLabel() {
            titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(titleLabel)
        }
        
        private func configureDistanceLabel() {
            distanceLabel.font = UIFont.systemFont(ofSize: 14)
            distanceLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(distanceLabel)
        }
        
        private func configureTypeLabel() {
            typeLabel.font = UIFont.systemFont(ofSize: 14)
            typeLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(typeLabel)
        }
        
        private func configureAddressLabel() {
            addressLabel.font = UIFont.systemFont(ofSize: 14)
            addressLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(addressLabel)
        }
        
        private func configureStatusLabel() {
            statusLabel.textColor = .red
            statusLabel.font = UIFont.systemFont(ofSize: 14)
            statusLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(statusLabel)
        }
        
        private func configureHoursLabel() {
            hoursLabel.font = UIFont.systemFont(ofSize: 14)
            hoursLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(hoursLabel)
        }
        
        private func configureImageView() {
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(imageView)
        }
    
    private func setupConstraints() {
           NSLayoutConstraint.activate([
               // Search Label
               searchLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
               searchLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               
               // Result Count Label
               resultCountLabel.topAnchor.constraint(equalTo: searchLabel.bottomAnchor, constant: 8),
               resultCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               
               // Edit Search Label
               editSearchLabel.topAnchor.constraint(equalTo: resultCountLabel.topAnchor),
               editSearchLabel.leadingAnchor.constraint(equalTo: resultCountLabel.trailingAnchor, constant: 8),
               
               // Close Button
               closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
               closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               
               // Title Label
               titleLabel.topAnchor.constraint(equalTo: resultCountLabel.bottomAnchor, constant: 20),
               titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               
               // Distance Label
               distanceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
               distanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               
               // Type Label
               typeLabel.topAnchor.constraint(equalTo: distanceLabel.topAnchor),
               typeLabel.leadingAnchor.constraint(equalTo: distanceLabel.trailingAnchor, constant: 8),
               
               // Address Label
               addressLabel.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 8),
               addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               
               // Status Label
               statusLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 8),
               statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               
               // Hours Label
               hoursLabel.topAnchor.constraint(equalTo: statusLabel.topAnchor),
               hoursLabel.leadingAnchor.constraint(equalTo: statusLabel.trailingAnchor, constant: 8),
               
               // Image View
               imageView.topAnchor.constraint(equalTo: titleLabel.topAnchor),
               imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               imageView.widthAnchor.constraint(equalToConstant: 40),
               imageView.heightAnchor.constraint(equalToConstant: 40)
           ])
       }
    
    
    func updateUI(with title: String, distance: String, type: String, address: String, status: String, hours: String, image: UIImage?) {
       
        titleLabel.text = title
        distanceLabel.text = distance
        typeLabel.text = type
            addressLabel.text = address
        statusLabel.text = status
            hoursLabel.text = hours
        imageView.image = image
    }
}
