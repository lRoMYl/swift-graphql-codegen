// @generated
// Do not edit this generated file
// swiftlint:disable all

import Foundation

enum BigCommerceGraphQL {}

extension BigCommerceGraphQL {
  // MARK: - Enums

  /// Product sorting by categories.
  enum CategoryProductSort: RawRepresentable, CaseIterable, Codable {
    typealias RawValue = String

    case `default`

    case featured

    case newest

    case bestSelling

    case aToZ

    case zToA

    case bestReviewed

    case lowestPrice

    case highestPrice

    /// Auto generated constant for unknown enum values
    case _unknown(RawValue)

    public init?(rawValue: RawValue) {
      switch rawValue {
      case "DEFAULT": self = .default
      case "FEATURED": self = .featured
      case "NEWEST": self = .newest
      case "BEST_SELLING": self = .bestSelling
      case "A_TO_Z": self = .aToZ
      case "Z_TO_A": self = .zToA
      case "BEST_REVIEWED": self = .bestReviewed
      case "LOWEST_PRICE": self = .lowestPrice
      case "HIGHEST_PRICE": self = .highestPrice
      default: self = ._unknown(rawValue)
      }
    }

    public var rawValue: RawValue {
      switch self {
      case .default: return "DEFAULT"
      case .featured: return "FEATURED"
      case .newest: return "NEWEST"
      case .bestSelling: return "BEST_SELLING"
      case .aToZ: return "A_TO_Z"
      case .zToA: return "Z_TO_A"
      case .bestReviewed: return "BEST_REVIEWED"
      case .lowestPrice: return "LOWEST_PRICE"
      case .highestPrice: return "HIGHEST_PRICE"
      case let ._unknown(value): return value
      }
    }

    static func == (lhs: CategoryProductSort, rhs: CategoryProductSort) -> Bool {
      switch (lhs, rhs) {
      case (.default, .default): return true
      case (.featured, .featured): return true
      case (.newest, .newest): return true
      case (.bestSelling, .bestSelling): return true
      case (.aToZ, .aToZ): return true
      case (.zToA, .zToA): return true
      case (.bestReviewed, .bestReviewed): return true
      case (.lowestPrice, .lowestPrice): return true
      case (.highestPrice, .highestPrice): return true
      case let (._unknown(lhsValue), ._unknown(rhsValue)): return lhsValue == rhsValue
      default: return false
      }
    }

    static var allCases: [CategoryProductSort] {
      return [
        .default,
        .featured,
        .newest,
        .bestSelling,
        .aToZ,
        .zToA,
        .bestReviewed,
        .lowestPrice,
        .highestPrice
      ]
    }
  }

  /// Currency symbol position
  enum CurrencySymbolPosition: RawRepresentable, CaseIterable, Codable {
    typealias RawValue = String

    case left

    case right

    /// Auto generated constant for unknown enum values
    case _unknown(RawValue)

    public init?(rawValue: RawValue) {
      switch rawValue {
      case "LEFT": self = .left
      case "RIGHT": self = .right
      default: self = ._unknown(rawValue)
      }
    }

    public var rawValue: RawValue {
      switch self {
      case .left: return "LEFT"
      case .right: return "RIGHT"
      case let ._unknown(value): return value
      }
    }

    static func == (lhs: CurrencySymbolPosition, rhs: CurrencySymbolPosition) -> Bool {
      switch (lhs, rhs) {
      case (.left, .left): return true
      case (.right, .right): return true
      case let (._unknown(lhsValue), ._unknown(rhsValue)): return lhsValue == rhsValue
      default: return false
      }
    }

    static var allCases: [CurrencySymbolPosition] {
      return [
        .left,
        .right
      ]
    }
  }

  /// Entity page type
  enum EntityPageType: RawRepresentable, CaseIterable, Codable {
    typealias RawValue = String

    case blogPost

    case brand

    case category

    case contactUs

    case page

    case product

    /// Auto generated constant for unknown enum values
    case _unknown(RawValue)

    public init?(rawValue: RawValue) {
      switch rawValue {
      case "BLOG_POST": self = .blogPost
      case "BRAND": self = .brand
      case "CATEGORY": self = .category
      case "CONTACT_US": self = .contactUs
      case "PAGE": self = .page
      case "PRODUCT": self = .product
      default: self = ._unknown(rawValue)
      }
    }

    public var rawValue: RawValue {
      switch self {
      case .blogPost: return "BLOG_POST"
      case .brand: return "BRAND"
      case .category: return "CATEGORY"
      case .contactUs: return "CONTACT_US"
      case .page: return "PAGE"
      case .product: return "PRODUCT"
      case let ._unknown(value): return value
      }
    }

    static func == (lhs: EntityPageType, rhs: EntityPageType) -> Bool {
      switch (lhs, rhs) {
      case (.blogPost, .blogPost): return true
      case (.brand, .brand): return true
      case (.category, .category): return true
      case (.contactUs, .contactUs): return true
      case (.page, .page): return true
      case (.product, .product): return true
      case let (._unknown(lhsValue), ._unknown(rhsValue)): return lhsValue == rhsValue
      default: return false
      }
    }

    static var allCases: [EntityPageType] {
      return [
        .blogPost,
        .brand,
        .category,
        .contactUs,
        .page,
        .product
      ]
    }
  }

  /// length unit
  enum LengthUnit: RawRepresentable, CaseIterable, Codable {
    typealias RawValue = String

    case miles

    case kilometres

    /// Auto generated constant for unknown enum values
    case _unknown(RawValue)

    public init?(rawValue: RawValue) {
      switch rawValue {
      case "Miles": self = .miles
      case "Kilometres": self = .kilometres
      default: self = ._unknown(rawValue)
      }
    }

    public var rawValue: RawValue {
      switch self {
      case .miles: return "Miles"
      case .kilometres: return "Kilometres"
      case let ._unknown(value): return value
      }
    }

    static func == (lhs: LengthUnit, rhs: LengthUnit) -> Bool {
      switch (lhs, rhs) {
      case (.miles, .miles): return true
      case (.kilometres, .kilometres): return true
      case let (._unknown(lhsValue), ._unknown(rhsValue)): return lhsValue == rhsValue
      default: return false
      }
    }

    static var allCases: [LengthUnit] {
      return [
        .miles,
        .kilometres
      ]
    }
  }

  /// Page type
  enum PageType: RawRepresentable, CaseIterable, Codable {
    typealias RawValue = String

    case accountAddress

    case accountAddAddress

    case accountAddReturn

    case accountAddWishlist

    case accountDownloadItem

    case accountEdit

    case accountInbox

    case accountOrdersAll

    case accountOrdersCompleted

    case accountOrdersDetails

    case accountOrdersInvoice

    case accountRecentItems

    case accountReturns

    case accountReturnSaved

    case accountWishlists

    case accountWishlistDetails

    case authAccountCreated

    case authCreateAcc

    case authForgotPass

    case authLogin

    case authNewPass

    case blog

    case brands

    case cart

    case compare

    case giftCertBalance

    case giftCertPurchase

    case giftCertRedeem

    case home

    case orderInfo

    case search

    case sitemap

    case subscribed

    case unsubscribe

    /// Auto generated constant for unknown enum values
    case _unknown(RawValue)

    public init?(rawValue: RawValue) {
      switch rawValue {
      case "ACCOUNT_ADDRESS": self = .accountAddress
      case "ACCOUNT_ADD_ADDRESS": self = .accountAddAddress
      case "ACCOUNT_ADD_RETURN": self = .accountAddReturn
      case "ACCOUNT_ADD_WISHLIST": self = .accountAddWishlist
      case "ACCOUNT_DOWNLOAD_ITEM": self = .accountDownloadItem
      case "ACCOUNT_EDIT": self = .accountEdit
      case "ACCOUNT_INBOX": self = .accountInbox
      case "ACCOUNT_ORDERS_ALL": self = .accountOrdersAll
      case "ACCOUNT_ORDERS_COMPLETED": self = .accountOrdersCompleted
      case "ACCOUNT_ORDERS_DETAILS": self = .accountOrdersDetails
      case "ACCOUNT_ORDERS_INVOICE": self = .accountOrdersInvoice
      case "ACCOUNT_RECENT_ITEMS": self = .accountRecentItems
      case "ACCOUNT_RETURNS": self = .accountReturns
      case "ACCOUNT_RETURN_SAVED": self = .accountReturnSaved
      case "ACCOUNT_WISHLISTS": self = .accountWishlists
      case "ACCOUNT_WISHLIST_DETAILS": self = .accountWishlistDetails
      case "AUTH_ACCOUNT_CREATED": self = .authAccountCreated
      case "AUTH_CREATE_ACC": self = .authCreateAcc
      case "AUTH_FORGOT_PASS": self = .authForgotPass
      case "AUTH_LOGIN": self = .authLogin
      case "AUTH_NEW_PASS": self = .authNewPass
      case "BLOG": self = .blog
      case "BRANDS": self = .brands
      case "CART": self = .cart
      case "COMPARE": self = .compare
      case "GIFT_CERT_BALANCE": self = .giftCertBalance
      case "GIFT_CERT_PURCHASE": self = .giftCertPurchase
      case "GIFT_CERT_REDEEM": self = .giftCertRedeem
      case "HOME": self = .home
      case "ORDER_INFO": self = .orderInfo
      case "SEARCH": self = .search
      case "SITEMAP": self = .sitemap
      case "SUBSCRIBED": self = .subscribed
      case "UNSUBSCRIBE": self = .unsubscribe
      default: self = ._unknown(rawValue)
      }
    }

    public var rawValue: RawValue {
      switch self {
      case .accountAddress: return "ACCOUNT_ADDRESS"
      case .accountAddAddress: return "ACCOUNT_ADD_ADDRESS"
      case .accountAddReturn: return "ACCOUNT_ADD_RETURN"
      case .accountAddWishlist: return "ACCOUNT_ADD_WISHLIST"
      case .accountDownloadItem: return "ACCOUNT_DOWNLOAD_ITEM"
      case .accountEdit: return "ACCOUNT_EDIT"
      case .accountInbox: return "ACCOUNT_INBOX"
      case .accountOrdersAll: return "ACCOUNT_ORDERS_ALL"
      case .accountOrdersCompleted: return "ACCOUNT_ORDERS_COMPLETED"
      case .accountOrdersDetails: return "ACCOUNT_ORDERS_DETAILS"
      case .accountOrdersInvoice: return "ACCOUNT_ORDERS_INVOICE"
      case .accountRecentItems: return "ACCOUNT_RECENT_ITEMS"
      case .accountReturns: return "ACCOUNT_RETURNS"
      case .accountReturnSaved: return "ACCOUNT_RETURN_SAVED"
      case .accountWishlists: return "ACCOUNT_WISHLISTS"
      case .accountWishlistDetails: return "ACCOUNT_WISHLIST_DETAILS"
      case .authAccountCreated: return "AUTH_ACCOUNT_CREATED"
      case .authCreateAcc: return "AUTH_CREATE_ACC"
      case .authForgotPass: return "AUTH_FORGOT_PASS"
      case .authLogin: return "AUTH_LOGIN"
      case .authNewPass: return "AUTH_NEW_PASS"
      case .blog: return "BLOG"
      case .brands: return "BRANDS"
      case .cart: return "CART"
      case .compare: return "COMPARE"
      case .giftCertBalance: return "GIFT_CERT_BALANCE"
      case .giftCertPurchase: return "GIFT_CERT_PURCHASE"
      case .giftCertRedeem: return "GIFT_CERT_REDEEM"
      case .home: return "HOME"
      case .orderInfo: return "ORDER_INFO"
      case .search: return "SEARCH"
      case .sitemap: return "SITEMAP"
      case .subscribed: return "SUBSCRIBED"
      case .unsubscribe: return "UNSUBSCRIBE"
      case let ._unknown(value): return value
      }
    }

    static func == (lhs: PageType, rhs: PageType) -> Bool {
      switch (lhs, rhs) {
      case (.accountAddress, .accountAddress): return true
      case (.accountAddAddress, .accountAddAddress): return true
      case (.accountAddReturn, .accountAddReturn): return true
      case (.accountAddWishlist, .accountAddWishlist): return true
      case (.accountDownloadItem, .accountDownloadItem): return true
      case (.accountEdit, .accountEdit): return true
      case (.accountInbox, .accountInbox): return true
      case (.accountOrdersAll, .accountOrdersAll): return true
      case (.accountOrdersCompleted, .accountOrdersCompleted): return true
      case (.accountOrdersDetails, .accountOrdersDetails): return true
      case (.accountOrdersInvoice, .accountOrdersInvoice): return true
      case (.accountRecentItems, .accountRecentItems): return true
      case (.accountReturns, .accountReturns): return true
      case (.accountReturnSaved, .accountReturnSaved): return true
      case (.accountWishlists, .accountWishlists): return true
      case (.accountWishlistDetails, .accountWishlistDetails): return true
      case (.authAccountCreated, .authAccountCreated): return true
      case (.authCreateAcc, .authCreateAcc): return true
      case (.authForgotPass, .authForgotPass): return true
      case (.authLogin, .authLogin): return true
      case (.authNewPass, .authNewPass): return true
      case (.blog, .blog): return true
      case (.brands, .brands): return true
      case (.cart, .cart): return true
      case (.compare, .compare): return true
      case (.giftCertBalance, .giftCertBalance): return true
      case (.giftCertPurchase, .giftCertPurchase): return true
      case (.giftCertRedeem, .giftCertRedeem): return true
      case (.home, .home): return true
      case (.orderInfo, .orderInfo): return true
      case (.search, .search): return true
      case (.sitemap, .sitemap): return true
      case (.subscribed, .subscribed): return true
      case (.unsubscribe, .unsubscribe): return true
      case let (._unknown(lhsValue), ._unknown(rhsValue)): return lhsValue == rhsValue
      default: return false
      }
    }

    static var allCases: [PageType] {
      return [
        .accountAddress,
        .accountAddAddress,
        .accountAddReturn,
        .accountAddWishlist,
        .accountDownloadItem,
        .accountEdit,
        .accountInbox,
        .accountOrdersAll,
        .accountOrdersCompleted,
        .accountOrdersDetails,
        .accountOrdersInvoice,
        .accountRecentItems,
        .accountReturns,
        .accountReturnSaved,
        .accountWishlists,
        .accountWishlistDetails,
        .authAccountCreated,
        .authCreateAcc,
        .authForgotPass,
        .authLogin,
        .authNewPass,
        .blog,
        .brands,
        .cart,
        .compare,
        .giftCertBalance,
        .giftCertPurchase,
        .giftCertRedeem,
        .home,
        .orderInfo,
        .search,
        .sitemap,
        .subscribed,
        .unsubscribe
      ]
    }
  }

  /// Product availability status
  enum ProductAvailabilityStatus: RawRepresentable, CaseIterable, Codable {
    typealias RawValue = String

    case available

    case preorder

    case unavailable

    /// Auto generated constant for unknown enum values
    case _unknown(RawValue)

    public init?(rawValue: RawValue) {
      switch rawValue {
      case "Available": self = .available
      case "Preorder": self = .preorder
      case "Unavailable": self = .unavailable
      default: self = ._unknown(rawValue)
      }
    }

    public var rawValue: RawValue {
      switch self {
      case .available: return "Available"
      case .preorder: return "Preorder"
      case .unavailable: return "Unavailable"
      case let ._unknown(value): return value
      }
    }

    static func == (lhs: ProductAvailabilityStatus, rhs: ProductAvailabilityStatus) -> Bool {
      switch (lhs, rhs) {
      case (.available, .available): return true
      case (.preorder, .preorder): return true
      case (.unavailable, .unavailable): return true
      case let (._unknown(lhsValue), ._unknown(rhsValue)): return lhsValue == rhsValue
      default: return false
      }
    }

    static var allCases: [ProductAvailabilityStatus] {
      return [
        .available,
        .preorder,
        .unavailable
      ]
    }
  }

  /// ProductReviewsSortInput
  enum ProductReviewsSortInput: RawRepresentable, CaseIterable, Codable {
    typealias RawValue = String

    case newest

    case oldest

    case highestRating

    case lowestRating

    /// Auto generated constant for unknown enum values
    case _unknown(RawValue)

    public init?(rawValue: RawValue) {
      switch rawValue {
      case "NEWEST": self = .newest
      case "OLDEST": self = .oldest
      case "HIGHEST_RATING": self = .highestRating
      case "LOWEST_RATING": self = .lowestRating
      default: self = ._unknown(rawValue)
      }
    }

    public var rawValue: RawValue {
      switch self {
      case .newest: return "NEWEST"
      case .oldest: return "OLDEST"
      case .highestRating: return "HIGHEST_RATING"
      case .lowestRating: return "LOWEST_RATING"
      case let ._unknown(value): return value
      }
    }

    static func == (lhs: ProductReviewsSortInput, rhs: ProductReviewsSortInput) -> Bool {
      switch (lhs, rhs) {
      case (.newest, .newest): return true
      case (.oldest, .oldest): return true
      case (.highestRating, .highestRating): return true
      case (.lowestRating, .lowestRating): return true
      case let (._unknown(lhsValue), ._unknown(rhsValue)): return lhsValue == rhsValue
      default: return false
      }
    }

    static var allCases: [ProductReviewsSortInput] {
      return [
        .newest,
        .oldest,
        .highestRating,
        .lowestRating
      ]
    }
  }

  /// SearchProductsSortInput
  enum SearchProductsSortInput: RawRepresentable, CaseIterable, Codable {
    typealias RawValue = String

    case featured

    case newest

    case bestSelling

    case bestReviewed

    case aToZ

    case zToA

    case lowestPrice

    case highestPrice

    /// Auto generated constant for unknown enum values
    case _unknown(RawValue)

    public init?(rawValue: RawValue) {
      switch rawValue {
      case "FEATURED": self = .featured
      case "NEWEST": self = .newest
      case "BEST_SELLING": self = .bestSelling
      case "BEST_REVIEWED": self = .bestReviewed
      case "A_TO_Z": self = .aToZ
      case "Z_TO_A": self = .zToA
      case "LOWEST_PRICE": self = .lowestPrice
      case "HIGHEST_PRICE": self = .highestPrice
      default: self = ._unknown(rawValue)
      }
    }

    public var rawValue: RawValue {
      switch self {
      case .featured: return "FEATURED"
      case .newest: return "NEWEST"
      case .bestSelling: return "BEST_SELLING"
      case .bestReviewed: return "BEST_REVIEWED"
      case .aToZ: return "A_TO_Z"
      case .zToA: return "Z_TO_A"
      case .lowestPrice: return "LOWEST_PRICE"
      case .highestPrice: return "HIGHEST_PRICE"
      case let ._unknown(value): return value
      }
    }

    static func == (lhs: SearchProductsSortInput, rhs: SearchProductsSortInput) -> Bool {
      switch (lhs, rhs) {
      case (.featured, .featured): return true
      case (.newest, .newest): return true
      case (.bestSelling, .bestSelling): return true
      case (.bestReviewed, .bestReviewed): return true
      case (.aToZ, .aToZ): return true
      case (.zToA, .zToA): return true
      case (.lowestPrice, .lowestPrice): return true
      case (.highestPrice, .highestPrice): return true
      case let (._unknown(lhsValue), ._unknown(rhsValue)): return lhsValue == rhsValue
      default: return false
      }
    }

    static var allCases: [SearchProductsSortInput] {
      return [
        .featured,
        .newest,
        .bestSelling,
        .bestReviewed,
        .aToZ,
        .zToA,
        .lowestPrice,
        .highestPrice
      ]
    }
  }

  /// Storefront Mode
  enum StorefrontStatusType: RawRepresentable, CaseIterable, Codable {
    typealias RawValue = String

    case launched

    case maintenance

    case preLaunch

    case hibernation

    /// Auto generated constant for unknown enum values
    case _unknown(RawValue)

    public init?(rawValue: RawValue) {
      switch rawValue {
      case "LAUNCHED": self = .launched
      case "MAINTENANCE": self = .maintenance
      case "PRE_LAUNCH": self = .preLaunch
      case "HIBERNATION": self = .hibernation
      default: self = ._unknown(rawValue)
      }
    }

    public var rawValue: RawValue {
      switch self {
      case .launched: return "LAUNCHED"
      case .maintenance: return "MAINTENANCE"
      case .preLaunch: return "PRE_LAUNCH"
      case .hibernation: return "HIBERNATION"
      case let ._unknown(value): return value
      }
    }

    static func == (lhs: StorefrontStatusType, rhs: StorefrontStatusType) -> Bool {
      switch (lhs, rhs) {
      case (.launched, .launched): return true
      case (.maintenance, .maintenance): return true
      case (.preLaunch, .preLaunch): return true
      case (.hibernation, .hibernation): return true
      case let (._unknown(lhsValue), ._unknown(rhsValue)): return lhsValue == rhsValue
      default: return false
      }
    }

    static var allCases: [StorefrontStatusType] {
      return [
        .launched,
        .maintenance,
        .preLaunch,
        .hibernation
      ]
    }
  }

  /// Tax setting can be set included or excluded (Tax setting can also be set to both on PDP/PLP).
  enum TaxPriceDisplay: RawRepresentable, CaseIterable, Codable {
    typealias RawValue = String

    case inc

    case ex

    case both

