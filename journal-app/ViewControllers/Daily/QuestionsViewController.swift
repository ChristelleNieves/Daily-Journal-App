//
//  QuestionsViewController.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/30/21.
//

import UIKit

class QuestionsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let questionsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 220, height: 250)
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupMainView()
        setupCollectionView()
    }

}

// MARK: Setup

extension QuestionsViewController {
    private func setupMainView() {
        view.backgroundColor = .clear
    }
    
    private func setupCollectionView() {
        questionsCollectionView.delegate = self
        questionsCollectionView.dataSource = self
        questionsCollectionView.register(QuestionCell.self, forCellWithReuseIdentifier: "QuestionCell")
        view.addSubview(questionsCollectionView)
        
        questionsCollectionView.backgroundColor = .clear
        questionsCollectionView.frame = view.bounds
        
        // Constraints
        questionsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionsCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            questionsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            questionsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            questionsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: Collection View

extension QuestionsViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = questionsCollectionView.dequeueReusableCell(withReuseIdentifier: "QuestionCell", for: indexPath) as! QuestionCell
        
        cell.question.text = dailyQuestions[indexPath.row].getQuestion()
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
}
