//
//  ServicesView.swift
//  ProfileAuthorization
//
//  Created by Татьяна Исаева on 01.09.2024.
//


import UIKit
import SnapKit

class ServicesView: UIView {

	let servicesView: UIView = {
		let view = UIView()
		view.layer.cornerRadius = 8
		view.backgroundColor = .systemGray6
		
		return view
	}()

	 var servicesImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()

	 var servicesLabel: UILabel = {
		let label = UILabel()
		label.text = "Камеры"
		label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
		label.textColor = .black
		label.textAlignment = .center
		return label
	}()


	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupViews()
	}

	private func setupViews() {
		addSubview(servicesView)

		servicesView.addSubview(servicesImageView)
		servicesView.addSubview(servicesLabel)

		servicesImageView.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(10)
			make.centerX.equalToSuperview()
			make.size.equalTo(CGSize(width: 40, height: 40))
		}

		servicesLabel.snp.makeConstraints { make in
			make.bottom.equalTo(servicesView.snp.bottom).offset(-6)
			make.centerX.equalToSuperview()
			make.height.equalTo(20)
		}
		servicesView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
}