    /// Auto generated constant for unknown enum values
    case _unknown(RawValue)

    public init?(rawValue: RawValue) {
      switch rawValue {
      case "INC": self = .inc
      case "EX": self = .ex
      case "BOTH": self = .both
      default: self = ._unknown(rawValue)
      }
    }

    public var rawValue: RawValue {
      switch self {
      case .inc: return "INC"
      case .ex: return "EX"
      case .both: return "BOTH"
      case let ._unknown(value): return value
      }
    }

    static func == (lhs: TaxPriceDisplay, rhs: TaxPriceDisplay) -> Bool {
      switch (lhs, rhs) {
      case (.inc, .inc): return true
      case (.ex, .ex): return true
      case (.both, .both): return true
      case let (._unknown(lhsValue), ._unknown(rhsValue)): return lhsValue == rhsValue
      default: return false
      }
    }

    static var allCases: [TaxPriceDisplay] {
      return [
        .inc,
        .ex,
        .both
      ]
    }
  }

  /// Country Code
  enum CountryCode: RawRepresentable, CaseIterable, Codable {
    typealias RawValue = String

    case aw

    case af

    case ao

    case ai

    case ax

    case al

    case ad

    case ae

    case ar

    case am

    case `as`

    case aq

    case tf

    case ag

    case au

    case at

    case az

    case bi

    case be

    case bj

    case bq

    case bf

    case bd

    case bg

    case bh

    case bs

    case ba

    case bl

    case by

    case bz

    case bm

    case bo

    case br

    case bb

    case bn

    case bt

    case bv

    case bw

    case cf

    case ca

    case cc

    case ch

    case cl

    case cn

    case ci

    case cm

    case cd

    case cg

    case ck

    case co

    case km

    case cv

    case cr

    case cu

    case cw

    case cx

    case ky

    case cy

    case cz

    case de

    case dj

    case dm

    case dk

    case `do`

    case dz

    case ec

    case eg

    case er

    case eh

    case es

    case ee

    case et

    case fi

    case fj

    case fk

    case fr

    case fo

    case fm

    case ga

    case gb

    case ge

    case gg

    case gh

    case gi

    case gn

    case gp

    case gm

    case gw

    case gq

    case gr

    case gd

    case gl

    case gt

    case gf

    case gu

    case gy

    case hk

    case hm

    case hn

    case hr

    case ht

    case hu

    case id

    case im

    case `in`

    case io

    case ie

    case ir

    case iq

    case `is`

    case il

    case it

    case jm

    case je

    case jo

    case jp

    case kz

    case ke

    case kg

    case kh

    case ki

    case kn

    case kr

    case kw

    case la

    case lb

    case lr

    case ly

    case lc

    case li

    case lk

    case ls

    case lt

    case lu

    case lv

    case mo

    case mf

    case ma

    case mc

    case md

    case mg

    case mv

    case mx

    case mh

    case mk

    case ml

    case mt

    case mm

    case me

    case mn

    case mp

    case mz

    case mr

    case ms

    case mq

    case mu

    case mw

    case my

    case yt

    case na

    case nc

    case ne

    case nf

    case ng

    case ni

    case nu

    case nl

    case no

    case np

    case nr

    case nz

    case om

    case pk

    case pa

    case pn

    case pe

    case ph

    case pw

    case pg

    case pl

    case pr

    case kp

    case pt

    case py

    case ps

    case pf

    case qa

    case re

    case ro

    case ru

    case rw

    case sa

    case sd

    case sn

    case sg

    case gs

    case sh

    case sj

    case sb

    case sl

    case sv

    case sm

    case so

    case pm

    case rs

    case ss

    case st

    case sr

    case sk

    case si

    case se

    case sz

    case sx

    case sc

    case sy

    case tc

    case td

    case tg

    case th

    case tj

    case tk

    case tm

    case tl

    case to

    case tt

    case tn

    case tr

    case tv

    case tw

    case tz

    case ug

    case ua

    case um

    case uy

    case us

    case uz

    case va

    case vc

    case ve

    case vg

    case vi

    case vn

    case vu

    case wf

    case ws

    case ye

    case za

    case zm

    case zw

    /// Auto generated constant for unknown enum values
    case _unknown(RawValue)

    public init?(rawValue: RawValue) {
      switch rawValue {
      case "AW": self = .aw
      case "AF": self = .af
      case "AO": self = .ao
      case "AI": self = .ai
      case "AX": self = .ax
      case "AL": self = .al
      case "AD": self = .ad
      case "AE": self = .ae
      case "AR": self = .ar
      case "AM": self = .am
      case "AS": self = .as
      case "AQ": self = .aq
      case "TF": self = .tf
      case "AG": self = .ag
      case "AU": self = .au
      case "AT": self = .at
      case "AZ": self = .az
      case "BI": self = .bi
      case "BE": self = .be
      case "BJ": self = .bj
      case "BQ": self = .bq
      case "BF": self = .bf
      case "BD": self = .bd
      case "BG": self = .bg
      case "BH": self = .bh
      case "BS": self = .bs
      case "BA": self = .ba
      case "BL": self = .bl
      case "BY": self = .by
      case "BZ": self = .bz
      case "BM": self = .bm
      case "BO": self = .bo
      case "BR": self = .br
      case "BB": self = .bb
      case "BN": self = .bn
      case "BT": self = .bt
      case "BV": self = .bv
      case "BW": self = .bw
      case "CF": self = .cf
      case "CA": self = .ca
      case "CC": self = .cc
      case "CH": self = .ch
      case "CL": self = .cl
      case "CN": self = .cn
      case "CI": self = .ci
      case "CM": self = .cm
      case "CD": self = .cd
      case "CG": self = .cg
      case "CK": self = .ck
      case "CO": self = .co
      case "KM": self = .km
      case "CV": self = .cv
      case "CR": self = .cr
      case "CU": self = .cu
      case "CW": self = .cw
      case "CX": self = .cx
      case "KY": self = .ky
      case "CY": self = .cy
      case "CZ": self = .cz
      case "DE": self = .de
      case "DJ": self = .dj
      case "DM": self = .dm
      case "DK": self = .dk
      case "DO": self = .do
      case "DZ": self = .dz
      case "EC": self = .ec
      case "EG": self = .eg
      case "ER": self = .er
      case "EH": self = .eh
      case "ES": self = .es
      case "EE": self = .ee
      case "ET": self = .et
      case "FI": self = .fi
      case "FJ": self = .fj
      case "FK": self = .fk
      case "FR": self = .fr
      case "FO": self = .fo
      case "FM": self = .fm
      case "GA": self = .ga
      case "GB": self = .gb
      case "GE": self = .ge
      case "GG": self = .gg
      case "GH": self = .gh
      case "GI": self = .gi
      case "GN": self = .gn
      case "GP": self = .gp
      case "GM": self = .gm
      case "GW": self = .gw
      case "GQ": self = .gq
      case "GR": self = .gr
      case "GD": self = .gd
      case "GL": self = .gl
      case "GT": self = .gt
      case "GF": self = .gf
      case "GU": self = .gu
      case "GY": self = .gy
      case "HK": self = .hk
      case "HM": self = .hm
      case "HN": self = .hn
      case "HR": self = .hr
      case "HT": self = .ht
      case "HU": self = .hu
      case "ID": self = .id
      case "IM": self = .im
      case "IN": self = .in
      case "IO": self = .io
      case "IE": self = .ie
      case "IR": self = .ir
      case "IQ": self = .iq
      case "IS": self = .is
      case "IL": self = .il
      case "IT": self = .it
      case "JM": self = .jm
      case "JE": self = .je
      case "JO": self = .jo
      case "JP": self = .jp
      case "KZ": self = .kz
      case "KE": self = .ke
      case "KG": self = .kg
      case "KH": self = .kh
      case "KI": self = .ki
      case "KN": self = .kn
      case "KR": self = .kr
      case "KW": self = .kw
      case "LA": self = .la
      case "LB": self = .lb
      case "LR": self = .lr
      case "LY": self = .ly
      case "LC": self = .lc
      case "LI": self = .li
      case "LK": self = .lk
      case "LS": self = .ls
      case "LT": self = .lt
      case "LU": self = .lu
      case "LV": self = .lv
      case "MO": self = .mo
      case "MF": self = .mf
      case "MA": self = .ma
      case "MC": self = .mc
      case "MD": self = .md
      case "MG": self = .mg
      case "MV": self = .mv
      case "MX": self = .mx
      case "MH": self = .mh
      case "MK": self = .mk
      case "ML": self = .ml
      case "MT": self = .mt
      case "MM": self = .mm
      case "ME": self = .me
      case "MN": self = .mn
      case "MP": self = .mp
      case "MZ": self = .mz
      case "MR": self = .mr
      case "MS": self = .ms
      case "MQ": self = .mq
      case "MU": self = .mu
      case "MW": self = .mw
      case "MY": self = .my
      case "YT": self = .yt
      case "NA": self = .na
      case "NC": self = .nc
      case "NE": self = .ne
      case "NF": self = .nf
      case "NG": self = .ng
      case "NI": self = .ni
      case "NU": self = .nu
      case "NL": self = .nl
      case "NO": self = .no
      case "NP": self = .np
      case "NR": self = .nr
      case "NZ": self = .nz
      case "OM": self = .om
      case "PK": self = .pk
      case "PA": self = .pa
      case "PN": self = .pn
      case "PE": self = .pe
      case "PH": self = .ph
      case "PW": self = .pw
      case "PG": self = .pg
      case "PL": self = .pl
      case "PR": self = .pr
      case "KP": self = .kp
      case "PT": self = .pt
      case "PY": self = .py
      case "PS": self = .ps
      case "PF": self = .pf
      case "QA": self = .qa
      case "RE": self = .re
      case "RO": self = .ro
      case "RU": self = .ru
      case "RW": self = .rw
      case "SA": self = .sa
      case "SD": self = .sd
      case "SN": self = .sn
      case "SG": self = .sg
      case "GS": self = .gs
      case "SH": self = .sh
      case "SJ": self = .sj
      case "SB": self = .sb
      case "SL": self = .sl
      case "SV": self = .sv
      case "SM": self = .sm
      case "SO": self = .so
      case "PM": self = .pm
      case "RS": self = .rs
      case "SS": self = .ss
      case "ST": self = .st
      case "SR": self = .sr
      case "SK": self = .sk
      case "SI": self = .si
      case "SE": self = .se
      case "SZ": self = .sz
      case "SX": self = .sx
      case "SC": self = .sc
      case "SY": self = .sy
      case "TC": self = .tc
      case "TD": self = .td
      case "TG": self = .tg
      case "TH": self = .th
      case "TJ": self = .tj
      case "TK": self = .tk
      case "TM": self = .tm
      case "TL": self = .tl
      case "TO": self = .to
      case "TT": self = .tt
      case "TN": self = .tn
      case "TR": self = .tr
      case "TV": self = .tv
      case "TW": self = .tw
      case "TZ": self = .tz
      case "UG": self = .ug
      case "UA": self = .ua
      case "UM": self = .um
      case "UY": self = .uy
      case "US": self = .us
      case "UZ": self = .uz
      case "VA": self = .va
      case "VC": self = .vc
      case "VE": self = .ve
      case "VG": self = .vg
      case "VI": self = .vi
      case "VN": self = .vn
      case "VU": self = .vu
      case "WF": self = .wf
      case "WS": self = .ws
      case "YE": self = .ye
      case "ZA": self = .za
      case "ZM": self = .zm
      case "ZW": self = .zw
      default: self = ._unknown(rawValue)
      }
    }

    public var rawValue: RawValue {
      switch self {
      case .aw: return "AW"
      case .af: return "AF"
      case .ao: return "AO"
      case .ai: return "AI"
      case .ax: return "AX"
      case .al: return "AL"
      case .ad: return "AD"
      case .ae: return "AE"
      case .ar: return "AR"
      case .am: return "AM"
      case .as: return "AS"
      case .aq: return "AQ"
      case .tf: return "TF"
      case .ag: return "AG"
      case .au: return "AU"
      case .at: return "AT"
      case .az: return "AZ"
      case .bi: return "BI"
      case .be: return "BE"
      case .bj: return "BJ"
      case .bq: return "BQ"
      case .bf: return "BF"
      case .bd: return "BD"
      case .bg: return "BG"
      case .bh: return "BH"
      case .bs: return "BS"
      case .ba: return "BA"
      case .bl: return "BL"
      case .by: return "BY"
      case .bz: return "BZ"
      case .bm: return "BM"
      case .bo: return "BO"
      case .br: return "BR"
      case .bb: return "BB"
      case .bn: return "BN"
      case .bt: return "BT"
      case .bv: return "BV"
      case .bw: return "BW"
      case .cf: return "CF"
      case .ca: return "CA"
      case .cc: return "CC"
      case .ch: return "CH"
      case .cl: return "CL"
      case .cn: return "CN"
      case .ci: return "CI"
      case .cm: return "CM"
      case .cd: return "CD"
      case .cg: return "CG"
      case .ck: return "CK"
      case .co: return "CO"
      case .km: return "KM"
      case .cv: return "CV"
      case .cr: return "CR"
      case .cu: return "CU"
      case .cw: return "CW"
      case .cx: return "CX"
      case .ky: return "KY"
      case .cy: return "CY"
      case .cz: return "CZ"
      case .de: return "DE"
      case .dj: return "DJ"
      case .dm: return "DM"
      case .dk: return "DK"
      case .do: return "DO"
      case .dz: return "DZ"
      case .ec: return "EC"
      case .eg: return "EG"
      case .er: return "ER"
      case .eh: return "EH"
      case .es: return "ES"
      case .ee: return "EE"
      case .et: return "ET"
      case .fi: return "FI"
      case .fj: return "FJ"
      case .fk: return "FK"
      case .fr: return "FR"
      case .fo: return "FO"
      case .fm: return "FM"
      case .ga: return "GA"
      case .gb: return "GB"
      case .ge: return "GE"
      case .gg: return "GG"
      case .gh: return "GH"
      case .gi: return "GI"
      case .gn: return "GN"
      case .gp: return "GP"
      case .gm: return "GM"
      case .gw: return "GW"
      case .gq: return "GQ"
      case .gr: return "GR"
      case .gd: return "GD"
      case .gl: return "GL"
      case .gt: return "GT"
      case .gf: return "GF"
      case .gu: return "GU"
      case .gy: return "GY"
      case .hk: return "HK"
      case .hm: return "HM"
      case .hn: return "HN"
      case .hr: return "HR"
      case .ht: return "HT"
      case .hu: return "HU"
      case .id: return "ID"
      case .im: return "IM"
      case .in: return "IN"
      case .io: return "IO"
      case .ie: return "IE"
      case .ir: return "IR"
      case .iq: return "IQ"
      case .is: return "IS"
      case .il: return "IL"
      case .it: return "IT"
      case .jm: return "JM"
      case .je: return "JE"
      case .jo: return "JO"
      case .jp: return "JP"
      case .kz: return "KZ"
      case .ke: return "KE"
      case .kg: return "KG"
      case .kh: return "KH"
      case .ki: return "KI"
      case .kn: return "KN"
      case .kr: return "KR"
      case .kw: return "KW"
      case .la: return "LA"
      case .lb: return "LB"
      case .lr: return "LR"
      case .ly: return "LY"
      case .lc: return "LC"
      case .li: return "LI"
      case .lk: return "LK"
      case .ls: return "LS"
      case .lt: return "LT"
      case .lu: return "LU"
      case .lv: return "LV"
      case .mo: return "MO"
      case .mf: return "MF"
      case .ma: return "MA"
      case .mc: return "MC"
      case .md: return "MD"
      case .mg: return "MG"
      case .mv: return "MV"
      case .mx: return "MX"
      case .mh: return "MH"
      case .mk: return "MK"
      case .ml: return "ML"
      case .mt: return "MT"
      case .mm: return "MM"
      case .me: return "ME"
      case .mn: return "MN"
      case .mp: return "MP"
      case .mz: return "MZ"
      case .mr: return "MR"
      case .ms: return "MS"
      case .mq: return "MQ"
      case .mu: return "MU"
      case .mw: return "MW"
      case .my: return "MY"
      case .yt: return "YT"
      case .na: return "NA"
      case .nc: return "NC"
      case .ne: return "NE"
      case .nf: return "NF"
      case .ng: return "NG"
      case .ni: return "NI"
      case .nu: return "NU"
      case .nl: return "NL"
      case .no: return "NO"
      case .np: return "NP"
      case .nr: return "NR"
      case .nz: return "NZ"
      case .om: return "OM"
      case .pk: return "PK"
      case .pa: return "PA"
      case .pn: return "PN"
      case .pe: return "PE"
      case .ph: return "PH"
      case .pw: return "PW"
      case .pg: return "PG"
      case .pl: return "PL"
      case .pr: return "PR"
      case .kp: return "KP"
      case .pt: return "PT"
      case .py: return "PY"
      case .ps: return "PS"
      case .pf: return "PF"
      case .qa: return "QA"
      case .re: return "RE"
      case .ro: return "RO"
      case .ru: return "RU"
      case .rw: return "RW"
      case .sa: return "SA"
      case .sd: return "SD"
      case .sn: return "SN"
      case .sg: return "SG"
      case .gs: return "GS"
      case .sh: return "SH"
      case .sj: return "SJ"
      case .sb: return "SB"
      case .sl: return "SL"
      case .sv: return "SV"
      case .sm: return "SM"
      case .so: return "SO"
      case .pm: return "PM"
      case .rs: return "RS"
      case .ss: return "SS"
      case .st: return "ST"
      case .sr: return "SR"
      case .sk: return "SK"
      case .si: return "SI"
      case .se: return "SE"
      case .sz: return "SZ"
      case .sx: return "SX"
      case .sc: return "SC"
      case .sy: return "SY"
      case .tc: return "TC"
      case .td: return "TD"
      case .tg: return "TG"
      case .th: return "TH"
      case .tj: return "TJ"
      case .tk: return "TK"
      case .tm: return "TM"
      case .tl: return "TL"
      case .to: return "TO"
      case .tt: return "TT"
      case .tn: return "TN"
      case .tr: return "TR"
      case .tv: return "TV"
      case .tw: return "TW"
      case .tz: return "TZ"
      case .ug: return "UG"
      case .ua: return "UA"
      case .um: return "UM"
      case .uy: return "UY"
      case .us: return "US"
      case .uz: return "UZ"
      case .va: return "VA"
      case .vc: return "VC"
      case .ve: return "VE"
      case .vg: return "VG"
      case .vi: return "VI"
      case .vn: return "VN"
      case .vu: return "VU"
      case .wf: return "WF"
      case .ws: return "WS"
      case .ye: return "YE"
      case .za: return "ZA"
      case .zm: return "ZM"
      case .zw: return "ZW"
      case let ._unknown(value): return value
      }
    }

