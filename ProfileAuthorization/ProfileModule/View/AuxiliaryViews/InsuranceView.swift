//
//  InsuranceView.swift
//  ProfileAuthorization
//
//  Created by Татьяна Исаева on 01.09.2024.
//

import UIKit
import SnapKit

class InsuranceView: UIView {

	// Страхование имущества
	let firstElementView: UIView = {
		let view = UIView()
		view.layer.cornerRadius = 8
		view.backgroundColor = .white
		return view
	}()

	let firstImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "umbrella")
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()

	let firstTitleLabel: UILabel = {
		let label = UILabel()
		label.text = "Страхование"
		label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
		label.textColor = .black
		return label
	}()

	let firstSubtitleLabel: UILabel = {
		let label = UILabel()
		label.text = "Защитим имущество и здоровье"
		label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
		label.textColor = .gray
		return label
	}()

	// MARK: - Object Lifecycle
	override init(frame: CGRect = .zero) {
		super.init(frame: frame)

		setupViews()
		setupConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupViews() {
		addSubview(firstElementView)

		firstElementView.addSubview(firstImageView)
		firstElementView.addSubview(firstTitleLabel)
		firstElementView.addSubview(firstSubtitleLabel)
	}

	private func setupConstraints() {
		firstElementView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}

		firstImageView.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(16)
			make.leading.equalToSuperview().offset(16)
			make.size.equalTo(CGSize(width: 40, height: 40))
		}

		firstTitleLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(16)
			make.leading.equalTo(firstImageView.snp.trailing).offset(8)
			make.trailing.equalToSuperview().offset(-16)
		}

		firstSubtitleLabel.snp.makeConstraints { make in
			make.top.equalTo(firstTitleLabel.snp.bottom).offset(4)
			make.leading.equalTo(firstImageView.snp.trailing).offset(8)
			make.trailing.equalToSuperview().offset(-16)
			make.bottom.equalToSuperview().offset(-10)
		}
	}
}
