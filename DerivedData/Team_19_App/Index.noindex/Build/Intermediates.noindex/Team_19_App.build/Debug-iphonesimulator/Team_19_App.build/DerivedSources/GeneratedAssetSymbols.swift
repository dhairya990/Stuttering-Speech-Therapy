import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ColorResource {

}

// MARK: - Image Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ImageResource {

    /// The "Image" asset catalog image resource.
    static let image = DeveloperToolsSupport.ImageResource(name: "Image", bundle: resourceBundle)

    /// The "Image 1" asset catalog image resource.
    static let image1 = DeveloperToolsSupport.ImageResource(name: "Image 1", bundle: resourceBundle)

    /// The "Image 10" asset catalog image resource.
    static let image10 = DeveloperToolsSupport.ImageResource(name: "Image 10", bundle: resourceBundle)

    /// The "Image 11" asset catalog image resource.
    static let image11 = DeveloperToolsSupport.ImageResource(name: "Image 11", bundle: resourceBundle)

    /// The "Image 2" asset catalog image resource.
    static let image2 = DeveloperToolsSupport.ImageResource(name: "Image 2", bundle: resourceBundle)

    /// The "Image 3" asset catalog image resource.
    static let image3 = DeveloperToolsSupport.ImageResource(name: "Image 3", bundle: resourceBundle)

    /// The "Image 4" asset catalog image resource.
    static let image4 = DeveloperToolsSupport.ImageResource(name: "Image 4", bundle: resourceBundle)

    /// The "Image 5" asset catalog image resource.
    static let image5 = DeveloperToolsSupport.ImageResource(name: "Image 5", bundle: resourceBundle)

    /// The "Image 6" asset catalog image resource.
    static let image6 = DeveloperToolsSupport.ImageResource(name: "Image 6", bundle: resourceBundle)

    /// The "Image 7" asset catalog image resource.
    static let image7 = DeveloperToolsSupport.ImageResource(name: "Image 7", bundle: resourceBundle)

    /// The "Image 8" asset catalog image resource.
    static let image8 = DeveloperToolsSupport.ImageResource(name: "Image 8", bundle: resourceBundle)

    /// The "Image 9" asset catalog image resource.
    static let image9 = DeveloperToolsSupport.ImageResource(name: "Image 9", bundle: resourceBundle)

    /// The "child-studying" asset catalog image resource.
    static let childStudying = DeveloperToolsSupport.ImageResource(name: "child-studying", bundle: resourceBundle)

}

// MARK: - Color Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

}
#endif

// MARK: - Image Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    /// The "Image" asset catalog image.
    static var image: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .image)
#else
        .init()
#endif
    }

    /// The "Image 1" asset catalog image.
    static var image1: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .image1)
#else
        .init()
#endif
    }

    /// The "Image 10" asset catalog image.
    static var image10: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .image10)
#else
        .init()
#endif
    }

    /// The "Image 11" asset catalog image.
    static var image11: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .image11)
#else
        .init()
#endif
    }

    /// The "Image 2" asset catalog image.
    static var image2: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .image2)
#else
        .init()
#endif
    }

    /// The "Image 3" asset catalog image.
    static var image3: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .image3)
#else
        .init()
#endif
    }

    /// The "Image 4" asset catalog image.
    static var image4: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .image4)
#else
        .init()
#endif
    }

    /// The "Image 5" asset catalog image.
    static var image5: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .image5)
#else
        .init()
#endif
    }

    /// The "Image 6" asset catalog image.
    static var image6: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .image6)
#else
        .init()
#endif
    }

    /// The "Image 7" asset catalog image.
    static var image7: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .image7)
#else
        .init()
#endif
    }

    /// The "Image 8" asset catalog image.
    static var image8: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .image8)
#else
        .init()
#endif
    }

    /// The "Image 9" asset catalog image.
    static var image9: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .image9)
#else
        .init()
#endif
    }

    /// The "child-studying" asset catalog image.
    static var childStudying: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .childStudying)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// The "Image" asset catalog image.
    static var image: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .image)
#else
        .init()
#endif
    }

    /// The "Image 1" asset catalog image.
    static var image1: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .image1)
#else
        .init()
#endif
    }

    /// The "Image 10" asset catalog image.
    static var image10: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .image10)
#else
        .init()
#endif
    }

    /// The "Image 11" asset catalog image.
    static var image11: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .image11)
#else
        .init()
#endif
    }

    /// The "Image 2" asset catalog image.
    static var image2: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .image2)
#else
        .init()
#endif
    }

    /// The "Image 3" asset catalog image.
    static var image3: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .image3)
#else
        .init()
#endif
    }

    /// The "Image 4" asset catalog image.
    static var image4: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .image4)
#else
        .init()
#endif
    }

    /// The "Image 5" asset catalog image.
    static var image5: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .image5)
#else
        .init()
#endif
    }

    /// The "Image 6" asset catalog image.
    static var image6: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .image6)
#else
        .init()
#endif
    }

    /// The "Image 7" asset catalog image.
    static var image7: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .image7)
#else
        .init()
#endif
    }

    /// The "Image 8" asset catalog image.
    static var image8: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .image8)
#else
        .init()
#endif
    }

    /// The "Image 9" asset catalog image.
    static var image9: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .image9)
#else
        .init()
#endif
    }

    /// The "child-studying" asset catalog image.
    static var childStudying: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .childStudying)
#else
        .init()
#endif
    }

}
#endif

// MARK: - Thinnable Asset Support -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ColorResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if AppKit.NSColor(named: NSColor.Name(thinnableName), bundle: bundle) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIColor(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}
#endif

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ImageResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if bundle.image(forResource: NSImage.Name(thinnableName)) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIImage(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