    static func == (lhs: CountryCode, rhs: CountryCode) -> Bool {
      switch (lhs, rhs) {
      case (.aw, .aw): return true
      case (.af, .af): return true
      case (.ao, .ao): return true
      case (.ai, .ai): return true
      case (.ax, .ax): return true
      case (.al, .al): return true
      case (.ad, .ad): return true
      case (.ae, .ae): return true
      case (.ar, .ar): return true
      case (.am, .am): return true
      case (.as, .as): return true
      case (.aq, .aq): return true
      case (.tf, .tf): return true
      case (.ag, .ag): return true
      case (.au, .au): return true
      case (.at, .at): return true
      case (.az, .az): return true
      case (.bi, .bi): return true
      case (.be, .be): return true
      case (.bj, .bj): return true
      case (.bq, .bq): return true
      case (.bf, .bf): return true
      case (.bd, .bd): return true
      case (.bg, .bg): return true
      case (.bh, .bh): return true
      case (.bs, .bs): return true
      case (.ba, .ba): return true
      case (.bl, .bl): return true
      case (.by, .by): return true
      case (.bz, .bz): return true
      case (.bm, .bm): return true
      case (.bo, .bo): return true
      case (.br, .br): return true
      case (.bb, .bb): return true
      case (.bn, .bn): return true
      case (.bt, .bt): return true
      case (.bv, .bv): return true
      case (.bw, .bw): return true
      case (.cf, .cf): return true
      case (.ca, .ca): return true
      case (.cc, .cc): return true
      case (.ch, .ch): return true
      case (.cl, .cl): return true
      case (.cn, .cn): return true
      case (.ci, .ci): return true
      case (.cm, .cm): return true
      case (.cd, .cd): return true
      case (.cg, .cg): return true
      case (.ck, .ck): return true
      case (.co, .co): return true
      case (.km, .km): return true
      case (.cv, .cv): return true
      case (.cr, .cr): return true
      case (.cu, .cu): return true
      case (.cw, .cw): return true
      case (.cx, .cx): return true
      case (.ky, .ky): return true
      case (.cy, .cy): return true
      case (.cz, .cz): return true
      case (.de, .de): return true
      case (.dj, .dj): return true
      case (.dm, .dm): return true
      case (.dk, .dk): return true
      case (.do, .do): return true
      case (.dz, .dz): return true
      case (.ec, .ec): return true
      case (.eg, .eg): return true
      case (.er, .er): return true
      case (.eh, .eh): return true
      case (.es, .es): return true
      case (.ee, .ee): return true
      case (.et, .et): return true
      case (.fi, .fi): return true
      case (.fj, .fj): return true
      case (.fk, .fk): return true
      case (.fr, .fr): return true
      case (.fo, .fo): return true
      case (.fm, .fm): return true
      case (.ga, .ga): return true
      case (.gb, .gb): return true
      case (.ge, .ge): return true
      case (.gg, .gg): return true
      case (.gh, .gh): return true
      case (.gi, .gi): return true
      case (.gn, .gn): return true
      case (.gp, .gp): return true
      case (.gm, .gm): return true
      case (.gw, .gw): return true
      case (.gq, .gq): return true
      case (.gr, .gr): return true
      case (.gd, .gd): return true
      case (.gl, .gl): return true
      case (.gt, .gt): return true
      case (.gf, .gf): return true
      case (.gu, .gu): return true
      case (.gy, .gy): return true
      case (.hk, .hk): return true
      case (.hm, .hm): return true
      case (.hn, .hn): return true
      case (.hr, .hr): return true
      case (.ht, .ht): return true
      case (.hu, .hu): return true
      case (.id, .id): return true
      case (.im, .im): return true
      case (.in, .in): return true
      case (.io, .io): return true
      case (.ie, .ie): return true
      case (.ir, .ir): return true
      case (.iq, .iq): return true
      case (.is, .is): return true
      case (.il, .il): return true
      case (.it, .it): return true
      case (.jm, .jm): return true
      case (.je, .je): return true
      case (.jo, .jo): return true
      case (.jp, .jp): return true
      case (.kz, .kz): return true
      case (.ke, .ke): return true
      case (.kg, .kg): return true
      case (.kh, .kh): return true
      case (.ki, .ki): return true
      case (.kn, .kn): return true
      case (.kr, .kr): return true
      case (.kw, .kw): return true
      case (.la, .la): return true
      case (.lb, .lb): return true
      case (.lr, .lr): return true
      case (.ly, .ly): return true
      case (.lc, .lc): return true
      case (.li, .li): return true
      case (.lk, .lk): return true
      case (.ls, .ls): return true
      case (.lt, .lt): return true
      case (.lu, .lu): return true
      case (.lv, .lv): return true
      case (.mo, .mo): return true
      case (.mf, .mf): return true
      case (.ma, .ma): return true
      case (.mc, .mc): return true
      case (.md, .md): return true
      case (.mg, .mg): return true
      case (.mv, .mv): return true
      case (.mx, .mx): return true
      case (.mh, .mh): return true
      case (.mk, .mk): return true
      case (.ml, .ml): return true
      case (.mt, .mt): return true
      case (.mm, .mm): return true
      case (.me, .me): return true
      case (.mn, .mn): return true
      case (.mp, .mp): return true
      case (.mz, .mz): return true
      case (.mr, .mr): return true
      case (.ms, .ms): return true
      case (.mq, .mq): return true
      case (.mu, .mu): return true
      case (.mw, .mw): return true
      case (.my, .my): return true
      case (.yt, .yt): return true
      case (.na, .na): return true
      case (.nc, .nc): return true
      case (.ne, .ne): return true
      case (.nf, .nf): return true
      case (.ng, .ng): return true
      case (.ni, .ni): return true
      case (.nu, .nu): return true
      case (.nl, .nl): return true
      case (.no, .no): return true
      case (.np, .np): return true
      case (.nr, .nr): return true
      case (.nz, .nz): return true
      case (.om, .om): return true
      case (.pk, .pk): return true
      case (.pa, .pa): return true
      case (.pn, .pn): return true
      case (.pe, .pe): return true
      case (.ph, .ph): return true
      case (.pw, .pw): return true
      case (.pg, .pg): return true
      case (.pl, .pl): return true
      case (.pr, .pr): return true
      case (.kp, .kp): return true
      case (.pt, .pt): return true
      case (.py, .py): return true
      case (.ps, .ps): return true
      case (.pf, .pf): return true
      case (.qa, .qa): return true
      case (.re, .re): return true
      case (.ro, .ro): return true
      case (.ru, .ru): return true
      case (.rw, .rw): return true
      case (.sa, .sa): return true
      case (.sd, .sd): return true
      case (.sn, .sn): return true
      case (.sg, .sg): return true
      case (.gs, .gs): return true
      case (.sh, .sh): return true
      case (.sj, .sj): return true
      case (.sb, .sb): return true
      case (.sl, .sl): return true
      case (.sv, .sv): return true
      case (.sm, .sm): return true
      case (.so, .so): return true
      case (.pm, .pm): return true
      case (.rs, .rs): return true
      case (.ss, .ss): return true
      case (.st, .st): return true
      case (.sr, .sr): return true
      case (.sk, .sk): return true
      case (.si, .si): return true
      case (.se, .se): return true
      case (.sz, .sz): return true
      case (.sx, .sx): return true
      case (.sc, .sc): return true
      case (.sy, .sy): return true
      case (.tc, .tc): return true
      case (.td, .td): return true
      case (.tg, .tg): return true
      case (.th, .th): return true
      case (.tj, .tj): return true
      case (.tk, .tk): return true
      case (.tm, .tm): return true
      case (.tl, .tl): return true
      case (.to, .to): return true
      case (.tt, .tt): return true
      case (.tn, .tn): return true
      case (.tr, .tr): return true
      case (.tv, .tv): return true
      case (.tw, .tw): return true
      case (.tz, .tz): return true
      case (.ug, .ug): return true
      case (.ua, .ua): return true
      case (.um, .um): return true
      case (.uy, .uy): return true
      case (.us, .us): return true
      case (.uz, .uz): return true
      case (.va, .va): return true
      case (.vc, .vc): return true
      case (.ve, .ve): return true
      case (.vg, .vg): return true
      case (.vi, .vi): return true
      case (.vn, .vn): return true
      case (.vu, .vu): return true
      case (.wf, .wf): return true
      case (.ws, .ws): return true
      case (.ye, .ye): return true
      case (.za, .za): return true
      case (.zm, .zm): return true
      case (.zw, .zw): return true
      case let (._unknown(lhsValue), ._unknown(rhsValue)): return lhsValue == rhsValue
      default: return false
      }
    }

    static var allCases: [CountryCode] {
      return [
        .aw,
        .af,
        .ao,
        .ai,
        .ax,
        .al,
        .ad,
        .ae,
        .ar,
        .am,
        .as,
        .aq,
        .tf,
        .ag,
        .au,
        .at,
        .az,
        .bi,
        .be,
        .bj,
        .bq,
        .bf,
        .bd,
        .bg,
        .bh,
        .bs,
        .ba,
        .bl,
        .by,
        .bz,
        .bm,
        .bo,
        .br,
        .bb,
        .bn,
        .bt,
        .bv,
        .bw,
        .cf,
        .ca,
        .cc,
        .ch,
        .cl,
        .cn,
        .ci,
        .cm,
        .cd,
        .cg,
        .ck,
        .co,
        .km,
        .cv,
        .cr,
        .cu,
        .cw,
        .cx,
        .ky,
        .cy,
        .cz,
        .de,
        .dj,
        .dm,
        .dk,
        .do,
        .dz,
        .ec,
        .eg,
        .er,
        .eh,
        .es,
        .ee,
        .et,
        .fi,
        .fj,
        .fk,
        .fr,
        .fo,
        .fm,
        .ga,
        .gb,
        .ge,
        .gg,
        .gh,
        .gi,
        .gn,
        .gp,
        .gm,
        .gw,
        .gq,
        .gr,
        .gd,
        .gl,
        .gt,
        .gf,
        .gu,
        .gy,
        .hk,
        .hm,
        .hn,
        .hr,
        .ht,
        .hu,
        .id,
        .im,
        .in,
        .io,
        .ie,
        .ir,
        .iq,
        .is,
        .il,
        .it,
        .jm,
        .je,
        .jo,
        .jp,
        .kz,
        .ke,
        .kg,
        .kh,
        .ki,
        .kn,
        .kr,
        .kw,
        .la,
        .lb,
        .lr,
        .ly,
        .lc,
        .li,
        .lk,
        .ls,
        .lt,
        .lu,
        .lv,
        .mo,
        .mf,
        .ma,
        .mc,
        .md,
        .mg,
        .mv,
        .mx,
        .mh,
        .mk,
        .ml,
        .mt,
        .mm,
        .me,
        .mn,
        .mp,
        .mz,
        .mr,
        .ms,
        .mq,
        .mu,
        .mw,
        .my,
        .yt,
        .na,
        .nc,
        .ne,
        .nf,
        .ng,
        .ni,
        .nu,
        .nl,
        .no,
        .np,
        .nr,
        .nz,
        .om,
        .pk,
        .pa,
        .pn,
        .pe,
        .ph,
        .pw,
        .pg,
        .pl,
        .pr,
        .kp,
        .pt,
        .py,
        .ps,
        .pf,
        .qa,
        .re,
        .ro,
        .ru,
        .rw,
        .sa,
        .sd,
        .sn,
        .sg,
        .gs,
        .sh,
        .sj,
        .sb,
        .sl,
        .sv,
        .sm,
        .so,
        .pm,
        .rs,
        .ss,
        .st,
        .sr,
        .sk,
        .si,
        .se,
        .sz,
        .sx,
        .sc,
        .sy,
        .tc,
        .td,
        .tg,
        .th,
        .tj,
        .tk,
        .tm,
        .tl,
        .to,
        .tt,
        .tn,
        .tr,
        .tv,
        .tw,
        .tz,
        .ug,
        .ua,
        .um,
        .uy,
        .us,
        .uz,
        .va,
        .vc,
        .ve,
        .vg,
        .vi,
        .vn,
        .vu,
        .wf,
        .ws,
        .ye,
        .za,
        .zm,
        .zw
      ]
    }
  }

  /// Currency Code
  enum CurrencyCode: RawRepresentable, CaseIterable, Codable {
    typealias RawValue = String

    case adp

    case aed

    case afa

    case afn

    case alk

    case all

    case amd

    case ang

    case aoa

    case aok

    case aon

    case aor

    case ara

    case arl

    case arm

    case arp

    case ars

    case ats

    case aud

    case awg

    case azm

    case azn

    case bad

    case bam

    case ban

    case bbd

    case bdt

    case bec

    case bef

    case bel

    case bgl

    case bgm

    case bgn

    case bgo

    case bhd

    case bif

    case bmd

    case bnd

    case bob

    case bol

    case bop

    case bov

    case brb

    case brc

    case bre

    case brl

    case brn

    case brr

    case brz

    case bsd

    case btn

    case buk

    case bwp

    case byb

    case byn

    case byr

    case bzd

    case cad

    case cdf

    case che

    case chf

    case chw

    case cle

    case clf

    case clp

    case cnx

    case cny

    case cop

    case cou

    case crc

    case csd

    case csk

    case cuc

    case cup

    case cve

    case cyp

    case czk

    case ddm

    case dem

    case djf

    case dkk

    case dop

    case dzd

    case ecs

    case ecv

    case eek

    case egp

    case ern

    case esa

    case esb

    case esp

    case etb

    case eur

    case fim

    case fjd

    case fkp

    case frf

    case gbp

    case gek

    case gel

    case ghc

    case ghs

    case gip

    case gmd

    case gnf

    case gns

    case gqe

    case grd

    case gtq

    case gwe

    case gwp

    case gyd

    case hkd

    case hnl

    case hrd

    case hrk

    case htg

    case huf

    case idr

    case iep

    case ilp

    case ilr

    case ils

    case inr

    case iqd

    case isj

    case irr

    case isk

    case itl

    case jmd

    case jod

    case jpy

    case kes

    case kgs

    case khr

    case kmf

    case kpw

    case krh

    case kro

    case krw

    case kwd

    case kyd

    case kzt

    case lak

    case lbp

    case lkr

    case lrd

    case lsl

    case ltl

    case ltt

    case luc

    case luf

    case lul

    case lvl

    case lvr

    case lyd

    case mad

    case maf

    case mcf

    case mdc

    case mdl

    case mga

    case mgf

    case mkd

    case mkn

    case mlf

    case mmk

    case mnt

    case mop

    case mro

    case mtl

    case mtp

    case mur

    case mvp

    case mvr

    case mwk

    case mxn

    case mxp

    case mxv

    case myr

    case mze

    case mzm

    case mzn

    case nad

    case ngn

    case nic

    case nio

    case nlg

    case nok

    case npr

    case nzd

    case omr

    case pab

    case pei

    case pen

    case pes

    case pgk

    case php

    case pkr

    case pln

    case plz

    case pte

    case pyg

    case qar

    case rhd

    case rol

    case ron

    case rsd

    case rub

    case rur

    case rwf

    case sar

    case sbd

    case scr

    case sdd

    case sdg

    case sdp

    case sek

    case sgd

    case shp

    case sit

    case skk

    case sll

    case sos

    case srd

    case srg

    case ssp

    case std

    case sur

    case svc

    case syp

    case szl

    case thb

    case tjr

    case tjs

    case tmm

    case tmt

    case tnd

    case top

    case tpe

    case trl

    case `try`

    case ttd

    case twd

    case tzs

    case uah

    case uak

    case ugs

    case ugx

    case usd

    case usn

    case uss

    case uyi

    case uyp

    case uyu

    case uzs

    case veb

    case vef

    case vnd

    case vnn

    case vuv

    case wst

    case xaf

    case xcd

    case xeu

    case xfo

    case xfu

    case xof

    case xpf

    case xre

    case ydd

    case yer

    case yud

    case yum

    case yun

    case yur

    case zal

    case zar

    case zmk

    case zmw

    case zrn

    case zrz

    case zwd

    case zwl

    case zwr

    /// Auto generated constant for unknown enum values
    case _unknown(RawValue)

    public init?(rawValue: RawValue) {
      switch rawValue {
      case "ADP": self = .adp
      case "AED": self = .aed
      case "AFA": self = .afa
      case "AFN": self = .afn
      case "ALK": self = .alk
      case "ALL": self = .all
      case "AMD": self = .amd
      case "ANG": self = .ang
      case "AOA": self = .aoa
      case "AOK": self = .aok
      case "AON": self = .aon
      case "AOR": self = .aor
      case "ARA": self = .ara
      case "ARL": self = .arl
      case "ARM": self = .arm
      case "ARP": self = .arp
      case "ARS": self = .ars
      case "ATS": self = .ats
      case "AUD": self = .aud
      case "AWG": self = .awg
      case "AZM": self = .azm
      case "AZN": self = .azn
      case "BAD": self = .bad
      case "BAM": self = .bam
      case "BAN": self = .ban
      case "BBD": self = .bbd
      case "BDT": self = .bdt
      case "BEC": self = .bec
      case "BEF": self = .bef
      case "BEL": self = .bel
      case "BGL": self = .bgl
      case "BGM": self = .bgm
      case "BGN": self = .bgn
      case "BGO": self = .bgo
      case "BHD": self = .bhd
      case "BIF": self = .bif
      case "BMD": self = .bmd
      case "BND": self = .bnd
      case "BOB": self = .bob
      case "BOL": self = .bol
      case "BOP": self = .bop
      case "BOV": self = .bov
      case "BRB": self = .brb
      case "BRC": self = .brc
      case "BRE": self = .bre
      case "BRL": self = .brl
      case "BRN": self = .brn
      case "BRR": self = .brr
      case "BRZ": self = .brz
      case "BSD": self = .bsd
      case "BTN": self = .btn
      case "BUK": self = .buk
      case "BWP": self = .bwp
      case "BYB": self = .byb
      case "BYN": self = .byn
      case "BYR": self = .byr
      case "BZD": self = .bzd
      case "CAD": self = .cad
      case "CDF": self = .cdf
      case "CHE": self = .che
      case "CHF": self = .chf
      case "CHW": self = .chw
      case "CLE": self = .cle
      case "CLF": self = .clf
      case "CLP": self = .clp
      case "CNX": self = .cnx
      case "CNY": self = .cny
      case "COP": self = .cop
      case "COU": self = .cou
      case "CRC": self = .crc
      case "CSD": self = .csd
      case "CSK": self = .csk
      case "CUC": self = .cuc
      case "CUP": self = .cup
      case "CVE": self = .cve
      case "CYP": self = .cyp
      case "CZK": self = .czk
      case "DDM": self = .ddm
      case "DEM": self = .dem
      case "DJF": self = .djf
      case "DKK": self = .dkk
      case "DOP": self = .dop
      case "DZD": self = .dzd
      case "ECS": self = .ecs
      case "ECV": self = .ecv
      case "EEK": self = .eek
      case "EGP": self = .egp
      case "ERN": self = .ern
      case "ESA": self = .esa
      case "ESB": self = .esb
      case "ESP": self = .esp
      case "ETB": self = .etb
      case "EUR": self = .eur
      case "FIM": self = .fim
      case "FJD": self = .fjd
      case "FKP": self = .fkp
      case "FRF": self = .frf
      case "GBP": self = .gbp
      case "GEK": self = .gek
      case "GEL": self = .gel
      case "GHC": self = .ghc
      case "GHS": self = .ghs
      case "GIP": self = .gip
      case "GMD": self = .gmd
      case "GNF": self = .gnf
      case "GNS": self = .gns
      case "GQE": self = .gqe
      case "GRD": self = .grd
      case "GTQ": self = .gtq
      case "GWE": self = .gwe
      case "GWP": self = .gwp
      case "GYD": self = .gyd
      case "HKD": self = .hkd
      case "HNL": self = .hnl
      case "HRD": self = .hrd
      case "HRK": self = .hrk
      case "HTG": self = .htg
      case "HUF": self = .huf
      case "IDR": self = .idr
      case "IEP": self = .iep
      case "ILP": self = .ilp
      case "ILR": self = .ilr
      case "ILS": self = .ils
      case "INR": self = .inr
      case "IQD": self = .iqd
      case "ISJ": self = .isj
      case "IRR": self = .irr
      case "ISK": self = .isk
      case "ITL": self = .itl
      case "JMD": self = .jmd
      case "JOD": self = .jod
      case "JPY": self = .jpy
      case "KES": self = .kes
      case "KGS": self = .kgs
      case "KHR": self = .khr
      case "KMF": self = .kmf
      case "KPW": self = .kpw
      case "KRH": self = .krh
      case "KRO": self = .kro
      case "KRW": self = .krw
      case "KWD": self = .kwd
      case "KYD": self = .kyd
      case "KZT": self = .kzt
      case "LAK": self = .lak
      case "LBP": self = .lbp
      case "LKR": self = .lkr
      case "LRD": self = .lrd
      case "LSL": self = .lsl
      case "LTL": self = .ltl
      case "LTT": self = .ltt
      case "LUC": self = .luc
      case "LUF": self = .luf
      case "LUL": self = .lul
      case "LVL": self = .lvl
      case "LVR": self = .lvr
      case "LYD": self = .lyd
      case "MAD": self = .mad
      case "MAF": self = .maf
      case "MCF": self = .mcf
      case "MDC": self = .mdc
      case "MDL": self = .mdl
      case "MGA": self = .mga
      case "MGF": self = .mgf
      case "MKD": self = .mkd
      case "MKN": self = .mkn
      case "MLF": self = .mlf
      case "MMK": self = .mmk
      case "MNT": self = .mnt
      case "MOP": self = .mop
      case "MRO": self = .mro
      case "MTL": self = .mtl
      case "MTP": self = .mtp
      case "MUR": self = .mur
      case "MVP": self = .mvp
      case "MVR": self = .mvr
      case "MWK": self = .mwk
      case "MXN": self = .mxn
      case "MXP": self = .mxp
      case "MXV": self = .mxv
      case "MYR": self = .myr
      case "MZE": self = .mze
      case "MZM": self = .mzm
      case "MZN": self = .mzn
      case "NAD": self = .nad
      case "NGN": self = .ngn
      case "NIC": self = .nic
      case "NIO": self = .nio
      case "NLG": self = .nlg
      case "NOK": self = .nok
      case "NPR": self = .npr
      case "NZD": self = .nzd
      case "OMR": self = .omr
      case "PAB": self = .pab
      case "PEI": self = .pei
      case "PEN": self = .pen
      case "PES": self = .pes
      case "PGK": self = .pgk
      case "PHP": self = .php
      case "PKR": self = .pkr
      case "PLN": self = .pln
      case "PLZ": self = .plz
      case "PTE": self = .pte
      case "PYG": self = .pyg
      case "QAR": self = .qar
      case "RHD": self = .rhd
      case "ROL": self = .rol
      case "RON": self = .ron
      case "RSD": self = .rsd
      case "RUB": self = .rub
      case "RUR": self = .rur
      case "RWF": self = .rwf
      case "SAR": self = .sar
      case "SBD": self = .sbd
      case "SCR": self = .scr
      case "SDD": self = .sdd
      case "SDG": self = .sdg
      case "SDP": self = .sdp
      case "SEK": self = .sek
      case "SGD": self = .sgd
      case "SHP": self = .shp
      case "SIT": self = .sit
      case "SKK": self = .skk
      case "SLL": self = .sll
      case "SOS": self = .sos
      case "SRD": self = .srd
      case "SRG": self = .srg
      case "SSP": self = .ssp
      case "STD": self = .std
      case "SUR": self = .sur
      case "SVC": self = .svc
      case "SYP": self = .syp
      case "SZL": self = .szl
      case "THB": self = .thb
      case "TJR": self = .tjr
      case "TJS": self = .tjs
      case "TMM": self = .tmm
      case "TMT": self = .tmt
      case "TND": self = .tnd
      case "TOP": self = .top
      case "TPE": self = .tpe
      case "TRL": self = .trl
      case "TRY": self = .try
      case "TTD": self = .ttd
      case "TWD": self = .twd
      case "TZS": self = .tzs
      case "UAH": self = .uah
      case "UAK": self = .uak
      case "UGS": self = .ugs
      case "UGX": self = .ugx
      case "USD": self = .usd
      case "USN": self = .usn
      case "USS": self = .uss
      case "UYI": self = .uyi
      case "UYP": self = .uyp
      case "UYU": self = .uyu
      case "UZS": self = .uzs
      case "VEB": self = .veb
      case "VEF": self = .vef
      case "VND": self = .vnd
      case "VNN": self = .vnn
      case "VUV": self = .vuv
      case "WST": self = .wst
      case "XAF": self = .xaf
      case "XCD": self = .xcd
      case "XEU": self = .xeu
      case "XFO": self = .xfo
      case "XFU": self = .xfu
      case "XOF": self = .xof
      case "XPF": self = .xpf
      case "XRE": self = .xre
      case "YDD": self = .ydd
      case "YER": self = .yer
      case "YUD": self = .yud
      case "YUM": self = .yum
      case "YUN": self = .yun
      case "YUR": self = .yur
      case "ZAL": self = .zal
      case "ZAR": self = .zar
      case "ZMK": self = .zmk
      case "ZMW": self = .zmw
      case "ZRN": self = .zrn
      case "ZRZ": self = .zrz
      case "ZWD": self = .zwd
      case "ZWL": self = .zwl
      case "ZWR": self = .zwr
      default: self = ._unknown(rawValue)
      }
    }

