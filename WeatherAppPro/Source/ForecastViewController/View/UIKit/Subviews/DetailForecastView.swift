import UIKit

class DetailForecastView: UIView {
    
    let iconAndDateView = DetailForecastIconAndDateSubview()
    let detailView1 = DetailForecastSubview()
    let detailView2 = DetailForecastSubview()
    let detailView3 = DetailForecastSubview()
    let detailView4 = DetailForecastSubview()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        if Constants.showingViewBorders {
            layer.borderWidth = 1
            layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(iconAndDateView)
        addSubview(detailView1)
        addSubview(detailView2)
        addSubview(detailView3)
        addSubview(detailView4)
        
        backgroundColor = UIColor.black.withAlphaComponent(0.17)
        
        NSLayoutConstraint.activate([
            iconAndDateView.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconAndDateView.topAnchor.constraint(equalTo: topAnchor),
            iconAndDateView.widthAnchor.constraint(equalToConstant: 200),
            iconAndDateView.heightAnchor.constraint(equalToConstant: 140),
            
            detailView1.leadingAnchor.constraint(equalTo: iconAndDateView.trailingAnchor),
            detailView1.topAnchor.constraint(equalTo: topAnchor),
            detailView1.heightAnchor.constraint(equalToConstant: 65),
            detailView1.widthAnchor.constraint(equalToConstant: 90),
            
            detailView2.leadingAnchor.constraint(equalTo: iconAndDateView.trailingAnchor),
            detailView2.topAnchor.constraint(equalTo: detailView1.bottomAnchor),
            detailView2.heightAnchor.constraint(equalToConstant: 65),
            detailView2.widthAnchor.constraint(equalToConstant: 90),
            
            detailView3.leadingAnchor.constraint(equalTo: detailView1.trailingAnchor),
            detailView3.topAnchor.constraint(equalTo: topAnchor),
            detailView3.heightAnchor.constraint(equalToConstant: 65),
            detailView3.widthAnchor.constraint(equalToConstant: 90),
            
            detailView4.leadingAnchor.constraint(equalTo: detailView1.trailingAnchor),
            detailView4.topAnchor.constraint(equalTo: detailView3.bottomAnchor),
            detailView4.heightAnchor.constraint(equalToConstant: 65),
            detailView4.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    func setUpData(maxTemp: String, minTemp: String, pressure: String, wind: String, date: String, icon: String) {
        iconAndDateView.setUpData(icon: icon, date: date)
        detailView1.setUpData(title: "Max", data: maxTemp)
        detailView2.setUpData(title: "Min", data: minTemp)
        detailView3.setUpData(title: "Pressure", data: pressure)
        detailView4.setUpData(title: "Wind", data: wind)
    }
}
