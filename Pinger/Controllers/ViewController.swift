//
//  ViewController.swift
//  Pinger
//
//  Created by Reza Bina on 2020-03-21.
//  Copyright © 2020 Reza Bina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView = configure(UITableView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        $0.tableFooterView = UIView(frame: .zero)
    }
    
    private var progressBar: UIProgressView!
    private var progressView: UIBarButtonItem!
    
    private var results: NetworkScannerResult!
    
    private var ip: Int = 1 {
        didSet { progressBar.setProgress(Float(ip) / Float(254), animated: true) }
    }
    
    private var isStart: Bool = false {
        willSet {
            let startButton = UIBarButtonItem(barButtonSystemItem: newValue ? .pause : .play, target: self, action: #selector(startButtonDidTapped(_:)))
            navigationItem.rightBarButtonItem = startButton
            progressBar.isHidden = !newValue
        }
    }
    
    private var managers: [PingManager] = []
    private var scanner: NetworkScanner?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        results = NetworkScannerResult()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.showEmptyView(title: "welcomeTitle".localized, body: "welcomeBody".localized)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        navigationItem.title = "appName".localized
        
        setupProgressBar()
        setupStartButton()
        setupSortButton()
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: 0).isActive = true
    }
    
    private func setupProgressBar() {
        progressBar = UIProgressView(progressViewStyle: .default)
        progressBar.sizeToFit()
        progressBar.isHidden = true
        progressView = UIBarButtonItem(customView: progressBar)
        toolbarItems = [progressView]
    }
    
    private func setupStartButton() {
        let startButton = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(startButtonDidTapped(_:)))
        navigationItem.rightBarButtonItem = startButton
    }
    
    private func setupSortButton() {
        let sortButton = UIBarButtonItem(title: "sort".localized, style: .plain, target: self, action: #selector(sortButtonDidTapped(_:)))
        navigationItem.leftBarButtonItem = sortButton
    }
    
    @objc
    private func startButtonDidTapped(_ sender: UIBarButtonItem) {
        isStart.toggle()
        isStart ? startScanner() : stopScanner()
    }
    
    @objc
    private func sortButtonDidTapped(_ sender: UIBarButtonItem) {
        let actionController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let sortByIpAction = UIAlertAction(title: "sortByIp".localized, style: .default) {  [weak self] _ in
            guard let `self` = self else { return }
            self.results.sort(by: .ip)
            self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
        let sortByreachabilityAction = UIAlertAction(title: "sortByReachability".localized, style: .default) {  [weak self] _ in
            guard let `self` = self else { return }
            self.results.sort(by: .reachability)
            self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
        
        if let popoverPresentationController = actionController.popoverPresentationController {
            popoverPresentationController.barButtonItem = sender
        }
        
        actionController.addAction(sortByreachabilityAction)
        actionController.addAction(sortByIpAction)
        present(actionController, animated: true)
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.summaries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ResultTableViewCell()
        cell.ipAddress = results.summaries[indexPath.row].host?.description
        cell.isReachable = results.summaries[indexPath.row].isReachable
        return cell
    }
    
}

extension ViewController: NetworkScannerDelegate {
    
    func networkScannerDelegate(numberOfPinged ip: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.progressBar.setProgress(Float(ip) / Float(255), animated: true)
        }
    }
    
    func networkScannerDidFinishPing(with result: [PingSummary]) {
        stopScanner()
        results.summaries = result
        results.sort(by: .reachability)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.hideEmptyView()
            self.isStart = false
            self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }
    
}

extension ViewController {
    
    private func startScanner() {
        scanner = NetworkScanner()
        scanner?.delegate = self
        scanner?.setup(completion: { [weak self] (success) in
            guard let `self` = self else { return }
            if success {
                self.scanner?.startScanning()
            } else {
                self.showAlert(title: "noNetworkTitle".localized, message: "noNetworkMessage".localized)
                self.isStart.toggle()
                self.stopScanner()
            }
        })
    }
    
    private func stopScanner() {
        scanner?.stop()
        scanner?.delegate = nil
        scanner = nil
    }
    
}