    public var rawValue: RawValue {
      switch self {
      case .adp: return "ADP"
      case .aed: return "AED"
      case .afa: return "AFA"
      case .afn: return "AFN"
      case .alk: return "ALK"
      case .all: return "ALL"
      case .amd: return "AMD"
      case .ang: return "ANG"
      case .aoa: return "AOA"
      case .aok: return "AOK"
      case .aon: return "AON"
      case .aor: return "AOR"
      case .ara: return "ARA"
      case .arl: return "ARL"
      case .arm: return "ARM"
      case .arp: return "ARP"
      case .ars: return "ARS"
      case .ats: return "ATS"
      case .aud: return "AUD"
      case .awg: return "AWG"
      case .azm: return "AZM"
      case .azn: return "AZN"
      case .bad: return "BAD"
      case .bam: return "BAM"
      case .ban: return "BAN"
      case .bbd: return "BBD"
      case .bdt: return "BDT"
      case .bec: return "BEC"
      case .bef: return "BEF"
      case .bel: return "BEL"
      case .bgl: return "BGL"
      case .bgm: return "BGM"
      case .bgn: return "BGN"
      case .bgo: return "BGO"
      case .bhd: return "BHD"
      case .bif: return "BIF"
      case .bmd: return "BMD"
      case .bnd: return "BND"
      case .bob: return "BOB"
      case .bol: return "BOL"
      case .bop: return "BOP"
      case .bov: return "BOV"
      case .brb: return "BRB"
      case .brc: return "BRC"
      case .bre: return "BRE"
      case .brl: return "BRL"
      case .brn: return "BRN"
      case .brr: return "BRR"
      case .brz: return "BRZ"
      case .bsd: return "BSD"
      case .btn: return "BTN"
      case .buk: return "BUK"
      case .bwp: return "BWP"
      case .byb: return "BYB"
      case .byn: return "BYN"
      case .byr: return "BYR"
      case .bzd: return "BZD"
      case .cad: return "CAD"
      case .cdf: return "CDF"
      case .che: return "CHE"
      case .chf: return "CHF"
      case .chw: return "CHW"
      case .cle: return "CLE"
      case .clf: return "CLF"
      case .clp: return "CLP"
      case .cnx: return "CNX"
      case .cny: return "CNY"
      case .cop: return "COP"
      case .cou: return "COU"
      case .crc: return "CRC"
      case .csd: return "CSD"
      case .csk: return "CSK"
      case .cuc: return "CUC"
      case .cup: return "CUP"
      case .cve: return "CVE"
      case .cyp: return "CYP"
      case .czk: return "CZK"
      case .ddm: return "DDM"
      case .dem: return "DEM"
      case .djf: return "DJF"
      case .dkk: return "DKK"
      case .dop: return "DOP"
      case .dzd: return "DZD"
      case .ecs: return "ECS"
      case .ecv: return "ECV"
      case .eek: return "EEK"
      case .egp: return "EGP"
      case .ern: return "ERN"
      case .esa: return "ESA"
      case .esb: return "ESB"
      case .esp: return "ESP"
      case .etb: return "ETB"
      case .eur: return "EUR"
      case .fim: return "FIM"
      case .fjd: return "FJD"
      case .fkp: return "FKP"
      case .frf: return "FRF"
      case .gbp: return "GBP"
      case .gek: return "GEK"
      case .gel: return "GEL"
      case .ghc: return "GHC"
      case .ghs: return "GHS"
      case .gip: return "GIP"
      case .gmd: return "GMD"
      case .gnf: return "GNF"
      case .gns: return "GNS"
      case .gqe: return "GQE"
      case .grd: return "GRD"
      case .gtq: return "GTQ"
      case .gwe: return "GWE"
      case .gwp: return "GWP"
      case .gyd: return "GYD"
      case .hkd: return "HKD"
      case .hnl: return "HNL"
      case .hrd: return "HRD"
      case .hrk: return "HRK"
      case .htg: return "HTG"
      case .huf: return "HUF"
      case .idr: return "IDR"
      case .iep: return "IEP"
      case .ilp: return "ILP"
      case .ilr: return "ILR"
      case .ils: return "ILS"
      case .inr: return "INR"
      case .iqd: return "IQD"
      case .isj: return "ISJ"
      case .irr: return "IRR"
      case .isk: return "ISK"
      case .itl: return "ITL"
      case .jmd: return "JMD"
      case .jod: return "JOD"
      case .jpy: return "JPY"
      case .kes: return "KES"
      case .kgs: return "KGS"
      case .khr: return "KHR"
      case .kmf: return "KMF"
      case .kpw: return "KPW"
      case .krh: return "KRH"
      case .kro: return "KRO"
      case .krw: return "KRW"
      case .kwd: return "KWD"
      case .kyd: return "KYD"
      case .kzt: return "KZT"
      case .lak: return "LAK"
      case .lbp: return "LBP"
      case .lkr: return "LKR"
      case .lrd: return "LRD"
      case .lsl: return "LSL"
      case .ltl: return "LTL"
      case .ltt: return "LTT"
      case .luc: return "LUC"
      case .luf: return "LUF"
      case .lul: return "LUL"
      case .lvl: return "LVL"
      case .lvr: return "LVR"
      case .lyd: return "LYD"
      case .mad: return "MAD"
      case .maf: return "MAF"
      case .mcf: return "MCF"
      case .mdc: return "MDC"
      case .mdl: return "MDL"
      case .mga: return "MGA"
      case .mgf: return "MGF"
      case .mkd: return "MKD"
      case .mkn: return "MKN"
      case .mlf: return "MLF"
      case .mmk: return "MMK"
      case .mnt: return "MNT"
      case .mop: return "MOP"
      case .mro: return "MRO"
      case .mtl: return "MTL"
      case .mtp: return "MTP"
      case .mur: return "MUR"
      case .mvp: return "MVP"
      case .mvr: return "MVR"
      case .mwk: return "MWK"
      case .mxn: return "MXN"
      case .mxp: return "MXP"
      case .mxv: return "MXV"
      case .myr: return "MYR"
      case .mze: return "MZE"
      case .mzm: return "MZM"
      case .mzn: return "MZN"
      case .nad: return "NAD"
      case .ngn: return "NGN"
      case .nic: return "NIC"
      case .nio: return "NIO"
      case .nlg: return "NLG"
      case .nok: return "NOK"
      case .npr: return "NPR"
      case .nzd: return "NZD"
      case .omr: return "OMR"
      case .pab: return "PAB"
      case .pei: return "PEI"
      case .pen: return "PEN"
      case .pes: return "PES"
      case .pgk: return "PGK"
      case .php: return "PHP"
      case .pkr: return "PKR"
      case .pln: return "PLN"
      case .plz: return "PLZ"
      case .pte: return "PTE"
      case .pyg: return "PYG"
      case .qar: return "QAR"
      case .rhd: return "RHD"
      case .rol: return "ROL"
      case .ron: return "RON"
      case .rsd: return "RSD"
      case .rub: return "RUB"
      case .rur: return "RUR"
      case .rwf: return "RWF"
      case .sar: return "SAR"
      case .sbd: return "SBD"
      case .scr: return "SCR"
      case .sdd: return "SDD"
      case .sdg: return "SDG"
      case .sdp: return "SDP"
      case .sek: return "SEK"
      case .sgd: return "SGD"
      case .shp: return "SHP"
      case .sit: return "SIT"
      case .skk: return "SKK"
      case .sll: return "SLL"
      case .sos: return "SOS"
      case .srd: return "SRD"
      case .srg: return "SRG"
      case .ssp: return "SSP"
      case .std: return "STD"
      case .sur: return "SUR"
      case .svc: return "SVC"
      case .syp: return "SYP"
      case .szl: return "SZL"
      case .thb: return "THB"
      case .tjr: return "TJR"
      case .tjs: return "TJS"
      case .tmm: return "TMM"
      case .tmt: return "TMT"
      case .tnd: return "TND"
      case .top: return "TOP"
      case .tpe: return "TPE"
      case .trl: return "TRL"
      case .try: return "TRY"
      case .ttd: return "TTD"
      case .twd: return "TWD"
      case .tzs: return "TZS"
      case .uah: return "UAH"
      case .uak: return "UAK"
      case .ugs: return "UGS"
      case .ugx: return "UGX"
      case .usd: return "USD"
      case .usn: return "USN"
      case .uss: return "USS"
      case .uyi: return "UYI"
      case .uyp: return "UYP"
      case .uyu: return "UYU"
      case .uzs: return "UZS"
      case .veb: return "VEB"
      case .vef: return "VEF"
      case .vnd: return "VND"
      case .vnn: return "VNN"
      case .vuv: return "VUV"
      case .wst: return "WST"
      case .xaf: return "XAF"
      case .xcd: return "XCD"
      case .xeu: return "XEU"
      case .xfo: return "XFO"
      case .xfu: return "XFU"
      case .xof: return "XOF"
      case .xpf: return "XPF"
      case .xre: return "XRE"
      case .ydd: return "YDD"
      case .yer: return "YER"
      case .yud: return "YUD"
      case .yum: return "YUM"
      case .yun: return "YUN"
      case .yur: return "YUR"
      case .zal: return "ZAL"
      case .zar: return "ZAR"
      case .zmk: return "ZMK"
      case .zmw: return "ZMW"
      case .zrn: return "ZRN"
      case .zrz: return "ZRZ"
      case .zwd: return "ZWD"
      case .zwl: return "ZWL"
      case .zwr: return "ZWR"
      case let ._unknown(value): return value
      }
    }

    static func == (lhs: CurrencyCode, rhs: CurrencyCode) -> Bool {
      switch (lhs, rhs) {
      case (.adp, .adp): return true
      case (.aed, .aed): return true
      case (.afa, .afa): return true
      case (.afn, .afn): return true
      case (.alk, .alk): return true
      case (.all, .all): return true
      case (.amd, .amd): return true
      case (.ang, .ang): return true
      case (.aoa, .aoa): return true
      case (.aok, .aok): return true
      case (.aon, .aon): return true
      case (.aor, .aor): return true
      case (.ara, .ara): return true
      case (.arl, .arl): return true
      case (.arm, .arm): return true
      case (.arp, .arp): return true
      case (.ars, .ars): return true
      case (.ats, .ats): return true
      case (.aud, .aud): return true
      case (.awg, .awg): return true
      case (.azm, .azm): return true
      case (.azn, .azn): return true
      case (.bad, .bad): return true
      case (.bam, .bam): return true
      case (.ban, .ban): return true
      case (.bbd, .bbd): return true
      case (.bdt, .bdt): return true
      case (.bec, .bec): return true
      case (.bef, .bef): return true
      case (.bel, .bel): return true
      case (.bgl, .bgl): return true
      case (.bgm, .bgm): return true
      case (.bgn, .bgn): return true
      case (.bgo, .bgo): return true
      case (.bhd, .bhd): return true
      case (.bif, .bif): return true
      case (.bmd, .bmd): return true
      case (.bnd, .bnd): return true
      case (.bob, .bob): return true
      case (.bol, .bol): return true
      case (.bop, .bop): return true
      case (.bov, .bov): return true
      case (.brb, .brb): return true
      case (.brc, .brc): return true
      case (.bre, .bre): return true
      case (.brl, .brl): return true
      case (.brn, .brn): return true
      case (.brr, .brr): return true
      case (.brz, .brz): return true
      case (.bsd, .bsd): return true
      case (.btn, .btn): return true
      case (.buk, .buk): return true
      case (.bwp, .bwp): return true
      case (.byb, .byb): return true
      case (.byn, .byn): return true
      case (.byr, .byr): return true
      case (.bzd, .bzd): return true
      case (.cad, .cad): return true
      case (.cdf, .cdf): return true
      case (.che, .che): return true
      case (.chf, .chf): return true
      case (.chw, .chw): return true
      case (.cle, .cle): return true
      case (.clf, .clf): return true
      case (.clp, .clp): return true
      case (.cnx, .cnx): return true
      case (.cny, .cny): return true
      case (.cop, .cop): return true
      case (.cou, .cou): return true
      case (.crc, .crc): return true
      case (.csd, .csd): return true
      case (.csk, .csk): return true
      case (.cuc, .cuc): return true
      case (.cup, .cup): return true
      case (.cve, .cve): return true
      case (.cyp, .cyp): return true
      case (.czk, .czk): return true
      case (.ddm, .ddm): return true
      case (.dem, .dem): return true
      case (.djf, .djf): return true
      case (.dkk, .dkk): return true
      case (.dop, .dop): return true
      case (.dzd, .dzd): return true
      case (.ecs, .ecs): return true
      case (.ecv, .ecv): return true
      case (.eek, .eek): return true
      case (.egp, .egp): return true
      case (.ern, .ern): return true
      case (.esa, .esa): return true
      case (.esb, .esb): return true
      case (.esp, .esp): return true
      case (.etb, .etb): return true
      case (.eur, .eur): return true
      case (.fim, .fim): return true
      case (.fjd, .fjd): return true
      case (.fkp, .fkp): return true
      case (.frf, .frf): return true
      case (.gbp, .gbp): return true
      case (.gek, .gek): return true
      case (.gel, .gel): return true
      case (.ghc, .ghc): return true
      case (.ghs, .ghs): return true
      case (.gip, .gip): return true
      case (.gmd, .gmd): return true
      case (.gnf, .gnf): return true
      case (.gns, .gns): return true
      case (.gqe, .gqe): return true
      case (.grd, .grd): return true
      case (.gtq, .gtq): return true
      case (.gwe, .gwe): return true
      case (.gwp, .gwp): return true
      case (.gyd, .gyd): return true
      case (.hkd, .hkd): return true
      case (.hnl, .hnl): return true
      case (.hrd, .hrd): return true
      case (.hrk, .hrk): return true
      case (.htg, .htg): return true
      case (.huf, .huf): return true
      case (.idr, .idr): return true
      case (.iep, .iep): return true
      case (.ilp, .ilp): return true
      case (.ilr, .ilr): return true
      case (.ils, .ils): return true
      case (.inr, .inr): return true
      case (.iqd, .iqd): return true
      case (.isj, .isj): return true
      case (.irr, .irr): return true
      case (.isk, .isk): return true
      case (.itl, .itl): return true
      case (.jmd, .jmd): return true
      case (.jod, .jod): return true
      case (.jpy, .jpy): return true
      case (.kes, .kes): return true
      case (.kgs, .kgs): return true
      case (.khr, .khr): return true
      case (.kmf, .kmf): return true
      case (.kpw, .kpw): return true
      case (.krh, .krh): return true
      case (.kro, .kro): return true
      case (.krw, .krw): return true
      case (.kwd, .kwd): return true
      case (.kyd, .kyd): return true
      case (.kzt, .kzt): return true
      case (.lak, .lak): return true
      case (.lbp, .lbp): return true
      case (.lkr, .lkr): return true
      case (.lrd, .lrd): return true
      case (.lsl, .lsl): return true
      case (.ltl, .ltl): return true
      case (.ltt, .ltt): return true
      case (.luc, .luc): return true
      case (.luf, .luf): return true
      case (.lul, .lul): return true
      case (.lvl, .lvl): return true
      case (.lvr, .lvr): return true
      case (.lyd, .lyd): return true
      case (.mad, .mad): return true
      case (.maf, .maf): return true
      case (.mcf, .mcf): return true
      case (.mdc, .mdc): return true
      case (.mdl, .mdl): return true
      case (.mga, .mga): return true
      case (.mgf, .mgf): return true
      case (.mkd, .mkd): return true
      case (.mkn, .mkn): return true
      case (.mlf, .mlf): return true
      case (.mmk, .mmk): return true
      case (.mnt, .mnt): return true
      case (.mop, .mop): return true
      case (.mro, .mro): return true
      case (.mtl, .mtl): return true
      case (.mtp, .mtp): return true
      case (.mur, .mur): return true
      case (.mvp, .mvp): return true
      case (.mvr, .mvr): return true
      case (.mwk, .mwk): return true
      case (.mxn, .mxn): return true
      case (.mxp, .mxp): return true
      case (.mxv, .mxv): return true
      case (.myr, .myr): return true
      case (.mze, .mze): return true
      case (.mzm, .mzm): return true
      case (.mzn, .mzn): return true
      case (.nad, .nad): return true
      case (.ngn, .ngn): return true
      case (.nic, .nic): return true
      case (.nio, .nio): return true
      case (.nlg, .nlg): return true
      case (.nok, .nok): return true
      case (.npr, .npr): return true
      case (.nzd, .nzd): return true
      case (.omr, .omr): return true
      case (.pab, .pab): return true
      case (.pei, .pei): return true
      case (.pen, .pen): return true
      case (.pes, .pes): return true
      case (.pgk, .pgk): return true
      case (.php, .php): return true
      case (.pkr, .pkr): return true
      case (.pln, .pln): return true
      case (.plz, .plz): return true
      case (.pte, .pte): return true
      case (.pyg, .pyg): return true
      case (.qar, .qar): return true
      case (.rhd, .rhd): return true
      case (.rol, .rol): return true
      case (.ron, .ron): return true
      case (.rsd, .rsd): return true
      case (.rub, .rub): return true
      case (.rur, .rur): return true
      case (.rwf, .rwf): return true
      case (.sar, .sar): return true
      case (.sbd, .sbd): return true
      case (.scr, .scr): return true
      case (.sdd, .sdd): return true
      case (.sdg, .sdg): return true
      case (.sdp, .sdp): return true
      case (.sek, .sek): return true
      case (.sgd, .sgd): return true
      case (.shp, .shp): return true
      case (.sit, .sit): return true
      case (.skk, .skk): return true
      case (.sll, .sll): return true
      case (.sos, .sos): return true
      case (.srd, .srd): return true
      case (.srg, .srg): return true
      case (.ssp, .ssp): return true
      case (.std, .std): return true
      case (.sur, .sur): return true
      case (.svc, .svc): return true
      case (.syp, .syp): return true
      case (.szl, .szl): return true
      case (.thb, .thb): return true
      case (.tjr, .tjr): return true
      case (.tjs, .tjs): return true
      case (.tmm, .tmm): return true
      case (.tmt, .tmt): return true
      case (.tnd, .tnd): return true
      case (.top, .top): return true
      case (.tpe, .tpe): return true
      case (.trl, .trl): return true
      case (.try, .try): return true
      case (.ttd, .ttd): return true
      case (.twd, .twd): return true
      case (.tzs, .tzs): return true
      case (.uah, .uah): return true
      case (.uak, .uak): return true
      case (.ugs, .ugs): return true
      case (.ugx, .ugx): return true
      case (.usd, .usd): return true
      case (.usn, .usn): return true
      case (.uss, .uss): return true
      case (.uyi, .uyi): return true
      case (.uyp, .uyp): return true
      case (.uyu, .uyu): return true
      case (.uzs, .uzs): return true
      case (.veb, .veb): return true
      case (.vef, .vef): return true
      case (.vnd, .vnd): return true
      case (.vnn, .vnn): return true
      case (.vuv, .vuv): return true
      case (.wst, .wst): return true
      case (.xaf, .xaf): return true
      case (.xcd, .xcd): return true
      case (.xeu, .xeu): return true
      case (.xfo, .xfo): return true
      case (.xfu, .xfu): return true
      case (.xof, .xof): return true
      case (.xpf, .xpf): return true
      case (.xre, .xre): return true
      case (.ydd, .ydd): return true
      case (.yer, .yer): return true
      case (.yud, .yud): return true
      case (.yum, .yum): return true
      case (.yun, .yun): return true
      case (.yur, .yur): return true
      case (.zal, .zal): return true
      case (.zar, .zar): return true
      case (.zmk, .zmk): return true
      case (.zmw, .zmw): return true
      case (.zrn, .zrn): return true
      case (.zrz, .zrz): return true
      case (.zwd, .zwd): return true
      case (.zwl, .zwl): return true
      case (.zwr, .zwr): return true
      case let (._unknown(lhsValue), ._unknown(rhsValue)): return lhsValue == rhsValue
      default: return false
      }
    }

