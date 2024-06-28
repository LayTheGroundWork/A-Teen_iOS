// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum DesignSystemAsset {
  public static let blackChattingIcon = DesignSystemImages(name: "blackChattingIcon")
  public static let circleButton = DesignSystemImages(name: "circleButton")
  public static let clearButton = DesignSystemImages(name: "clearButton")
  public static let clickedCircleButton = DesignSystemImages(name: "clickedCircleButton")
  public static let grayCheckButton = DesignSystemImages(name: "grayCheckButton")
  public static let instaIcon = DesignSystemImages(name: "instaIcon")
  public static let mainCheckButton = DesignSystemImages(name: "mainCheckButton")
  public static let profileBadge = DesignSystemImages(name: "profileBadge")
  public static let profileTournament = DesignSystemImages(name: "profileTournament")
  public static let arrowDownIcon = DesignSystemImages(name: "arrowDownIcon")
  public static let arrowRightSmallIcon = DesignSystemImages(name: "arrowRightSmallIcon")
  public static let blockIcon = DesignSystemImages(name: "blockIcon")
  public static let chattingIcon = DesignSystemImages(name: "chattingIcon")
  public static let crownIcon = DesignSystemImages(name: "crownIcon")
  public static let crownWhiteIcon = DesignSystemImages(name: "crownWhiteIcon")
  public static let heartIcon = DesignSystemImages(name: "heartIcon")
  public static let leftArrowIcon = DesignSystemImages(name: "leftArrowIcon")
  public static let menuIcon = DesignSystemImages(name: "menuIcon")
  public static let moreIcon = DesignSystemImages(name: "moreIcon")
  public static let plusIcon = DesignSystemImages(name: "plusIcon")
  public static let reportIcon = DesignSystemImages(name: "reportIcon")
  public static let rightGrayIcon = DesignSystemImages(name: "rightGrayIcon")
  public static let rightIcon = DesignSystemImages(name: "rightIcon")
  public static let schoolIcon = DesignSystemImages(name: "schoolIcon")
  public static let xMarkIcon = DesignSystemImages(name: "xMarkIcon")
  public static let xMarkWhiteIcon = DesignSystemImages(name: "xMarkWhiteIcon")
  public static let exercise = DesignSystemImages(name: "exercise")
  public static let study = DesignSystemImages(name: "study")
  public static let backgroundColor = DesignSystemColors(name: "backgroundColor")
  public static let darkYellow = DesignSystemColors(name: "darkYellow")
  public static let gray01 = DesignSystemColors(name: "gray01")
  public static let gray02 = DesignSystemColors(name: "gray02")
  public static let gray03 = DesignSystemColors(name: "gray03")
  public static let grayDark = DesignSystemColors(name: "grayDark")
  public static let mainColor = DesignSystemColors(name: "mainColor")
  public static let subColor = DesignSystemColors(name: "subColor")
  public static let mainLogo = DesignSystemImages(name: "mainLogo")
  public static let grayButtonColor = DesignSystemColors(name: "grayButtonColor")
  public static let grayLineColor = DesignSystemColors(name: "grayLineColor")
  public static let grayMbtiCellColor = DesignSystemColors(name: "grayMbtiCellColor")
  public static let grayTextColor = DesignSystemColors(name: "grayTextColor")
  public static let mainOrangeColor = DesignSystemColors(name: "mainOrangeColor")
  public static let mainPartBorderColor = DesignSystemColors(name: "mainPartBorderColor")
  public static let blackGlass = DesignSystemImages(name: "blackGlass")
  public static let dressGlass = DesignSystemImages(name: "dressGlass")
  public static let nightGlass = DesignSystemImages(name: "nightGlass")
  public static let skyGlass = DesignSystemImages(name: "skyGlass")
  public static let whiteGlass = DesignSystemImages(name: "whiteGlass")
  public static let chatIcon = DesignSystemImages(name: "chatIcon")
  public static let chatIconSelected = DesignSystemImages(name: "chatIconSelected")
  public static let mainIcon = DesignSystemImages(name: "mainIcon")
  public static let mainIconSelected = DesignSystemImages(name: "mainIconSelected")
  public static let profile = DesignSystemImages(name: "profile")
  public static let rankingIcon = DesignSystemImages(name: "rankingIcon")
  public static let rankingIconSelected = DesignSystemImages(name: "rankingIconSelected")
  public static let teenIcon = DesignSystemImages(name: "teenIcon")
  public static let teenIconSelected = DesignSystemImages(name: "teenIconSelected")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class DesignSystemColors {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, visionOS 1.0, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if canImport(SwiftUI)
  private var _swiftUIColor: Any? = nil
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
  public private(set) var swiftUIColor: SwiftUI.Color {
    get {
      if self._swiftUIColor == nil {
        self._swiftUIColor = SwiftUI.Color(asset: self)
      }

      return self._swiftUIColor as! SwiftUI.Color
    }
    set {
      self._swiftUIColor = newValue
    }
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension DesignSystemColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, visionOS 1.0, *)
  convenience init?(asset: DesignSystemColors) {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS) || os(visionOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
public extension SwiftUI.Color {
  init(asset: DesignSystemColors) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct DesignSystemImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS) || os(visionOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
public extension SwiftUI.Image {
  init(asset: DesignSystemImages) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }

  init(asset: DesignSystemImages, label: Text) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: DesignSystemImages) {
    let bundle = Bundle.module
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:enable all
// swiftformat:enable all
