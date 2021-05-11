
import UIKit

struct Layout {
    
    let element: UIView
    
    init(_ element: UIView) {
        self.element = element
    }
    
    // MARK: Layout
    
    // MARK: - Layout ot superview
    
    @discardableResult func pinHorizontalEdgesToSuperView(leftPadding: CGFloat = 0, rightPadding: CGFloat = 0) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(leftPadding)-[view]-(rightPadding)-|",
                                                        options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                        metrics: ["leftPadding": leftPadding, "rightPadding": rightPadding],
                                                        views: ["view": element])
        safeSuperview().addConstraints(constraints)
        return constraints
    }
    
    @discardableResult func pinVerticalEdgesToSuperView(topPadding: CGFloat = 0, bottomPadding: CGFloat = 0) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(topPadding)-[view]-(bottomPadding)-|",
                                                        options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                        metrics: ["topPadding": topPadding, "bottomPadding": bottomPadding],
                                                        views: ["view": element])
        safeSuperview().addConstraints(constraints)
        return constraints
    }
    
    @discardableResult func centerSuperview() -> [NSLayoutConstraint] {
        let vertConstr = centerVertically()
        let horConstr = centerHorizontally()
        return [vertConstr, horConstr]
    }
    
    @discardableResult func centerVertically() -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: element,
                                            attribute: .centerY,
                                            relatedBy: .equal,
                                            toItem: safeSuperview(),
                                            attribute: .centerY,
                                            multiplier: 1.0, constant: 0)
        safeSuperview().addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func centerHorizontally() -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: element,
                                            attribute: .centerX,
                                            relatedBy: .equal,
                                            toItem: safeSuperview(),
                                            attribute: .centerX,
                                            multiplier: 1.0, constant: 0)
        safeSuperview().addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func pinLeftToSuperview(constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: element,
                                            attribute: .left,
                                            relatedBy: .equal,
                                            toItem: safeSuperview(),
                                            attribute: .left,
                                            multiplier: 1, constant: constant)
        
        safeSuperview().addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func pinRightToSuperview(constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: element,
                                            attribute: .right,
                                            relatedBy: .equal,
                                            toItem: safeSuperview(),
                                            attribute: .right,
                                            multiplier: 1, constant: constant)
        safeSuperview().addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func pinTopToSuperview(constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: element,
                                            attribute: .top,
                                            relatedBy: .equal,
                                            toItem: safeSuperview(),
                                            attribute: .top,
                                            multiplier: 1, constant: constant)
        safeSuperview().addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func pinBottomToSuperview(constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: element,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: safeSuperview(),
                                            attribute: .bottom,
                                            multiplier: 1, constant: constant)
        safeSuperview().addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func pinTopToView(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: element,
                                            attribute: .top,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: .top,
                                            multiplier: 1, constant: constant)
        safeSuperview().addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func pinBottomToView(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: element,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: .bottom,
                                            multiplier: 1, constant: constant)
        safeSuperview().addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func pinLeftToView(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: element,
                                            attribute: .left,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: .left,
                                            multiplier: 1, constant: constant)
        safeSuperview().addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func pinRightToView(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: element,
                                            attribute: .right,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: .right,
                                            multiplier: 1, constant: constant)
        safeSuperview().addConstraint(constraint)
        return constraint
    }
    
    func fillSuperview(inset: UIEdgeInsets = .zero) {
        safeSuperview()
        pinHorizontalEdgesToSuperView(leftPadding: inset.left, rightPadding: inset.right)
        pinVerticalEdgesToSuperView(topPadding: inset.top, bottomPadding: inset.bottom)
    }
    
    @discardableResult func heightEqualToSuperview(multiplier: CGFloat = 1.0) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: element,
                                            attribute: .height,
                                            relatedBy: .equal,
                                            toItem: safeSuperview(),
                                            attribute: .height,
                                            multiplier: multiplier, constant: 0)
        safeSuperview().addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func widthEqualToSuperview(multiplier: CGFloat = 1.0) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: element,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: safeSuperview(),
                                            attribute: .width,
                                            multiplier: multiplier, constant: 0)
        safeSuperview().addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func leftEqualToSuperview(constant: CGFloat = 0) -> NSLayoutConstraint {
        element.translatesAutoresizingMaskIntoConstraints = false
        let constraint = element.leftAnchor.constraint(equalTo: safeSuperview().leftAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func rightEqualToSuperview(constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = element.rightAnchor.constraint(equalTo: safeSuperview().rightAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func topEqualToSuperview(constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = element.topAnchor.constraint(equalTo: safeSuperview().topAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func bottomEqualToSuperview(constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = element.bottomAnchor.constraint(equalTo: safeSuperview().bottomAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    // MARK: - Layout to pins
    
    @discardableResult func widthEqualTo(_ pin: NSLayoutDimension, constant: CGFloat = 0, multiplier: CGFloat = 1.0) -> NSLayoutConstraint {
        element.translatesAutoresizingMaskIntoConstraints = false
        let constraint = element.widthAnchor.constraint(equalTo: pin, multiplier: multiplier, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func heightEqualTo(_ pin: NSLayoutDimension, constant: CGFloat = 0, multiplier: CGFloat = 1.0) -> NSLayoutConstraint {
        element.translatesAutoresizingMaskIntoConstraints = false
        let constraint = element.heightAnchor.constraint(equalTo: pin, multiplier: multiplier, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func leftEqualTo(_ pin: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        element.translatesAutoresizingMaskIntoConstraints = false
        let constraint = element.leftAnchor.constraint(equalTo: pin, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func rightEqualTo(_ pin: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        element.translatesAutoresizingMaskIntoConstraints = false
        let constraint = element.rightAnchor.constraint(equalTo: pin, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func topEqualTo(_ pin: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        element.translatesAutoresizingMaskIntoConstraints = false
        let constraint = element.topAnchor.constraint(equalTo: pin, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func bottomEqualTo(_ pin: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        element.translatesAutoresizingMaskIntoConstraints = false
        let constraint = element.bottomAnchor.constraint(equalTo: pin, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    // MARK: - Greate, less then or equel
    
    @discardableResult func topLessThenOrEquel(_ pin: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        element.translatesAutoresizingMaskIntoConstraints = false
        let constraint = element.topAnchor.constraint(lessThanOrEqualTo: pin)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func topGreaterThanOrEqual(_ pin: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        element.translatesAutoresizingMaskIntoConstraints = false
        let constraint = element.topAnchor.constraint(greaterThanOrEqualTo: pin, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func bottomLessThenOrEquel(_ pin: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        element.translatesAutoresizingMaskIntoConstraints = false
        let constraint = element.bottomAnchor.constraint(lessThanOrEqualTo: pin, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func bottomGreaterThanOrEqual(_ pin: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        element.translatesAutoresizingMaskIntoConstraints = false
        let constraint = element.bottomAnchor.constraint(greaterThanOrEqualTo: pin, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func leftLessThenOrEquel(_ pin: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        element.translatesAutoresizingMaskIntoConstraints = false
        let constraint = element.leftAnchor.constraint(lessThanOrEqualTo: pin)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func leftGreaterThanOrEqual(_ pin: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        element.translatesAutoresizingMaskIntoConstraints = false
        let constraint = element.leftAnchor.constraint(greaterThanOrEqualTo: pin, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func rightLessThenOrEquel(_ pin: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        element.translatesAutoresizingMaskIntoConstraints = false
        let constraint = element.rightAnchor.constraint(lessThanOrEqualTo: pin, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func rightGreaterThanOrEqual(_ pin: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        element.translatesAutoresizingMaskIntoConstraints = false
        let constraint = element.rightAnchor.constraint(greaterThanOrEqualTo: pin, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func topLessThenOrEquelSuperview(constant: CGFloat = 0) -> NSLayoutConstraint {
        return topLessThenOrEquel(safeSuperview().topAnchor, constant: constant)
    }
    
    @discardableResult func topGreaterThanOrEqualSuperview(constant: CGFloat = 0) -> NSLayoutConstraint {
        return topGreaterThanOrEqual(safeSuperview().topAnchor, constant: constant)
    }
    
    @discardableResult func bottomLessThenOrEquelSuperview(constant: CGFloat = 0) -> NSLayoutConstraint {
        return bottomLessThenOrEquel(safeSuperview().bottomAnchor, constant: constant)
    }
    
    @discardableResult func bottomGreaterThanOrEqualSuperview(constant: CGFloat = 0) -> NSLayoutConstraint {
        return bottomGreaterThanOrEqual(safeSuperview().bottomAnchor, constant: constant)
    }
    
    @discardableResult func leftLessThenOrEquelSuperview(constant: CGFloat = 0) -> NSLayoutConstraint {
        return leftLessThenOrEquel(safeSuperview().leftAnchor, constant: constant)
    }
    
    @discardableResult func leftGreaterThanOrEqualSuperview(constant: CGFloat = 0) -> NSLayoutConstraint {
        return leftGreaterThanOrEqual(safeSuperview().leftAnchor, constant: constant)
    }
    
    @discardableResult func rightLessThenOrEquelSuperview(constant: CGFloat = 0) -> NSLayoutConstraint {
        return rightLessThenOrEquel(safeSuperview().rightAnchor, constant: constant)
    }
    
    @discardableResult func rightGreaterThanOrEqualSuperview(constant: CGFloat = 0) -> NSLayoutConstraint {
        return rightGreaterThanOrEqual(safeSuperview().rightAnchor, constant: constant)
    }
    
    // MARK: - Layout to constants
    
    @discardableResult func heightEqualTo(_ constant: CGFloat) -> NSLayoutConstraint {
        element.translatesAutoresizingMaskIntoConstraints = false
        let constraint = element.heightAnchor.constraint(equalToConstant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func widthEqualTo(_ constant: CGFloat) -> NSLayoutConstraint {
        element.translatesAutoresizingMaskIntoConstraints = false
        let constraint = element.widthAnchor.constraint(equalToConstant: constant)
        constraint.isActive = true
        return constraint
    }
    
    func sizeEqualTo(_ size: CGSize) {
        heightEqualTo(size.height)
        widthEqualTo(size.width)
    }
}

// MARK: - Private

extension Layout {
    @discardableResult private func safeSuperview() -> UIView {
        return checkForSuperview()
    }
    
    @discardableResult private func checkForSuperview() -> UIView {
        element.translatesAutoresizingMaskIntoConstraints = false
        guard let view = element.superview else {
            fatalError("You need to have a superview before you can add contraints")
        }
        return view
    }
}

// MARK: - UIView extension

extension UIView {
    var layout: Layout {
        return Layout(self)
    }
}