    static var allCases: [CurrencyCode] {
      return [
        .adp,
        .aed,
        .afa,
        .afn,
        .alk,
        .all,
        .amd,
        .ang,
        .aoa,
        .aok,
        .aon,
        .aor,
        .ara,
        .arl,
        .arm,
        .arp,
        .ars,
        .ats,
        .aud,
        .awg,
        .azm,
        .azn,
        .bad,
        .bam,
        .ban,
        .bbd,
        .bdt,
        .bec,
        .bef,
        .bel,
        .bgl,
        .bgm,
        .bgn,
        .bgo,
        .bhd,
        .bif,
        .bmd,
        .bnd,
        .bob,
        .bol,
        .bop,
        .bov,
        .brb,
        .brc,
        .bre,
        .brl,
        .brn,
        .brr,
        .brz,
        .bsd,
        .btn,
        .buk,
        .bwp,
        .byb,
        .byn,
        .byr,
        .bzd,
        .cad,
        .cdf,
        .che,
        .chf,
        .chw,
        .cle,
        .clf,
        .clp,
        .cnx,
        .cny,
        .cop,
        .cou,
        .crc,
        .csd,
        .csk,
        .cuc,
        .cup,
        .cve,
        .cyp,
        .czk,
        .ddm,
        .dem,
        .djf,
        .dkk,
        .dop,
        .dzd,
        .ecs,
        .ecv,
        .eek,
        .egp,
        .ern,
        .esa,
        .esb,
        .esp,
        .etb,
        .eur,
        .fim,
        .fjd,
        .fkp,
        .frf,
        .gbp,
        .gek,
        .gel,
        .ghc,
        .ghs,
        .gip,
        .gmd,
        .gnf,
        .gns,
        .gqe,
        .grd,
        .gtq,
        .gwe,
        .gwp,
        .gyd,
        .hkd,
        .hnl,
        .hrd,
        .hrk,
        .htg,
        .huf,
        .idr,
        .iep,
        .ilp,
        .ilr,
        .ils,
        .inr,
        .iqd,
        .isj,
        .irr,
        .isk,
        .itl,
        .jmd,
        .jod,
        .jpy,
        .kes,
        .kgs,
        .khr,
        .kmf,
        .kpw,
        .krh,
        .kro,
        .krw,
        .kwd,
        .kyd,
        .kzt,
        .lak,
        .lbp,
        .lkr,
        .lrd,
        .lsl,
        .ltl,
        .ltt,
        .luc,
        .luf,
        .lul,
        .lvl,
        .lvr,
        .lyd,
        .mad,
        .maf,
        .mcf,
        .mdc,
        .mdl,
        .mga,
        .mgf,
        .mkd,
        .mkn,
        .mlf,
        .mmk,
        .mnt,
        .mop,
        .mro,
        .mtl,
        .mtp,
        .mur,
        .mvp,
        .mvr,
        .mwk,
        .mxn,
        .mxp,
        .mxv,
        .myr,
        .mze,
        .mzm,
        .mzn,
        .nad,
        .ngn,
        .nic,
        .nio,
        .nlg,
        .nok,
        .npr,
        .nzd,
        .omr,
        .pab,
        .pei,
        .pen,
        .pes,
        .pgk,
        .php,
        .pkr,
        .pln,
        .plz,
        .pte,
        .pyg,
        .qar,
        .rhd,
        .rol,
        .ron,
        .rsd,
        .rub,
        .rur,
        .rwf,
        .sar,
        .sbd,
        .scr,
        .sdd,
        .sdg,
        .sdp,
        .sek,
        .sgd,
        .shp,
        .sit,
        .skk,
        .sll,
        .sos,
        .srd,
        .srg,
        .ssp,
        .std,
        .sur,
        .svc,
        .syp,
        .szl,
        .thb,
        .tjr,
        .tjs,
        .tmm,
        .tmt,
        .tnd,
        .top,
        .tpe,
        .trl,
        .try,
        .ttd,
        .twd,
        .tzs,
        .uah,
        .uak,
        .ugs,
        .ugx,
        .usd,
        .usn,
        .uss,
        .uyi,
        .uyp,
        .uyu,
        .uzs,
        .veb,
        .vef,
        .vnd,
        .vnn,
        .vuv,
        .wst,
        .xaf,
        .xcd,
        .xeu,
        .xfo,
        .xfu,
        .xof,
        .xpf,
        .xre,
        .ydd,
        .yer,
        .yud,
        .yum,
        .yun,
        .yur,
        .zal,
        .zar,
        .zmk,
        .zmw,
        .zrn,
        .zrz,
        .zwd,
        .zwl,
        .zwr
      ]
    }
  }

  // MARK: - Objects

  struct LoginResult: Codable {
    /// The currently logged in customer.

