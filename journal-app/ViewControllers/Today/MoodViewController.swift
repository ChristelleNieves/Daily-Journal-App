//
//  MoodViewController.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/30/21.
//

import UIKit

class MoodViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let label = UILabel()
    private var moodSelected = false
    private let moodImages = [UIImage(named: "happy"), UIImage(named: "sad"), UIImage(named: "angry"), UIImage(named: "silly"), UIImage(named: "sleepy"), UIImage(named: "crying"), UIImage(named: "amused"), UIImage(named: "excited"), UIImage(named: "loved")]
    private var moodButtons = [UIButton]()
    
    private let moodCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 53, height: 53)
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 20)
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
        setupMoodButtons()
        setupLabel()
        setupCollectionView()
    }
}

extension MoodViewController {
    private func setupMainView() {
        view.backgroundColor = .clear
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 5
    }
    
    private func setupMoodButtons() {
        for i in 0..<moodImages.count {
            let button = UIButton()
            button.setImage(moodImages[i], for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            moodButtons.append(button)
        }
    }
    
    private func setupLabel() {
        label.text = "How are you feeling today?"
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.textColor = ThemeColor.subheading
        view.addSubview(label)
        
        // Constraints
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5)
        ])
    }
    
    private func setupCollectionView() {
        moodCollectionView.delegate = self
        moodCollectionView.dataSource = self
        moodCollectionView.register(MoodCell.self, forCellWithReuseIdentifier: "MoodCell")
        moodCollectionView.allowsSelection = true
        view.addSubview(moodCollectionView)
        
        moodCollectionView.backgroundColor = .clear
        moodCollectionView.frame = view.bounds
        
        // Constraints
        moodCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            moodCollectionView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
            moodCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moodCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moodCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MoodViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moodButtons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moodCollectionView.dequeueReusableCell(withReuseIdentifier: "MoodCell", for: indexPath) as! MoodCell
        
        cell.moodButton = moodButtons[indexPath.row]
        cell.setupMoodButton()
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if moodSelected {
            for view in moodCollectionView.visibleCells {
                let currentCell = view as? MoodCell
                currentCell?.contentView.backgroundColor = .clear
                moodSelected = false
            }
        }
        
        let cell = moodCollectionView.cellForItem(at: indexPath) as! MoodCell
        cell.contentView.backgroundColor = ThemeColor.today1.withAlphaComponent(0.70)
        moodSelected = true
    }
}
