import UIKit

class LandingViewButton: UIButton {
    var title: String?
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    private func setup() {
        layer.borderWidth = 1
        layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        setTitleColor(Constants.fontColor, for: .normal)
        setTitle(title, for: .normal)
        addTarget(self, action: #selector(buttonPressed), for: .touchDown)
    }
    
    @objc private func buttonPressed(button: UIButton) {
        UIButton.animate(withDuration: 0.6, animations: {
            button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        },
                         completion: { _ in
            UIView.animate(withDuration: 0.3) {
                button.transform = CGAffineTransform.identity
            }
        })
    }
}