    let customer: Customer?
    /// The result of a login
    @available(*, deprecated, message: "Use customer node instead.")
    let result: String

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case customer
      case result
    }
  }

  struct LogoutResult: Codable {
    /// The result of a logout

    let result: String

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case result
    }
  }

  struct Mutation: Codable {
    let login: LoginResult

    let logout: LogoutResult

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case login
      case logout
    }
  }

  struct Aggregated: Codable {
    /// Number of available products in stock. This can be 'null' if inventory is not set orif the store's Inventory Settings disable displaying stock levels on the storefront.

    let availableToSell: Double
    /// Indicates a threshold low-stock level.  This can be 'null' if the inventory warning level is not set or if the store's Inventory Settings disable displaying stock levels on the storefront.

    let warningLevel: Int

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case availableToSell
      case warningLevel
    }
  }

  struct AggregatedInventory: Codable {
    /// Number of available products in stock. This can be 'null' if inventory is not set orif the store's Inventory Settings disable displaying stock levels on the storefront.

    let availableToSell: Int
    /// Indicates a threshold low-stock level. This can be 'null' if the inventory warning level is not set or if the store's Inventory Settings disable displaying stock levels on the storefront.

    let warningLevel: Int

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case availableToSell
      case warningLevel
    }
  }

  struct Author: Codable {
    /// Author name.

    let name: String

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case name
    }
  }

  struct Brand: Codable {
    /// Default image for brand.

    let defaultImage: Image?
    /// Id of the brand.

    let entityId: Int
    /// The ID of an object

    let id: String
    /// Meta description for the brand.
    @available(*, deprecated, message: "Use SEO details instead.")
    let metaDesc: String
    /// Meta keywords for the brand.
    @available(*, deprecated, message: "Use SEO details instead.")
    let metaKeywords: [String]
    /// Metafield data related to a brand.

    let metafields: MetafieldConnection
    /// Name of the brand.

    let name: String
    /// Page title for the brand.
    @available(*, deprecated, message: "Use SEO details instead.")
    let pageTitle: String
    /// Path for the brand page.

    let path: String

    let products: ProductConnection
    /// Search keywords for the brand.

    let searchKeywords: [String]
    /// Brand SEO details.

    let seo: SeoDetails

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case defaultImage
      case entityId
      case id
      case metaDesc
      case metaKeywords
      case metafields
      case name
      case pageTitle
      case path
      case products
      case searchKeywords
      case seo
    }
  }

  struct BrandConnection: Codable {
    /// A list of edges.

    let edges: [BrandEdge?]?
    /// Information to aid in pagination.

    let pageInfo: PageInfo

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case edges
      case pageInfo
    }
  }

  struct BrandEdge: Codable {
    /// A cursor for use in pagination.

    let cursor: String
    /// The item at the end of the edge.

    let node: Brand

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case cursor
      case node
    }
  }

  struct Breadcrumb: Codable {
    /// Category id.

    let entityId: Int
    /// Name of the category.

    let name: String

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case entityId
      case name
    }
  }

  struct BreadcrumbConnection: Codable {
    /// A list of edges.

    let edges: [BreadcrumbEdge?]?
    /// Information to aid in pagination.

    let pageInfo: PageInfo

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case edges
      case pageInfo
    }
  }

  struct BreadcrumbEdge: Codable {
    /// A cursor for use in pagination.

    let cursor: String
    /// The item at the end of the edge.

    let node: Breadcrumb

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case cursor
      case node
    }
  }

  struct BulkPricingFixedPriceDiscount: Codable {
    /// Maximum item quantity that applies to this bulk pricing tier - if not defined then the tier does not have an upper bound.

    let maximumQuantity: Int?
    /// Minimum item quantity that applies to this bulk pricing tier.

    let minimumQuantity: Int
    /// This price will override the current product price.

    let price: Double

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case maximumQuantity
      case minimumQuantity
      case price
    }
  }

  struct BulkPricingPercentageDiscount: Codable {
    /// Maximum item quantity that applies to this bulk pricing tier - if not defined then the tier does not have an upper bound.

    let maximumQuantity: Int?
    /// Minimum item quantity that applies to this bulk pricing tier.

    let minimumQuantity: Int
    /// The percentage that will be removed from the product price.

    let percentOff: Double

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case maximumQuantity
      case minimumQuantity
      case percentOff
    }
  }

  struct BulkPricingRelativePriceDiscount: Codable {
    /// Maximum item quantity that applies to this bulk pricing tier - if not defined then the tier does not have an upper bound.

    let maximumQuantity: Int?
    /// Minimum item quantity that applies to this bulk pricing tier.

    let minimumQuantity: Int
    /// The price of the product/variant will be reduced by this priceAdjustment.

    let priceAdjustment: Double

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case maximumQuantity
      case minimumQuantity
      case priceAdjustment
    }
  }

  struct Category: Codable {
    /// Category breadcrumbs.

    let breadcrumbs: BreadcrumbConnection
    /// Default image for the category.

    let defaultImage: Image?
    /// Category description.

    let description: String
    /// Unique ID for the category.

    let entityId: Int
    /// The ID of an object

    let id: String
    /// Metafield data related to a category.

    let metafields: MetafieldConnection
    /// Category name.

    let name: String
    /// Category path.

    let path: String

    let products: ProductConnection
    /// Category SEO details.

    let seo: SeoDetails

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case breadcrumbs
      case defaultImage
      case description
      case entityId
      case id
      case metafields
      case name
      case path
      case products
      case seo
    }
  }

  struct CategoryConnection: Codable {
    /// A list of edges.

    let edges: [CategoryEdge?]?
    /// Information to aid in pagination.

    let pageInfo: PageInfo

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case edges
      case pageInfo
    }
  }

  struct CategoryEdge: Codable {
    /// A cursor for use in pagination.

    let cursor: String
    /// The item at the end of the edge.

    let node: Category

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case cursor
      case node
    }
  }

  struct CategoryTreeItem: Codable {
    /// Subcategories of this category

    let children: [CategoryTreeItem]
    /// The description of this category.

    let description: String
    /// The id category.

    let entityId: Int
    /// The category image.

    let image: Image?
    /// The name of category.

    let name: String
    /// Path assigned to this category

    let path: String
    /// The number of products in this category.

    let productCount: Int

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case children
      case description
      case entityId
      case image
      case name
      case path
      case productCount
    }
  }

  struct CheckboxOption: Codable {
    /// Indicates the default checked status.

    let checkedByDefault: Bool
    /// Display name for the option.

    let displayName: String
    /// Unique ID for the option.

    let entityId: Int
    /// One of the option values is required to be selected for the checkout.

    let isRequired: Bool
    /// Indicates whether it is a variant option or modifier.

    let isVariantOption: Bool

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case checkedByDefault
      case displayName
      case entityId
      case isRequired
      case isVariantOption
    }
  }

  struct ContactField: Codable {
    /// Store address line.

    let address: String
    /// Store address type.

    let addressType: String
    /// Store country.

    let country: String
    /// Store email.

    let email: String
    /// Store phone number.

    let phone: String

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case address
      case addressType
      case country
      case email
      case phone
    }
  }

  struct Content: Codable {
    let renderedRegionsByPageType: RenderedRegionsByPageType

    let renderedRegionsByPageTypeAndEntityId: RenderedRegionsByPageType

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case renderedRegionsByPageType
      case renderedRegionsByPageTypeAndEntityId
    }
  }

  struct Currency: Codable {
    /// Currency code.

    let code: CurrencyCode
    /// Currency display settings.

    let display: CurrencyDisplay
    /// Currency ID.

    let entityId: Int
    /// Exchange rate relative to default currency.

    let exchangeRate: Double
    /// Flag image URL.

    let flagImage: String?
    /// Indicates whether this currency is active.

    let isActive: Bool
    /// Indicates whether this currency is transactional.

    let isTransactional: Bool
    /// Currency name.

    let name: String

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case code
      case display
      case entityId
      case exchangeRate
      case flagImage
      case isActive
      case isTransactional
      case name
    }
  }

  struct CurrencyConnection: Codable {
    /// A list of edges.

    let edges: [CurrencyEdge?]?
    /// Information to aid in pagination.

    let pageInfo: PageInfo

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case edges
      case pageInfo
    }
  }

  struct CurrencyDisplay: Codable {
    /// Currency decimal places.

    let decimalPlaces: Int
    /// Currency decimal token.

    let decimalToken: String
    /// Currency symbol.

    let symbol: String
    /// Currency symbol.

    let symbolPlacement: CurrencySymbolPosition
    /// Currency thousands token.

    let thousandsToken: String

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case decimalPlaces
      case decimalToken
      case symbol
      case symbolPlacement
      case thousandsToken
    }
  }

  struct CurrencyEdge: Codable {
    /// A cursor for use in pagination.

    let cursor: String
    /// The item at the end of the edge.

    let node: Currency

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case cursor
      case node
    }
  }

  struct CustomField: Codable {
    /// Custom field id.

    let entityId: Int
    /// Name of the custom field.

    let name: String
    /// Value of the custom field.

    let value: String

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case entityId
      case name
      case value
    }
  }

  struct CustomFieldConnection: Codable {
    /// A list of edges.

    let edges: [CustomFieldEdge?]?
    /// Information to aid in pagination.

    let pageInfo: PageInfo

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case edges
      case pageInfo
    }
  }

  struct CustomFieldEdge: Codable {
    /// A cursor for use in pagination.

    let cursor: String
    /// The item at the end of the edge.

    let node: CustomField

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case cursor
      case node
    }
  }

  struct Customer: Codable {
    /// Customer addresses count.

    let addressCount: Int
    /// Customer attributes count.

    let attributeCount: Int
    /// Customer attributes.

    let attributes: CustomerAttributes
    /// The company name of the customer.

    let company: String
    /// The customer group id of the customer.

    let customerGroupId: Int
    /// The email address of the customer.

    let email: String
    /// The ID of the customer.

    let entityId: Int
    /// The first name of the customer.

    let firstName: String
    /// The last name of the customer.

    let lastName: String
    /// The notes of the customer.

    let notes: String
    /// The phone number of the customer.

    let phone: String
    /// Customer store credit.

    let storeCredit: [Money]
    /// The tax exempt category of the customer.

    let taxExemptCategory: String

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case addressCount
      case attributeCount
      case attributes
      case company
      case customerGroupId
      case email
      case entityId
      case firstName
      case lastName
      case notes
      case phone
      case storeCredit
      case taxExemptCategory
    }
  }

  struct CustomerAttribute: Codable {
    /// The ID of the custom customer attribute

    let entityId: Int
    /// The name of the custom customer attribute

    let name: String
    /// The value of the custom customer attribute

    let value: String?

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case entityId
      case name
      case value
    }
  }

  struct CustomerAttributes: Codable {
    let attribute: CustomerAttribute

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case attribute
    }
  }

  struct DateFieldOption: Codable {
    /// Display name for the option.

    let displayName: String
    /// Unique ID for the option.

    let entityId: Int
    /// One of the option values is required to be selected for the checkout.

    let isRequired: Bool
    /// Indicates whether it is a variant option or modifier.

    let isVariantOption: Bool

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case displayName
      case entityId
      case isRequired
      case isVariantOption
    }
  }

  struct DateTimeExtended: Codable {
    /// ISO-8601 formatted date in UTC

    let utc: Double

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case utc
    }
  }

  struct DisplayField: Codable {
    /// Extended date format.

    let extendedDateFormat: String
    /// Short date format.

    let shortDateFormat: String

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case extendedDateFormat
      case shortDateFormat
    }
  }

  struct Distance: Codable {
    /// Length unit

    let lengthUnit: LengthUnit
    /// Distance in specified length unit

    let value: Double

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case lengthUnit
      case value
    }
  }

  struct FileUploadFieldOption: Codable {
    /// Display name for the option.

    let displayName: String
    /// Unique ID for the option.

    let entityId: Int
    /// One of the option values is required to be selected for the checkout.

    let isRequired: Bool
    /// Indicates whether it is a variant option or modifier.

    let isVariantOption: Bool

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case displayName
      case entityId
      case isRequired
      case isVariantOption
    }
  }

  struct Image: Codable {
    /// Text description of an image that can be used for SEO and/or accessibility purposes.

    let altText: String
    /// Indicates whether this is the primary image.

    let isDefault: Bool
    /// Absolute path to image using store CDN.

    let url: String
    /// Absolute path to original image using store CDN.

    let urlOriginal: String

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case altText
      case isDefault
      case url
      case urlOriginal
    }
  }

  struct ImageConnection: Codable {
    /// A list of edges.

    let edges: [ImageEdge?]?
    /// Information to aid in pagination.

    let pageInfo: PageInfo

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case edges
      case pageInfo
    }
  }

  struct ImageEdge: Codable {
    /// A cursor for use in pagination.

    let cursor: String
    /// The item at the end of the edge.

    let node: Image

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case cursor
      case node
    }
  }

  struct Inventory: Codable {
    /// Locations

    let locations: LocationConnection

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case locations
    }
  }

  struct InventoryByLocations: Codable {
    /// Number of available products in stock.

    let availableToSell: Double
    /// Indicates whether this product is in stock.

    let isInStock: Bool
    /// Distance between location and specified longitude and latitude

    let locationDistance: Distance?
    /// Location code.

    let locationEntityCode: String
    /// Location id.

    let locationEntityId: Double
    /// Location service type ids.
    @available(*, deprecated, message: "Deprecated. Will be substituted with pickup methods.")
    let locationEntityServiceTypeIds: [String]
    /// Location type id.

    let locationEntityTypeId: String?
    /// Indicates a threshold low-stock level.

    let warningLevel: Int

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case availableToSell
      case isInStock
      case locationDistance
      case locationEntityCode
      case locationEntityId
      case locationEntityServiceTypeIds
      case locationEntityTypeId
      case warningLevel
    }
  }

  struct LocationConnection: Codable {
    /// A list of edges.

    let edges: [LocationEdge?]?
    /// Information to aid in pagination.

    let pageInfo: PageInfo

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case edges
      case pageInfo
    }
  }

  struct LocationEdge: Codable {
    /// A cursor for use in pagination.

    let cursor: String
    /// The item at the end of the edge.

    let node: InventoryByLocations

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case cursor
      case node
    }
  }

  struct LogoField: Codable {
    /// Store logo image.

    let image: Image
    /// Logo title.

    let title: String

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case image
      case title
    }
  }

  struct Measurement: Codable {
    /// Unit of measurement.

    let unit: String
    /// Unformatted weight measurement value.

    let value: Double

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case unit
      case value
    }
  }

  struct MetafieldConnection: Codable {
    /// A list of edges.

    let edges: [MetafieldEdge?]?
    /// Information to aid in pagination.

    let pageInfo: PageInfo

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case edges
      case pageInfo
    }
  }

  struct MetafieldEdge: Codable {
    /// A cursor for use in pagination.

    let cursor: String
    /// The item at the end of the edge.

    let node: Metafields

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case cursor
      case node
    }
  }

  struct Metafields: Codable {
    /// The ID of the metafield when referencing via our backend API.

    let entityId: Int
    /// The ID of an object

    let id: String
    /// A label for identifying a metafield data value.

    let key: String
    /// A metafield value.

    let value: String

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case entityId
      case id
      case key
      case value
    }
  }

  struct Money: Codable {
    /// Currency code of the current money.

    let currencyCode: String
    /// The amount of money.

    let value: Double

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case currencyCode
      case value
    }
  }

  struct MoneyRange: Codable {
    /// Maximum money object.

    let max: Money
    /// Minimum money object.

    let min: Money

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case max
      case min
    }
  }

  struct MultiLineTextFieldOption: Codable {
    /// Display name for the option.

    let displayName: String
    /// Unique ID for the option.

    let entityId: Int
    /// One of the option values is required to be selected for the checkout.

    let isRequired: Bool
    /// Indicates whether it is a variant option or modifier.

    let isVariantOption: Bool

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case displayName
      case entityId
      case isRequired
      case isVariantOption
    }
  }

  struct MultipleChoiceOption: Codable {
    /// Display name for the option.

    let displayName: String
    /// The chosen display style for this multiple choice option.

    let displayStyle: String
    /// Unique ID for the option.

    let entityId: Int
    /// One of the option values is required to be selected for the checkout.

    let isRequired: Bool
    /// Indicates whether it is a variant option or modifier.

    let isVariantOption: Bool
    /// List of option values.

    let values: ProductOptionValueConnection

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case displayName
      case displayStyle
      case entityId
      case isRequired
      case isVariantOption
      case values
    }
  }

  struct MultipleChoiceOptionValue: Codable {
    /// Unique ID for the option value.

    let entityId: Int
    /// Indicates whether this value is the chosen default selected value.

    let isDefault: Bool
    /// Label for the option value.

    let label: String

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case entityId
      case isDefault
      case label
    }
  }

  struct NumberFieldOption: Codable {
    /// Display name for the option.

    let displayName: String
    /// Unique ID for the option.

    let entityId: Int
    /// One of the option values is required to be selected for the checkout.

    let isRequired: Bool
    /// Indicates whether it is a variant option or modifier.

    let isVariantOption: Bool

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case displayName
      case entityId
      case isRequired
      case isVariantOption
    }
  }

  struct OptionConnection: Codable {
    /// A list of edges.

    let edges: [OptionEdge?]?
    /// Information to aid in pagination.

    let pageInfo: PageInfo

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case edges
      case pageInfo
    }
  }

  struct OptionEdge: Codable {
    /// A cursor for use in pagination.

    let cursor: String
    /// The item at the end of the edge.

    let node: ProductOption

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case cursor
      case node
    }
  }

  struct OptionValueConnection: Codable {
    /// A list of edges.

    let edges: [OptionValueEdge?]?
    /// Information to aid in pagination.

    let pageInfo: PageInfo

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case edges
      case pageInfo
    }
  }

  struct OptionValueEdge: Codable {
    /// A cursor for use in pagination.

    let cursor: String
    /// The item at the end of the edge.

    let node: ProductOptionValue

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case cursor
      case node
    }
  }

  struct PageInfo: Codable {
    /// When paginating forwards, the cursor to continue.

    let endCursor: String?
    /// When paginating forwards, are there more items?

    let hasNextPage: Bool
    /// When paginating backwards, are there more items?

    let hasPreviousPage: Bool
    /// When paginating backwards, the cursor to continue.

    let startCursor: String?

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case endCursor
      case hasNextPage
      case hasPreviousPage
      case startCursor
    }
  }

  struct PriceRanges: Codable {
    /// Product price min/max range.

    let priceRange: MoneyRange
    /// Product retail price min/max range.

    let retailPriceRange: MoneyRange?

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case priceRange
      case retailPriceRange
    }
  }

  struct Prices: Codable {
    /// Original price of the product.

    let basePrice: Money?
    /// List of bulk pricing tiers applicable to a product or variant.

    let bulkPricing: [BulkPricingTier]
    /// Minimum advertised price of the product.

    let mapPrice: Money?
    /// Calculated price of the product.  Calculated price takes into account basePrice, salePrice, rules (modifier, option, option set) that apply to the product configuration, and customer group discounts.  It represents the in-cart price for a product configuration without bulk pricing rules.

    let price: Money
    /// Product price min/max range.

    let priceRange: MoneyRange
    /// Retail price of the product.

    let retailPrice: Money?
    /// Product retail price min/max range.

    let retailPriceRange: MoneyRange?
    /// Sale price of the product.

    let salePrice: Money?
    /// The difference between the retail price (MSRP) and the current price, which can be presented to the shopper as their savings.

    let saved: Money?

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case basePrice
      case bulkPricing
      case mapPrice
      case price
      case priceRange
      case retailPrice
      case retailPriceRange
      case salePrice
      case saved
    }
  }

  struct Product: Codable {
    /// Absolute URL path for adding a product to cart.

    let addToCartUrl: String
    /// Absolute URL path for adding a product to customer's wishlist.
    @available(*, deprecated, message: "Deprecated.")
    let addToWishlistUrl: String
    /// The availability state of the product.
    @available(*, deprecated, message: "Use status inside availabilityV2 instead.")
    let availability: String
    /// A few words telling the customer how long it will normally take to ship this product, such as 'Usually ships in 24 hours'.
    @available(*, deprecated, message: "Use description inside availabilityV2 instead.")
    let availabilityDescription: String
    /// The availability state of the product.

    let availabilityV2: ProductAvailability
    /// Brand associated with the product.

    let brand: Brand?
    /// List of categories associated with the product.

    let categories: CategoryConnection
    /// Product creation date
    @available(*, deprecated, message: "Alpha version. Do not use in production.")
    let createdAt: DateTimeExtended
    /// Custom fields of the product.

    let customFields: CustomFieldConnection
    /// Default image for a product.

    let defaultImage: Image?
    /// Depth of the product.

    let depth: Measurement?
    /// Description of the product.

    let description: String
    /// Id of the product.

    let entityId: Int
    /// Global trade item number.

    let gtin: String?
    /// Height of the product.

    let height: Measurement?
    /// The ID of an object

    let id: String
    /// A list of the images for a product.

    let images: ImageConnection
    /// Inventory information of the product.

    let inventory: ProductInventory
    /// Maximum purchasable quantity for this product in a single order.

    let maxPurchaseQuantity: Int?
    /// Metafield data related to a product.

    let metafields: MetafieldConnection
    /// Minimum purchasable quantity for this product in a single order.

    let minPurchaseQuantity: Int?
    /// Manufacturer part number.

    let mpn: String?
    /// Name of the product.

    let name: String
    /// Product options.
    @available(*, deprecated, message: "Use productOptions instead.")
    let options: OptionConnection
    /// Relative URL path to product page.

    let path: String
    /// Description of the product in plain text.

    let plainTextDescription: String
    /// The minimum and maximum price of this product based on variant pricing and/or modifier price rules.
    @available(*, deprecated, message: "Use priceRanges inside prices node instead.")
    let priceRanges: PriceRanges?
    /// Prices object determined by supplied product ID, variant ID, and selected option IDs.

    let prices: Prices?
    /// Product options.

    let productOptions: ProductOptionConnection
    /// Related products for this product.

    let relatedProducts: RelatedProductsConnection
    /// Summary of the product reviews, includes the total number of reviews submitted and summation of the ratings on the reviews (ratings range from 0-5 per review).

    let reviewSummary: Reviews
    /// Reviews associated with the product.

    let reviews: ReviewConnection
    /// Product SEO details.

    let seo: SeoDetails
    /// Default product variant when no options are selected.

    let sku: String
    /// Type of product, ex: physical, digital

    let type: String
    /// Universal product code.

    let upc: String?
    /// Variants associated with the product.

    let variants: VariantConnection
    /// Warranty information of the product.

    let warranty: String
    /// Weight of the product.

    let weight: Measurement?
    /// Width of the product.

    let width: Measurement?

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case addToCartUrl
      case addToWishlistUrl
      case availability
      case availabilityDescription
      case availabilityV2
      case brand
      case categories
      case createdAt
      case customFields
      case defaultImage
      case depth
      case description
      case entityId
      case gtin
      case height
      case id
      case images
      case inventory
      case maxPurchaseQuantity
      case metafields
      case minPurchaseQuantity
      case mpn
      case name
      case options
      case path
      case plainTextDescription
      case priceRanges
      case prices
      case productOptions
      case relatedProducts
      case reviewSummary
      case reviews
      case seo
      case sku
      case type
      case upc
      case variants
      case warranty
      case weight
      case width
    }
  }

  struct ProductAvailable: Codable {
    /// A few words telling the customer how long it will normally take to ship this product, such as 'Usually ships in 24 hours'.

    let description: String
    /// The availability state of the product.

    let status: ProductAvailabilityStatus

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case description
      case status
    }
  }

  struct ProductConnection: Codable {
    /// A list of edges.

    let edges: [ProductEdge?]?
    /// Information to aid in pagination.

    let pageInfo: PageInfo

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case edges
      case pageInfo
    }
  }

  struct ProductEdge: Codable {
    /// A cursor for use in pagination.

    let cursor: String
    /// The item at the end of the edge.

    let node: Product

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case cursor
      case node
    }
  }

  struct ProductInventory: Codable {
    /// Aggregated product inventory information. This data may not be available if not set or if the store's Inventory Settings have disabled displaying stock levels on the storefront.

    let aggregated: AggregatedInventory?
    /// Indicates whether this product's inventory is being tracked on variant level. If true, you may wish to check the variants node to understand the true inventory of each individual variant, rather than relying on this product-level aggregate to understand how many items may be added to cart.

    let hasVariantInventory: Bool
    /// Indicates whether this product is in stock.

    let isInStock: Bool

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case aggregated
      case hasVariantInventory
      case isInStock
    }
  }

  struct ProductOption: Codable {
    /// Display name for the option.

    let displayName: String
    /// Unique ID for the option.

    let entityId: Int
    /// One of the option values is required to be selected for the checkout.

    let isRequired: Bool
    /// Option values.

    let values: OptionValueConnection

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case displayName
      case entityId
      case isRequired
      case values
    }
  }

  struct ProductOptionConnection: Codable {
    /// A list of edges.

    let edges: [ProductOptionEdge?]?
    /// Information to aid in pagination.

    let pageInfo: PageInfo

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case edges
      case pageInfo
    }
  }

  struct ProductOptionEdge: Codable {
    /// A cursor for use in pagination.

    let cursor: String
    /// The item at the end of the edge.

    let node: CatalogProductOption

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case cursor
      case node
    }
  }

  struct ProductOptionValue: Codable {
    /// Unique ID for the option value.

    let entityId: Int
    /// Label for the option value.

    let label: String

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case entityId
      case label
    }
  }

  struct ProductOptionValueConnection: Codable {
    /// A list of edges.

    let edges: [ProductOptionValueEdge?]?
    /// Information to aid in pagination.

    let pageInfo: PageInfo

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case edges
      case pageInfo
    }
  }

  struct ProductOptionValueEdge: Codable {
    /// A cursor for use in pagination.

    let cursor: String
    /// The item at the end of the edge.

    let node: CatalogProductOptionValue

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case cursor
      case node
    }
  }

  struct ProductPickListOptionValue: Codable {
    /// Unique ID for the option value.

    let entityId: Int
    /// Indicates whether this value is the chosen default selected value.

    let isDefault: Bool
    /// Label for the option value.

    let label: String
    /// The ID of the product associated with this option value.

    let productId: Int

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case entityId
      case isDefault
      case label
      case productId
    }
  }

  struct ProductPreOrder: Codable {
    /// A few words telling the customer how long it will normally take to ship this product, such as 'Usually ships in 24 hours'.

    let description: String
    /// The message to be shown in the store when a product is put into the pre-order availability state, e.g. "Expected release date is %%DATE%%"

    let message: String?
    /// The availability state of the product.

    let status: ProductAvailabilityStatus
    /// Product release date

    let willBeReleasedAt: DateTimeExtended?

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case description
      case message
      case status
      case willBeReleasedAt
    }
  }

  struct ProductUnavailable: Codable {
    /// A few words telling the customer how long it will normally take to ship this product, such as 'Usually ships in 24 hours'.

    let description: String
    /// The message to be shown in the store when "Call for pricing" is enabled for this product, e.g. "Contact us at 555-5555"

    let message: String?
    /// The availability state of the product.

    let status: ProductAvailabilityStatus

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case description
      case message
      case status
    }
  }

  struct Query: Codable {
    /// The currently logged in customer.

    let customer: Customer?

    @available(*, deprecated, message: "Alpha version. Do not use in production.")
    let inventory: Inventory
    /// Fetches an object given its ID

    let node: Node?

    let site: Site

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case customer
      case inventory
      case node
      case site
    }
  }

  struct Region: Codable {
    /// The rendered HTML content targeted at the region.

    let html: String
    /// The name of a region.

    let name: String

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case html
      case name
    }
  }

  struct RelatedProductsConnection: Codable {
    /// A list of edges.

    let edges: [RelatedProductsEdge?]?
    /// Information to aid in pagination.

    let pageInfo: PageInfo

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case edges
      case pageInfo
    }
  }

  struct RelatedProductsEdge: Codable {
    /// A cursor for use in pagination.

    let cursor: String
    /// The item at the end of the edge.

    let node: Product

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case cursor
      case node
    }
  }

  struct RenderedRegionsByPageType: Codable {
    let regions: [Region]

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case regions
    }
  }

  struct Review: Codable {
    /// Product review author.

    let author: Author
    /// Product review creation date.

    let createdAt: DateTimeExtended
    /// Unique ID for the product review.

    let entityId: Double
    /// Product review rating.

    let rating: Int
    /// Product review text.

    let text: String
    /// Product review title.

    let title: String

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case author
      case createdAt
      case entityId
      case rating
      case text
      case title
    }
  }

  struct ReviewConnection: Codable {
    /// A list of edges.

    let edges: [ReviewEdge?]?
    /// Information to aid in pagination.

    let pageInfo: PageInfo

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case edges
      case pageInfo
    }
  }

  struct ReviewEdge: Codable {
    /// A cursor for use in pagination.

    let cursor: String
    /// The item at the end of the edge.

    let node: Review

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case cursor
      case node
    }
  }

  struct Reviews: Codable {
    /// Average rating of the product.
    @available(*, deprecated, message: "Alpha version. Do not use in production.")
    let averageRating: Double
    /// Total number of reviews on product.

    let numberOfReviews: Int
    /// Summation of rating scores from each review.

    let summationOfRatings: Int

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case averageRating
      case numberOfReviews
      case summationOfRatings
    }
  }

  struct Route: Codable {
    /// node

    let node: Node?

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case node
    }
  }

  struct Search: Codable {
    /// Product filtering enabled.

    let productFilteringEnabled: Bool

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case productFilteringEnabled
    }
  }

  struct SearchProducts: Codable {
    /// Details of the products.

    let products: ProductConnection

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case products
    }
  }

  struct SearchQueries: Codable {
    /// Details of the products and facets matching given search criteria.

    let searchProducts: SearchProducts

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case searchProducts
    }
  }

  struct SeoDetails: Codable {
    /// Meta description.

    let metaDescription: String
    /// Meta keywords.

    let metaKeywords: String
    /// Page title.

    let pageTitle: String

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case metaDescription
      case metaKeywords
      case pageTitle
    }
  }

  struct Settings: Codable {
    /// Channel ID.

    let channelId: Double
    /// Contact information for the store.

    let contact: ContactField?
    /// Store display format information.

    let display: DisplayField
    /// Logo information for the store.

    let logo: LogoField
    /// Store search settings.

    let search: Search
    /// The current store status.

    let status: StorefrontStatusType
    /// The hash of the store.

    let storeHash: String
    /// The name of the store.

    let storeName: String

    let tax: TaxDisplaySettings?
    /// Store urls.

    let url: UrlField

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case channelId
      case contact
      case display
      case logo
      case search
      case status
      case storeHash
      case storeName
      case tax
      case url
    }
  }

  struct Site: Codable {
    /// Details of the best selling products.

    let bestSellingProducts: ProductConnection
    /// Details of the brand.

    let brands: BrandConnection

    let categoryTree: [CategoryTreeItem]

    let content: Content
    /// Store Currencies.

    let currencies: CurrencyConnection
    /// Currency details.

    let currency: Currency?
    /// Details of the featured products.

    let featuredProducts: ProductConnection
    /// Details of the newest products.

    let newestProducts: ProductConnection
    /// A single product object with variant pricing overlay capabilities.

    let product: Product?
    /// Details of the products.

    let products: ProductConnection
    /// Route for a node

    let route: Route
    /// The Search queries.
    @available(*, deprecated, message: "Alpha version. Do not use in production.")
    let search: SearchQueries
    /// Store settings.

    let settings: Settings?

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case bestSellingProducts
      case brands
      case categoryTree
      case content
      case currencies
      case currency
      case featuredProducts
      case newestProducts
      case product
      case products
      case route
      case search
      case settings
    }
  }

  struct SwatchOptionValue: Codable {
    /// Unique ID for the option value.

    let entityId: Int
    /// List of up to 3 hex encoded colors to associate with a swatch value.

    let hexColors: [String]
    /// Absolute path of a swatch texture image.

    let imageUrl: String?
    /// Indicates whether this value is the chosen default selected value.

    let isDefault: Bool
    /// Label for the option value.

    let label: String

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case entityId
      case hexColors
      case imageUrl
      case isDefault
      case label
    }
  }

  struct TaxDisplaySettings: Codable {
    /// Tax display setting for Product Details Page.

    let pdp: TaxPriceDisplay
    /// Tax display setting for Product List Page.

    let plp: TaxPriceDisplay

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case pdp
      case plp
    }
  }

  struct TextFieldOption: Codable {
    /// Display name for the option.

    let displayName: String
    /// Unique ID for the option.

    let entityId: Int
    /// One of the option values is required to be selected for the checkout.

    let isRequired: Bool
    /// Indicates whether it is a variant option or modifier.

    let isVariantOption: Bool

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case displayName
      case entityId
      case isRequired
      case isVariantOption
    }
  }

  struct UrlField: Codable {
    /// CDN url to fetch assets.

    let cdnUrl: String
    /// Store url.

    let vanityUrl: String

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case cdnUrl
      case vanityUrl
    }
  }

  struct Variant: Codable {
    /// Default image for a variant.

    let defaultImage: Image?
    /// The variant's depth. If a depth was not explicitly specified on the variant, this will be the product's depth.

    let depth: Measurement?
    /// Id of the variant.

    let entityId: Int
    /// Global trade item number.

    let gtin: String?
    /// The variant's height. If a height was not explicitly specified on the variant, this will be the product's height.

    let height: Measurement?
    /// The ID of an object

    let id: String
    /// Variant inventory

    let inventory: VariantInventory?
    /// Metafield data related to a variant.

    let metafields: MetafieldConnection
    /// Manufacturer part number.

    let mpn: String?
    /// The options which define a variant.

    let options: OptionConnection
    /// Variant prices

    let prices: Prices?
    /// Product options that compose this variant.

    let productOptions: ProductOptionConnection
    /// Sku of the variant.

    let sku: String
    /// Universal product code.

    let upc: String?
    /// The variant's weight. If a weight was not explicitly specified on the variant, this will be the product's weight.

    let weight: Measurement?
    /// The variant's width. If a width was not explicitly specified on the variant, this will be the product's width.

    let width: Measurement?

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case defaultImage
      case depth
      case entityId
      case gtin
      case height
      case id
      case inventory
      case metafields
      case mpn
      case options
      case prices
      case productOptions
      case sku
      case upc
      case weight
      case width
    }
  }

  struct VariantConnection: Codable {
    /// A list of edges.

    let edges: [VariantEdge?]?
    /// Information to aid in pagination.

    let pageInfo: PageInfo

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case edges
      case pageInfo
    }
  }

  struct VariantEdge: Codable {
    /// A cursor for use in pagination.

    let cursor: String
    /// The item at the end of the edge.

    let node: Variant

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case cursor
      case node
    }
  }

  struct VariantInventory: Codable {
    /// Aggregated product variant inventory information. This data may not be available if not set or if the store's Inventory Settings have disabled displaying stock levels on the storefront.

    let aggregated: Aggregated?
    /// Inventory by locations.

    let byLocation: LocationConnection?
    /// Indicates whether this product is in stock.

    let isInStock: Bool

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case aggregated
      case byLocation
      case isInStock
    }
  }

  struct BulkPricingTier: Codable {
    /// Maximum item quantity that applies to this bulk pricing tier - if not defined then the tier does not have an upper bound.

    let maximumQuantity: Int?
    /// Minimum item quantity that applies to this bulk pricing tier.

    let minimumQuantity: Int

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case maximumQuantity
      case minimumQuantity
    }
  }

  struct CatalogProductOption: Codable {
    /// Display name for the option.

    let displayName: String
    /// Unique ID for the option.

    let entityId: Int
    /// One of the option values is required to be selected for the checkout.

    let isRequired: Bool
    /// Indicates whether it is a variant option or modifier.

    let isVariantOption: Bool

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case displayName
      case entityId
      case isRequired
      case isVariantOption
    }
  }

  struct CatalogProductOptionValue: Codable {
    /// Unique ID for the option value.

    let entityId: Int
    /// Indicates whether this value is the chosen default selected value.

    let isDefault: Bool
    /// Label for the option value.

    let label: String

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case entityId
      case isDefault
      case label
    }
  }

  struct Node: Codable {
    /// The id of the object.

    let id: String

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case id
    }
  }

  struct ProductAvailability: Codable {
    /// A few words telling the customer how long it will normally take to ship this product, such as 'Usually ships in 24 hours'.

    let description: String
    /// The availability state of the product.

    let status: ProductAvailabilityStatus

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case description
      case status
    }
  }

  // MARK: - Input Objects

  struct DistanceFilter: Encodable {
    /// Radius of search in length units specified in lengthUnit argument
    let radius: Double
    /// Signed decimal degrees without compass direction
    let longitude: Double
    /// Signed decimal degrees without compass direction
    let latitude: Double

    let lengthUnit: LengthUnit

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case radius
      case longitude
      case latitude
      case lengthUnit
    }
  }

  struct OptionValueId: Encodable {
    let optionEntityId: Int

    let valueEntityId: Int

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case optionEntityId
      case valueEntityId
    }
  }

  struct PriceSearchFilterInput: Encodable {
    let minPrice: Double?

    let maxPrice: Double?

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case minPrice
      case maxPrice
    }
  }

  struct ProductAttributeSearchFilterInput: Encodable {
    let attribute: String

    let values: [String]

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case attribute
      case values
    }
  }

  struct ProductReviewsFiltersInput: Encodable {
    let rating: ProductReviewsRatingFilterInput?

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case rating
    }
  }

  struct ProductReviewsRatingFilterInput: Encodable {
    let minRating: Int?

    let maxRating: Int?

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case minRating
      case maxRating
    }
  }

  struct RatingSearchFilterInput: Encodable {
    let minRating: Double?

    let maxRating: Double?

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case minRating
      case maxRating
    }
  }

  struct SearchProductsFiltersInput: Encodable {
    let searchTerm: String?

    let price: PriceSearchFilterInput?

    let rating: RatingSearchFilterInput?

    let categoryEntityId: Int?

    let categoryEntityIds: [Int]?

    let brandEntityIds: [Int]?

    let productAttributes: [ProductAttributeSearchFilterInput]?

    let isFreeShipping: Bool?

    let isFeatured: Bool?

    let isInStock: Bool?

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case searchTerm
      case price
      case rating
      case categoryEntityId
      case categoryEntityIds
      case brandEntityIds
      case productAttributes
      case isFreeShipping
      case isFeatured
      case isInStock
    }
  }
}

// MARK: - GraphQLRequestParameter

extension BigCommerceGraphQL {
  enum QueryParameter {}
}

// MARK: - QueryParameter

extension BigCommerceGraphQL.QueryParameter {
  // MARK: - SiteRequestParameter

  struct SiteRequestParameter: GraphQLRequestParameter {
    // MARK: - GraphQLRequestType

    let requestType: GraphQLRequestType = .query

    // MARK: - Operation Defintion

    private let operationDefinitionFormat: String = """
    query {
      site {
    ...SiteFragment
    }
    }

    %1$@
    """

    var operationDefinition: String {
      String(
        format: operationDefinitionFormat,
        selections.declaration()
      )
    }

    // MARK: - Arguments

    // MARK: - Selections

    let selections: Selections

    struct Selections: GraphQLSelections {
      let aggregatedInventorySelections: Set<AggregatedInventorySelection>

      enum AggregatedInventorySelection: String, GraphQLSelection {
        case availableToSell
        case warningLevel
      }

      let authorSelections: Set<AuthorSelection>

      enum AuthorSelection: String, GraphQLSelection {
        case name
      }

      let brandSelections: Set<BrandSelection>

      enum BrandSelection: String, GraphQLSelection {
        case defaultImage = """
        defaultImage {
          ...ImageFragment
        }
        """
        case entityId
        case id
        case metaDesc
        case metaKeywords
        case metafields = """
        metafields {
          ...MetafieldConnectionFragment
        }
        """
        case name
        case pageTitle
        case path
        case products = """
        products {
          ...ProductConnectionFragment
        }
        """
        case searchKeywords
        case seo = """
        seo {
          ...SeoDetailsFragment
        }
        """
      }

      let brandConnectionSelections: Set<BrandConnectionSelection>

      enum BrandConnectionSelection: String, GraphQLSelection {
        case edges = """
        edges {
          ...BrandEdgeFragment
        }
        """
        case pageInfo = """
        pageInfo {
          ...PageInfoFragment
        }
        """
      }

      let breadcrumbConnectionSelections: Set<BreadcrumbConnectionSelection>

      enum BreadcrumbConnectionSelection: String, GraphQLSelection {
        case edges = """
        edges {
          ...BreadcrumbEdgeFragment
        }
        """
        case pageInfo = """
        pageInfo {
          ...PageInfoFragment
        }
        """
      }

      let categoryConnectionSelections: Set<CategoryConnectionSelection>

      enum CategoryConnectionSelection: String, GraphQLSelection {
        case edges = """
        edges {
          ...CategoryEdgeFragment
        }
        """
        case pageInfo = """
        pageInfo {
          ...PageInfoFragment
        }
        """
      }

      let categoryTreeItemSelections: Set<CategoryTreeItemSelection>

      enum CategoryTreeItemSelection: String, GraphQLSelection {
        case children = """
        children {
          ...CategoryTreeItemFragment
        }
        """
        case description
        case entityId
        case image = """
        image {
          ...ImageFragment
        }
        """
        case name
        case path
        case productCount
      }

      let contactFieldSelections: Set<ContactFieldSelection>

      enum ContactFieldSelection: String, GraphQLSelection {
        case address
        case addressType
        case country
        case email
        case phone
      }

      let contentSelections: Set<ContentSelection>

      enum ContentSelection: String, GraphQLSelection {
        case renderedRegionsByPageType = """
        renderedRegionsByPageType {
          ...RenderedRegionsByPageTypeFragment
        }
        """
        case renderedRegionsByPageTypeAndEntityId = """
        renderedRegionsByPageTypeAndEntityId {
          ...RenderedRegionsByPageTypeFragment
        }
        """
      }

      let currencySelections: Set<CurrencySelection>

      enum CurrencySelection: String, GraphQLSelection {
        case code
        case display = """
        display {
          ...CurrencyDisplayFragment
        }
        """
        case entityId
        case exchangeRate
        case flagImage
        case isActive
        case isTransactional
        case name
      }

      let currencyConnectionSelections: Set<CurrencyConnectionSelection>

      enum CurrencyConnectionSelection: String, GraphQLSelection {
        case edges = """
        edges {
          ...CurrencyEdgeFragment
        }
        """
        case pageInfo = """
        pageInfo {
          ...PageInfoFragment
        }
        """
      }

      let currencyDisplaySelections: Set<CurrencyDisplaySelection>

      enum CurrencyDisplaySelection: String, GraphQLSelection {
        case decimalPlaces
        case decimalToken
        case symbol
        case symbolPlacement
        case thousandsToken
      }

      let currencyEdgeSelections: Set<CurrencyEdgeSelection>

      enum CurrencyEdgeSelection: String, GraphQLSelection {
        case cursor
        case node = """
        node {
          ...CurrencyFragment
        }
        """
      }

      let customFieldConnectionSelections: Set<CustomFieldConnectionSelection>

      enum CustomFieldConnectionSelection: String, GraphQLSelection {
        case edges = """
        edges {
          ...CustomFieldEdgeFragment
        }
        """
        case pageInfo = """
        pageInfo {
          ...PageInfoFragment
        }
        """
      }

      let dateTimeExtendedSelections: Set<DateTimeExtendedSelection>

      enum DateTimeExtendedSelection: String, GraphQLSelection {
        case utc
      }

      let displayFieldSelections: Set<DisplayFieldSelection>

      enum DisplayFieldSelection: String, GraphQLSelection {
        case extendedDateFormat
        case shortDateFormat
      }

      let imageSelections: Set<ImageSelection>

      enum ImageSelection: String, GraphQLSelection {
        case altText
        case isDefault
        case url
        case urlOriginal
      }

      let imageConnectionSelections: Set<ImageConnectionSelection>

      enum ImageConnectionSelection: String, GraphQLSelection {
        case edges = """
        edges {
          ...ImageEdgeFragment
        }
        """
        case pageInfo = """
        pageInfo {
          ...PageInfoFragment
        }
        """
      }

      let logoFieldSelections: Set<LogoFieldSelection>

      enum LogoFieldSelection: String, GraphQLSelection {
        case image = """
        image {
          ...ImageFragment
        }
        """
        case title
      }

      let measurementSelections: Set<MeasurementSelection>

      enum MeasurementSelection: String, GraphQLSelection {
        case unit
        case value
      }

      let metafieldConnectionSelections: Set<MetafieldConnectionSelection>

      enum MetafieldConnectionSelection: String, GraphQLSelection {
        case edges = """
        edges {
          ...MetafieldEdgeFragment
        }
        """
        case pageInfo = """
        pageInfo {
          ...PageInfoFragment
        }
        """
      }

      let metafieldEdgeSelections: Set<MetafieldEdgeSelection>

      enum MetafieldEdgeSelection: String, GraphQLSelection {
        case cursor
        case node = """
        node {
          ...MetafieldsFragment
        }
        """
      }

      let metafieldsSelections: Set<MetafieldsSelection>

      enum MetafieldsSelection: String, GraphQLSelection {
        case entityId
        case id
        case key
        case value
      }

      let optionConnectionSelections: Set<OptionConnectionSelection>

      enum OptionConnectionSelection: String, GraphQLSelection {
        case edges = """
        edges {
          ...OptionEdgeFragment
        }
        """
        case pageInfo = """
        pageInfo {
          ...PageInfoFragment
        }
        """
      }

      let optionValueConnectionSelections: Set<OptionValueConnectionSelection>

      enum OptionValueConnectionSelection: String, GraphQLSelection {
        case edges = """
        edges {
          ...OptionValueEdgeFragment
        }
        """
        case pageInfo = """
        pageInfo {
          ...PageInfoFragment
        }
        """
      }

      let pageInfoSelections: Set<PageInfoSelection>

      enum PageInfoSelection: String, GraphQLSelection {
        case endCursor
        case hasNextPage
        case hasPreviousPage
        case startCursor
      }

      let priceRangesSelections: Set<PriceRangesSelection>

      enum PriceRangesSelection: String, GraphQLSelection {
        case priceRange = """
        priceRange {
          ...MoneyRangeFragment
        }
        """
        case retailPriceRange = """
        retailPriceRange {
          ...MoneyRangeFragment
        }
        """
      }

      let pricesSelections: Set<PricesSelection>

      enum PricesSelection: String, GraphQLSelection {
        case basePrice = """
        basePrice {
          ...MoneyFragment
        }
        """
        case bulkPricing = """
        bulkPricing {
          ...BulkPricingTierFragment
        }
        """
        case mapPrice = """
        mapPrice {
          ...MoneyFragment
        }
        """
        case price = """
        price {
          ...MoneyFragment
        }
        """
        case priceRange = """
        priceRange {
          ...MoneyRangeFragment
        }
        """
        case retailPrice = """
        retailPrice {
          ...MoneyFragment
        }
        """
        case retailPriceRange = """
        retailPriceRange {
          ...MoneyRangeFragment
        }
        """
        case salePrice = """
        salePrice {
          ...MoneyFragment
        }
        """
        case saved = """
        saved {
          ...MoneyFragment
        }
        """
      }

      let productSelections: Set<ProductSelection>

      enum ProductSelection: String, GraphQLSelection {
        case addToCartUrl
        case addToWishlistUrl
        case availability
        case availabilityDescription
        case availabilityV2 = """
        availabilityV2 {
          ...ProductAvailabilityFragment
        }
        """
        case brand = """
        brand {
          ...BrandFragment
        }
        """
        case categories = """
        categories {
          ...CategoryConnectionFragment
        }
        """
        case createdAt = """
        createdAt {
          ...DateTimeExtendedFragment
        }
        """
        case customFields = """
        customFields {
          ...CustomFieldConnectionFragment
        }
        """
        case defaultImage = """
        defaultImage {
          ...ImageFragment
        }
        """
        case depth = """
        depth {
          ...MeasurementFragment
        }
        """
        case description
        case entityId
        case gtin
        case height = """
        height {
          ...MeasurementFragment
        }
        """
        case id
        case images = """
        images {
          ...ImageConnectionFragment
        }
        """
        case inventory = """
        inventory {
          ...ProductInventoryFragment
        }
        """
        case maxPurchaseQuantity
        case metafields = """
        metafields {
          ...MetafieldConnectionFragment
        }
        """
        case minPurchaseQuantity
        case mpn
        case name
        case options = """
        options {
          ...OptionConnectionFragment
        }
        """
        case path
        case plainTextDescription
        case priceRanges = """
        priceRanges {
          ...PriceRangesFragment
        }
        """
        case prices = """
        prices {
          ...PricesFragment
        }
        """
        case productOptions = """
        productOptions {
          ...ProductOptionConnectionFragment
        }
        """
        case relatedProducts = """
        relatedProducts {
          ...RelatedProductsConnectionFragment
        }
        """
        case reviewSummary = """
        reviewSummary {
          ...ReviewsFragment
        }
        """
        case reviews = """
        reviews {
          ...ReviewConnectionFragment
        }
        """
        case seo = """
        seo {
          ...SeoDetailsFragment
        }
        """
        case sku
        case type
        case upc
        case variants = """
        variants {
          ...VariantConnectionFragment
        }
        """
        case warranty
        case weight = """
        weight {
          ...MeasurementFragment
        }
        """
        case width = """
        width {
          ...MeasurementFragment
        }
        """
      }

      let productConnectionSelections: Set<ProductConnectionSelection>

      enum ProductConnectionSelection: String, GraphQLSelection {
        case edges = """
        edges {
          ...ProductEdgeFragment
        }
        """
        case pageInfo = """
        pageInfo {
          ...PageInfoFragment
        }
        """
      }

      let productInventorySelections: Set<ProductInventorySelection>

      enum ProductInventorySelection: String, GraphQLSelection {
        case aggregated = """
        aggregated {
          ...AggregatedInventoryFragment
        }
        """
        case hasVariantInventory
        case isInStock
      }

      let productOptionConnectionSelections: Set<ProductOptionConnectionSelection>

      enum ProductOptionConnectionSelection: String, GraphQLSelection {
        case edges = """
        edges {
          ...ProductOptionEdgeFragment
        }
        """
        case pageInfo = """
        pageInfo {
          ...PageInfoFragment
        }
        """
      }

      let regionSelections: Set<RegionSelection>

      enum RegionSelection: String, GraphQLSelection {
        case html
        case name
      }

      let relatedProductsConnectionSelections: Set<RelatedProductsConnectionSelection>

      enum RelatedProductsConnectionSelection: String, GraphQLSelection {
        case edges = """
        edges {
          ...RelatedProductsEdgeFragment
        }
        """
        case pageInfo = """
        pageInfo {
          ...PageInfoFragment
        }
        """
      }

      let renderedRegionsByPageTypeSelections: Set<RenderedRegionsByPageTypeSelection>

      enum RenderedRegionsByPageTypeSelection: String, GraphQLSelection {
        case regions = """
        regions {
          ...RegionFragment
        }
        """
      }

      let reviewSelections: Set<ReviewSelection>

      enum ReviewSelection: String, GraphQLSelection {
        case author = """
        author {
          ...AuthorFragment
        }
        """
        case createdAt = """
        createdAt {
          ...DateTimeExtendedFragment
        }
        """
        case entityId
        case rating
        case text
        case title
      }

      let reviewConnectionSelections: Set<ReviewConnectionSelection>

      enum ReviewConnectionSelection: String, GraphQLSelection {
        case edges = """
        edges {
          ...ReviewEdgeFragment
        }
        """
        case pageInfo = """
        pageInfo {
          ...PageInfoFragment
        }
        """
      }

      let reviewEdgeSelections: Set<ReviewEdgeSelection>

      enum ReviewEdgeSelection: String, GraphQLSelection {
        case cursor
        case node = """
        node {
          ...ReviewFragment
        }
        """
      }

      let reviewsSelections: Set<ReviewsSelection>

      enum ReviewsSelection: String, GraphQLSelection {
        case averageRating
        case numberOfReviews
        case summationOfRatings
      }

      let routeSelections: Set<RouteSelection>

      enum RouteSelection: String, GraphQLSelection {
        case node = """
        node {
          ...NodeFragment
        }
        """
      }

      let searchSelections: Set<SearchSelection>

      enum SearchSelection: String, GraphQLSelection {
        case productFilteringEnabled
      }

      let searchProductsSelections: Set<SearchProductsSelection>

      enum SearchProductsSelection: String, GraphQLSelection {
        case products = """
        products {
          ...ProductConnectionFragment
        }
        """
      }

      let searchQueriesSelections: Set<SearchQueriesSelection>

      enum SearchQueriesSelection: String, GraphQLSelection {
        case searchProducts = """
        searchProducts {
          ...SearchProductsFragment
        }
        """
      }

      let seoDetailsSelections: Set<SeoDetailsSelection>

      enum SeoDetailsSelection: String, GraphQLSelection {
        case metaDescription
        case metaKeywords
        case pageTitle
      }

      let settingsSelections: Set<SettingsSelection>

      enum SettingsSelection: String, GraphQLSelection {
        case channelId
        case contact = """
        contact {
          ...ContactFieldFragment
        }
        """
        case display = """
        display {
          ...DisplayFieldFragment
        }
        """
        case logo = """
        logo {
          ...LogoFieldFragment
        }
        """
        case search = """
        search {
          ...SearchFragment
        }
        """
        case status
        case storeHash
        case storeName
        case tax = """
        tax {
          ...TaxDisplaySettingsFragment
        }
        """
        case url = """
        url {
          ...UrlFieldFragment
        }
        """
      }

      let siteSelections: Set<SiteSelection>

      enum SiteSelection: String, GraphQLSelection {
        case bestSellingProducts = """
        bestSellingProducts {
          ...ProductConnectionFragment
        }
        """
        case brands = """
        brands {
          ...BrandConnectionFragment
        }
        """
        case categoryTree = """
        categoryTree {
          ...CategoryTreeItemFragment
        }
        """
        case content = """
        content {
          ...ContentFragment
        }
        """
        case currencies = """
        currencies {
          ...CurrencyConnectionFragment
        }
        """
        case currency = """
        currency {
          ...CurrencyFragment
        }
        """
        case featuredProducts = """
        featuredProducts {
          ...ProductConnectionFragment
        }
        """
        case newestProducts = """
        newestProducts {
          ...ProductConnectionFragment
        }
        """
        case product = """
        product {
          ...ProductFragment
        }
        """
        case products = """
        products {
          ...ProductConnectionFragment
        }
        """
        case route = """
        route {
          ...RouteFragment
        }
        """
        case search = """
        search {
          ...SearchQueriesFragment
        }
        """
        case settings = """
        settings {
          ...SettingsFragment
        }
        """
      }

      let taxDisplaySettingsSelections: Set<TaxDisplaySettingsSelection>

      enum TaxDisplaySettingsSelection: String, GraphQLSelection {
        case pdp
        case plp
      }

      let urlFieldSelections: Set<UrlFieldSelection>

      enum UrlFieldSelection: String, GraphQLSelection {
        case cdnUrl
        case vanityUrl
      }

      let variantConnectionSelections: Set<VariantConnectionSelection>

      enum VariantConnectionSelection: String, GraphQLSelection {
        case edges = """
        edges {
          ...VariantEdgeFragment
        }
        """
        case pageInfo = """
        pageInfo {
          ...PageInfoFragment
        }
        """
      }

      func declaration() -> String {
        let aggregatedInventorySelectionsDeclaration = """
        fragment AggregatedInventoryFragment on AggregatedInventory {\(aggregatedInventorySelections.declaration)
        }
        """

        let authorSelectionsDeclaration = """
        fragment AuthorFragment on Author {\(authorSelections.declaration)
        }
        """

        let brandSelectionsDeclaration = """
        fragment BrandFragment on Brand {\(brandSelections.declaration)
        }
        """

        let brandConnectionSelectionsDeclaration = """
        fragment BrandConnectionFragment on BrandConnection {\(brandConnectionSelections.declaration)
        }
        """

        let breadcrumbConnectionSelectionsDeclaration = """
        fragment BreadcrumbConnectionFragment on BreadcrumbConnection {\(breadcrumbConnectionSelections.declaration)
        }
        """

        let categoryConnectionSelectionsDeclaration = """
        fragment CategoryConnectionFragment on CategoryConnection {\(categoryConnectionSelections.declaration)
        }
        """

        let categoryTreeItemSelectionsDeclaration = """
        fragment CategoryTreeItemFragment on CategoryTreeItem {\(categoryTreeItemSelections.declaration)
        }
        """

        let contactFieldSelectionsDeclaration = """
        fragment ContactFieldFragment on ContactField {\(contactFieldSelections.declaration)
        }
        """

        let contentSelectionsDeclaration = """
        fragment ContentFragment on Content {\(contentSelections.declaration)
        }
        """

        let currencySelectionsDeclaration = """
        fragment CurrencyFragment on Currency {\(currencySelections.declaration)
        }
        """

        let currencyConnectionSelectionsDeclaration = """
        fragment CurrencyConnectionFragment on CurrencyConnection {\(currencyConnectionSelections.declaration)
        }
        """

        let currencyDisplaySelectionsDeclaration = """
        fragment CurrencyDisplayFragment on CurrencyDisplay {\(currencyDisplaySelections.declaration)
        }
        """

        let currencyEdgeSelectionsDeclaration = """
        fragment CurrencyEdgeFragment on CurrencyEdge {\(currencyEdgeSelections.declaration)
        }
        """

        let customFieldConnectionSelectionsDeclaration = """
        fragment CustomFieldConnectionFragment on CustomFieldConnection {\(customFieldConnectionSelections.declaration)
        }
        """

        let dateTimeExtendedSelectionsDeclaration = """
        fragment DateTimeExtendedFragment on DateTimeExtended {\(dateTimeExtendedSelections.declaration)
        }
        """

        let displayFieldSelectionsDeclaration = """
        fragment DisplayFieldFragment on DisplayField {\(displayFieldSelections.declaration)
        }
        """

        let imageSelectionsDeclaration = """
        fragment ImageFragment on Image {\(imageSelections.declaration)
        }
        """

        let imageConnectionSelectionsDeclaration = """
        fragment ImageConnectionFragment on ImageConnection {\(imageConnectionSelections.declaration)
        }
        """

        let logoFieldSelectionsDeclaration = """
        fragment LogoFieldFragment on LogoField {\(logoFieldSelections.declaration)
        }
        """

        let measurementSelectionsDeclaration = """
        fragment MeasurementFragment on Measurement {\(measurementSelections.declaration)
        }
        """

        let metafieldConnectionSelectionsDeclaration = """
        fragment MetafieldConnectionFragment on MetafieldConnection {\(metafieldConnectionSelections.declaration)
        }
        """

        let metafieldEdgeSelectionsDeclaration = """
        fragment MetafieldEdgeFragment on MetafieldEdge {\(metafieldEdgeSelections.declaration)
        }
        """

        let metafieldsSelectionsDeclaration = """
        fragment MetafieldsFragment on Metafields {\(metafieldsSelections.declaration)
        }
        """

        let optionConnectionSelectionsDeclaration = """
        fragment OptionConnectionFragment on OptionConnection {\(optionConnectionSelections.declaration)
        }
        """

        let optionValueConnectionSelectionsDeclaration = """
        fragment OptionValueConnectionFragment on OptionValueConnection {\(optionValueConnectionSelections.declaration)
        }
        """

        let pageInfoSelectionsDeclaration = """
        fragment PageInfoFragment on PageInfo {\(pageInfoSelections.declaration)
        }
        """

        let priceRangesSelectionsDeclaration = """
        fragment PriceRangesFragment on PriceRanges {\(priceRangesSelections.declaration)
        }
        """

        let pricesSelectionsDeclaration = """
        fragment PricesFragment on Prices {\(pricesSelections.declaration)
        }
        """

        let productSelectionsDeclaration = """
        fragment ProductFragment on Product {\(productSelections.declaration)
        }
        """

        let productConnectionSelectionsDeclaration = """
        fragment ProductConnectionFragment on ProductConnection {\(productConnectionSelections.declaration)
        }
        """

        let productInventorySelectionsDeclaration = """
        fragment ProductInventoryFragment on ProductInventory {\(productInventorySelections.declaration)
        }
        """

        let productOptionConnectionSelectionsDeclaration = """
        fragment ProductOptionConnectionFragment on ProductOptionConnection {\(productOptionConnectionSelections.declaration)
        }
        """

        let regionSelectionsDeclaration = """
        fragment RegionFragment on Region {\(regionSelections.declaration)
        }
        """

        let relatedProductsConnectionSelectionsDeclaration = """
        fragment RelatedProductsConnectionFragment on RelatedProductsConnection {\(relatedProductsConnectionSelections.declaration)
        }
        """

        let renderedRegionsByPageTypeSelectionsDeclaration = """
        fragment RenderedRegionsByPageTypeFragment on RenderedRegionsByPageType {\(renderedRegionsByPageTypeSelections.declaration)
        }
        """

        let reviewSelectionsDeclaration = """
        fragment ReviewFragment on Review {\(reviewSelections.declaration)
        }
        """

        let reviewConnectionSelectionsDeclaration = """
        fragment ReviewConnectionFragment on ReviewConnection {\(reviewConnectionSelections.declaration)
        }
        """

        let reviewEdgeSelectionsDeclaration = """
        fragment ReviewEdgeFragment on ReviewEdge {\(reviewEdgeSelections.declaration)
        }
        """

        let reviewsSelectionsDeclaration = """
        fragment ReviewsFragment on Reviews {\(reviewsSelections.declaration)
        }
        """

        let routeSelectionsDeclaration = """
        fragment RouteFragment on Route {\(routeSelections.declaration)
        }
        """

        let searchSelectionsDeclaration = """
        fragment SearchFragment on Search {\(searchSelections.declaration)
        }
        """

        let searchProductsSelectionsDeclaration = """
        fragment SearchProductsFragment on SearchProducts {\(searchProductsSelections.declaration)
        }
        """

        let searchQueriesSelectionsDeclaration = """
        fragment SearchQueriesFragment on SearchQueries {\(searchQueriesSelections.declaration)
        }
        """

        let seoDetailsSelectionsDeclaration = """
        fragment SeoDetailsFragment on SeoDetails {\(seoDetailsSelections.declaration)
        }
        """

        let settingsSelectionsDeclaration = """
        fragment SettingsFragment on Settings {\(settingsSelections.declaration)
        }
        """

        let siteSelectionsDeclaration = """
        fragment SiteFragment on Site {\(siteSelections.declaration)
        }
        """

        let taxDisplaySettingsSelectionsDeclaration = """
        fragment TaxDisplaySettingsFragment on TaxDisplaySettings {\(taxDisplaySettingsSelections.declaration)
        }
        """

        let urlFieldSelectionsDeclaration = """
        fragment UrlFieldFragment on UrlField {\(urlFieldSelections.declaration)
        }
        """

        let variantConnectionSelectionsDeclaration = """
        fragment VariantConnectionFragment on VariantConnection {\(variantConnectionSelections.declaration)
        }
        """

        let selectionDeclarationMap = [
          "AggregatedInventoryFragment": aggregatedInventorySelectionsDeclaration,
          "AuthorFragment": authorSelectionsDeclaration,
          "BrandFragment": brandSelectionsDeclaration,
          "BrandConnectionFragment": brandConnectionSelectionsDeclaration,
          "BreadcrumbConnectionFragment": breadcrumbConnectionSelectionsDeclaration,
          "CategoryConnectionFragment": categoryConnectionSelectionsDeclaration,
          "CategoryTreeItemFragment": categoryTreeItemSelectionsDeclaration,
          "ContactFieldFragment": contactFieldSelectionsDeclaration,
          "ContentFragment": contentSelectionsDeclaration,
          "CurrencyFragment": currencySelectionsDeclaration,
          "CurrencyConnectionFragment": currencyConnectionSelectionsDeclaration,
          "CurrencyDisplayFragment": currencyDisplaySelectionsDeclaration,
          "CurrencyEdgeFragment": currencyEdgeSelectionsDeclaration,
          "CustomFieldConnectionFragment": customFieldConnectionSelectionsDeclaration,
          "DateTimeExtendedFragment": dateTimeExtendedSelectionsDeclaration,
          "DisplayFieldFragment": displayFieldSelectionsDeclaration,
          "ImageFragment": imageSelectionsDeclaration,
          "ImageConnectionFragment": imageConnectionSelectionsDeclaration,
          "LogoFieldFragment": logoFieldSelectionsDeclaration,
          "MeasurementFragment": measurementSelectionsDeclaration,
          "MetafieldConnectionFragment": metafieldConnectionSelectionsDeclaration,
          "MetafieldEdgeFragment": metafieldEdgeSelectionsDeclaration,
          "MetafieldsFragment": metafieldsSelectionsDeclaration,
          "OptionConnectionFragment": optionConnectionSelectionsDeclaration,
          "OptionValueConnectionFragment": optionValueConnectionSelectionsDeclaration,
          "PageInfoFragment": pageInfoSelectionsDeclaration,
          "PriceRangesFragment": priceRangesSelectionsDeclaration,
          "PricesFragment": pricesSelectionsDeclaration,
          "ProductFragment": productSelectionsDeclaration,
          "ProductConnectionFragment": productConnectionSelectionsDeclaration,
          "ProductInventoryFragment": productInventorySelectionsDeclaration,
          "ProductOptionConnectionFragment": productOptionConnectionSelectionsDeclaration,
          "RegionFragment": regionSelectionsDeclaration,
          "RelatedProductsConnectionFragment": relatedProductsConnectionSelectionsDeclaration,
          "RenderedRegionsByPageTypeFragment": renderedRegionsByPageTypeSelectionsDeclaration,
          "ReviewFragment": reviewSelectionsDeclaration,
          "ReviewConnectionFragment": reviewConnectionSelectionsDeclaration,
          "ReviewEdgeFragment": reviewEdgeSelectionsDeclaration,
          "ReviewsFragment": reviewsSelectionsDeclaration,
          "RouteFragment": routeSelectionsDeclaration,
          "SearchFragment": searchSelectionsDeclaration,
          "SearchProductsFragment": searchProductsSelectionsDeclaration,
          "SearchQueriesFragment": searchQueriesSelectionsDeclaration,
          "SeoDetailsFragment": seoDetailsSelectionsDeclaration,
          "SettingsFragment": settingsSelectionsDeclaration,
          "SiteFragment": siteSelectionsDeclaration,
          "TaxDisplaySettingsFragment": taxDisplaySettingsSelectionsDeclaration,
          "UrlFieldFragment": urlFieldSelectionsDeclaration,
          "VariantConnectionFragment": variantConnectionSelectionsDeclaration
        ]

        return declaration(selectionDeclarationMap: selectionDeclarationMap, rootSelectionKey: "SiteFragment")
      }
    }

    func encode(to _: Encoder) throws {}
  }

  // MARK: - CustomerRequestParameter

  struct CustomerRequestParameter: GraphQLRequestParameter {
    // MARK: - GraphQLRequestType

    let requestType: GraphQLRequestType = .query

    // MARK: - Operation Defintion

    private let operationDefinitionFormat: String = """
    query {
      customer {
    ...CustomerFragment
    }
    }

    %1$@
    """

    var operationDefinition: String {
      String(
        format: operationDefinitionFormat,
        selections.declaration()
      )
    }

    // MARK: - Arguments

    // MARK: - Selections

    let selections: Selections

    struct Selections: GraphQLSelections {
      let customerSelections: Set<CustomerSelection>

      enum CustomerSelection: String, GraphQLSelection {
        case addressCount
        case attributeCount
        case attributes = """
        attributes {
          ...CustomerAttributesFragment
        }
        """
        case company
        case customerGroupId
        case email
        case entityId
        case firstName
        case lastName
        case notes
        case phone
        case storeCredit = """
        storeCredit {
          ...MoneyFragment
        }
        """
        case taxExemptCategory
      }

      let customerAttributeSelections: Set<CustomerAttributeSelection>

      enum CustomerAttributeSelection: String, GraphQLSelection {
        case entityId
        case name
        case value
      }

      let customerAttributesSelections: Set<CustomerAttributesSelection>

      enum CustomerAttributesSelection: String, GraphQLSelection {
        case attribute = """
        attribute {
          ...CustomerAttributeFragment
        }
        """
      }

      let moneySelections: Set<MoneySelection>

      enum MoneySelection: String, GraphQLSelection {
        case currencyCode
        case value
      }

      func declaration() -> String {
        let customerSelectionsDeclaration = """
        fragment CustomerFragment on Customer {\(customerSelections.declaration)
        }
        """

        let customerAttributeSelectionsDeclaration = """
        fragment CustomerAttributeFragment on CustomerAttribute {\(customerAttributeSelections.declaration)
        }
        """

        let customerAttributesSelectionsDeclaration = """
        fragment CustomerAttributesFragment on CustomerAttributes {\(customerAttributesSelections.declaration)
        }
        """

        let moneySelectionsDeclaration = """
        fragment MoneyFragment on Money {\(moneySelections.declaration)
        }
        """

        let selectionDeclarationMap = [
          "CustomerFragment": customerSelectionsDeclaration,
          "CustomerAttributeFragment": customerAttributeSelectionsDeclaration,
          "CustomerAttributesFragment": customerAttributesSelectionsDeclaration,
          "MoneyFragment": moneySelectionsDeclaration
        ]

        return declaration(selectionDeclarationMap: selectionDeclarationMap, rootSelectionKey: "CustomerFragment")
      }
    }

    func encode(to _: Encoder) throws {}
  }

  // MARK: - NodeRequestParameter

  struct NodeRequestParameter: GraphQLRequestParameter {
    // MARK: - GraphQLRequestType

    let requestType: GraphQLRequestType = .query

    // MARK: - Operation Defintion

    private let operationDefinitionFormat: String = """
    query(
      $id: ID!
    ) {
      node(
        id: $id
    ) {
    ...NodeFragment
    }
    }

    %1$@
    """

    var operationDefinition: String {
      String(
        format: operationDefinitionFormat,
        selections.declaration()
      )
    }

    // MARK: - Arguments

    /// The ID of an object
    let id: String

    // MARK: - Selections

    let selections: Selections

    struct Selections: GraphQLSelections {
      let nodeSelections: Set<NodeSelection>

      enum NodeSelection: String, GraphQLSelection {
        case id
      }

      func declaration() -> String {
        let nodeSelectionsDeclaration = """
        fragment NodeFragment on Node {\(nodeSelections.declaration)
        }
        """

        let selectionDeclarationMap = [
          "NodeFragment": nodeSelectionsDeclaration
        ]

        return declaration(selectionDeclarationMap: selectionDeclarationMap, rootSelectionKey: "NodeFragment")
      }
    }

    private enum CodingKeys: String, CodingKey {
      /// The ID of an object
      case id
    }
  }

  // MARK: - InventoryRequestParameter

  struct InventoryRequestParameter: GraphQLRequestParameter {
    // MARK: - GraphQLRequestType

    let requestType: GraphQLRequestType = .query

    // MARK: - Operation Defintion

    private let operationDefinitionFormat: String = """
    query {
      inventory {
    ...InventoryFragment
    }
    }

    %1$@
    """

    var operationDefinition: String {
      String(
        format: operationDefinitionFormat,
        selections.declaration()
      )
    }

    // MARK: - Arguments

    // MARK: - Selections

    let selections: Selections

    struct Selections: GraphQLSelections {
      let distanceSelections: Set<DistanceSelection>

      enum DistanceSelection: String, GraphQLSelection {
        case lengthUnit
        case value
      }

      let inventorySelections: Set<InventorySelection>

      enum InventorySelection: String, GraphQLSelection {
        case locations = """
        locations {
          ...LocationConnectionFragment
        }
        """
      }

      let inventoryByLocationsSelections: Set<InventoryByLocationsSelection>

      enum InventoryByLocationsSelection: String, GraphQLSelection {
        case availableToSell
        case isInStock
        case locationDistance = """
        locationDistance {
          ...DistanceFragment
        }
        """
        case locationEntityCode
        case locationEntityId
        case locationEntityServiceTypeIds
        case locationEntityTypeId
        case warningLevel
      }

      let locationConnectionSelections: Set<LocationConnectionSelection>

      enum LocationConnectionSelection: String, GraphQLSelection {
        case edges = """
        edges {
          ...LocationEdgeFragment
        }
        """
        case pageInfo = """
        pageInfo {
          ...PageInfoFragment
        }
        """
      }

      let locationEdgeSelections: Set<LocationEdgeSelection>

      enum LocationEdgeSelection: String, GraphQLSelection {
        case cursor
        case node = """
        node {
          ...InventoryByLocationsFragment
        }
        """
      }

      let pageInfoSelections: Set<PageInfoSelection>

      enum PageInfoSelection: String, GraphQLSelection {
        case endCursor
        case hasNextPage
        case hasPreviousPage
        case startCursor
      }

      func declaration() -> String {
        let distanceSelectionsDeclaration = """
        fragment DistanceFragment on Distance {\(distanceSelections.declaration)
        }
        """

        let inventorySelectionsDeclaration = """
        fragment InventoryFragment on Inventory {\(inventorySelections.declaration)
        }
        """

        let inventoryByLocationsSelectionsDeclaration = """
        fragment InventoryByLocationsFragment on InventoryByLocations {\(inventoryByLocationsSelections.declaration)
        }
        """

        let locationConnectionSelectionsDeclaration = """
        fragment LocationConnectionFragment on LocationConnection {\(locationConnectionSelections.declaration)
        }
        """

        let locationEdgeSelectionsDeclaration = """
        fragment LocationEdgeFragment on LocationEdge {\(locationEdgeSelections.declaration)
        }
        """

        let pageInfoSelectionsDeclaration = """
        fragment PageInfoFragment on PageInfo {\(pageInfoSelections.declaration)
        }
        """

        let selectionDeclarationMap = [
          "DistanceFragment": distanceSelectionsDeclaration,
          "InventoryFragment": inventorySelectionsDeclaration,
          "InventoryByLocationsFragment": inventoryByLocationsSelectionsDeclaration,
          "LocationConnectionFragment": locationConnectionSelectionsDeclaration,
          "LocationEdgeFragment": locationEdgeSelectionsDeclaration,
          "PageInfoFragment": pageInfoSelectionsDeclaration
        ]

        return declaration(selectionDeclarationMap: selectionDeclarationMap, rootSelectionKey: "InventoryFragment")
      }
    }

    func encode(to _: Encoder) throws {}
  }
}

extension BigCommerceGraphQL {
  enum MutationParameter {}
}

// MARK: - MutationParameter

extension BigCommerceGraphQL.MutationParameter {
  // MARK: - LoginResultRequestParameter

  struct LoginResultRequestParameter: GraphQLRequestParameter {
    // MARK: - GraphQLRequestType

    let requestType: GraphQLRequestType = .mutation

    // MARK: - Operation Defintion

    private let operationDefinitionFormat: String = """
    mutation(
      $email: String!
      $password: String!
    ) {
      login(
        email: $email
        password: $password
    ) {
    ...LoginResultFragment
    }
    }

    %1$@
    """

    var operationDefinition: String {
      String(
        format: operationDefinitionFormat,
        selections.declaration()
      )
    }

    // MARK: - Arguments

    let email: String

    let password: String

    // MARK: - Selections

    let selections: Selections

    struct Selections: GraphQLSelections {
      let customerSelections: Set<CustomerSelection>

      enum CustomerSelection: String, GraphQLSelection {
        case addressCount
        case attributeCount
        case attributes = """
        attributes {
          ...CustomerAttributesFragment
        }
        """
        case company
        case customerGroupId
        case email
        case entityId
        case firstName
        case lastName
        case notes
        case phone
        case storeCredit = """
        storeCredit {
          ...MoneyFragment
        }
        """
        case taxExemptCategory
      }

      let customerAttributeSelections: Set<CustomerAttributeSelection>

      enum CustomerAttributeSelection: String, GraphQLSelection {
        case entityId
        case name
        case value
      }

      let customerAttributesSelections: Set<CustomerAttributesSelection>

      enum CustomerAttributesSelection: String, GraphQLSelection {
        case attribute = """
        attribute {
          ...CustomerAttributeFragment
        }
        """
      }

      let loginResultSelections: Set<LoginResultSelection>

      enum LoginResultSelection: String, GraphQLSelection {
        case customer = """
        customer {
          ...CustomerFragment
        }
        """
        case result
      }

      let moneySelections: Set<MoneySelection>

      enum MoneySelection: String, GraphQLSelection {
        case currencyCode
        case value
      }

      func declaration() -> String {
        let customerSelectionsDeclaration = """
        fragment CustomerFragment on Customer {\(customerSelections.declaration)
        }
        """

        let customerAttributeSelectionsDeclaration = """
        fragment CustomerAttributeFragment on CustomerAttribute {\(customerAttributeSelections.declaration)
        }
        """

        let customerAttributesSelectionsDeclaration = """
        fragment CustomerAttributesFragment on CustomerAttributes {\(customerAttributesSelections.declaration)
        }
        """

        let loginResultSelectionsDeclaration = """
        fragment LoginResultFragment on LoginResult {\(loginResultSelections.declaration)
        }
        """

        let moneySelectionsDeclaration = """
        fragment MoneyFragment on Money {\(moneySelections.declaration)
        }
        """

        let selectionDeclarationMap = [
          "CustomerFragment": customerSelectionsDeclaration,
          "CustomerAttributeFragment": customerAttributeSelectionsDeclaration,
          "CustomerAttributesFragment": customerAttributesSelectionsDeclaration,
          "LoginResultFragment": loginResultSelectionsDeclaration,
          "MoneyFragment": moneySelectionsDeclaration
        ]

        return declaration(selectionDeclarationMap: selectionDeclarationMap, rootSelectionKey: "LoginResultFragment")
      }
    }

    private enum CodingKeys: String, CodingKey {
      case email

      case password
    }
  }

  // MARK: - LogoutResultRequestParameter

  struct LogoutResultRequestParameter: GraphQLRequestParameter {
    // MARK: - GraphQLRequestType

    let requestType: GraphQLRequestType = .mutation

    // MARK: - Operation Defintion

    private let operationDefinitionFormat: String = """
    mutation {
      logout {
    ...LogoutResultFragment
    }
    }

    %1$@
    """

    var operationDefinition: String {
      String(
        format: operationDefinitionFormat,
        selections.declaration()
      )
    }

    // MARK: - Arguments

    // MARK: - Selections

    let selections: Selections

    struct Selections: GraphQLSelections {
      let logoutResultSelections: Set<LogoutResultSelection>

      enum LogoutResultSelection: String, GraphQLSelection {
        case result
      }

      func declaration() -> String {
        let logoutResultSelectionsDeclaration = """
        fragment LogoutResultFragment on LogoutResult {\(logoutResultSelections.declaration)
        }
        """

        let selectionDeclarationMap = [
          "LogoutResultFragment": logoutResultSelectionsDeclaration
        ]

        return declaration(selectionDeclarationMap: selectionDeclarationMap, rootSelectionKey: "LogoutResultFragment")
      }
    }

    func encode(to _: Encoder) throws {}
  }
}
