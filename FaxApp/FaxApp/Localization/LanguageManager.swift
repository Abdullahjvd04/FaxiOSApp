////
////  LanguageManager.swift
////  FaxApp
////
////  Created by Ios Dev on 04/03/2026.
////
//
//import SwiftUI
//import Combine
//class LanguageManager: ObservableObject {
//    
//    @AppStorage("appLanguage") private var appLanguage: String = SupportedLanguage.english.rawValue {
//        didSet {
//            objectWillChange.send()
//        }
//    }
//    
//    var locale: Locale {
//        Locale(identifier: appLanguage)
//    }
//    
//    var currentLanguage: SupportedLanguage {
//        SupportedLanguage(rawValue: appLanguage) ?? .english
//    }
//    
//    func setLanguage(_ language: SupportedLanguage) {
//        appLanguage = language.rawValue
//    }
//}
//
//
//
//enum SupportedLanguage: String, CaseIterable, Identifiable {
//    
//    case english = "en"
//    case french = "fr"
//    
//    var id: String { rawValue }
//    
//    var locale: Locale {
//        Locale(identifier: rawValue)
//    }
//    
//    var localizedName: LocalizedStringKey {
//        switch self {
//        case .english:
//            return "english"
//        case .french:
//            return "french"
//        }
//    }
//}


//
//  LanguageManager.swift
//  FaxApp
//
//  Created by Ios Dev on 04/03/2026.
//

import SwiftUI
import Combine

class LanguageManager: ObservableObject {
    
    @AppStorage("appLanguage") private var appLanguage: String = SupportedLanguage.english.rawValue {
        didSet {
            objectWillChange.send()
        }
    }
    
    var locale: Locale {
        Locale(identifier: appLanguage)
    }
    
    var currentLanguage: SupportedLanguage {
        SupportedLanguage(rawValue: appLanguage) ?? .english
    }
    
    func setLanguage(_ language: SupportedLanguage) {
        appLanguage = language.rawValue
    }
}

enum SupportedLanguage: String, CaseIterable, Identifiable {
    
    case arabic = "ar"
    case bulgarian = "bg"
    case bengali = "bn"
    case catalan = "ca"
    case czech = "cs"
    case danish = "da"
    case german = "de"
    case greek = "el"
    case english = "en"
    case englishAU = "en-AU"
    case englishGB = "en-GB"
    case englishIN = "en-IN"
    case englishUS = "en-US"
    case spanish = "es"
    case spanishLatinAmerica = "es-419"
    case finnish = "fi"
    case french = "fr"
    case frenchCanada = "fr-CA"
    case gujarati = "gu"
    case hebrew = "he"
    case hindi = "hi"
    case croatian = "hr"
    case hungarian = "hu"
    case indonesian = "id"
    case italian = "it"
    case japanese = "ja"
    case kazakh = "kk"
    case kannada = "kn"
    case korean = "ko"
    case lithuanian = "lt"
    case marathi = "mr"
    case malay = "ms"
    case norwegian = "nb"
    case dutch = "nl"
    case odia = "or"
    case punjabi = "pa"
    case portuguese = "pt"
    case portugueseBrazil = "pt-BR"
    case romanian = "ro"
    case russian = "ru"
    case slovak = "sk"
    case slovenian = "sl"
    case swedish = "sv"
    case tamil = "ta"
    case telugu = "te"
    case thai = "th"
    case turkish = "tr"
    case ukrainian = "uk"
    case urdu = "ur"
    case vietnamese = "vi"
    case chineseSimplified = "zh-Hans"
    case chineseTraditional = "zh-Hant"
    case chineseHK = "zh-HK"
    
    var id: String { rawValue }
    
    var locale: Locale {
        Locale(identifier: rawValue)
    }
    
    var localizedName: LocalizedStringKey {
        switch self {
        case .arabic:
            return "arabic"
        case .bulgarian:
            return "bulgarian"
        case .bengali:
            return "bengali"
        case .catalan:
            return "catalan"
        case .czech:
            return "czech"
        case .danish:
            return "danish"
        case .german:
            return "german"
        case .greek:
            return "greek"
        case .english:
            return "english"
        case .englishAU:
            return "englishAU"
        case .englishGB:
            return "englishGB"
        case .englishIN:
            return "englishIN"
        case .englishUS:
            return "englishUS"
        case .spanish:
            return "spanish"
        case .spanishLatinAmerica:
            return "spanishLatinAmerica"
        case .finnish:
            return "finnish"
        case .french:
            return "french"
        case .frenchCanada:
            return "frenchCanada"
        case .gujarati:
            return "gujarati"
        case .hebrew:
            return "hebrew"
        case .hindi:
            return "hindi"
        case .croatian:
            return "croatian"
        case .hungarian:
            return "hungarian"
        case .indonesian:
            return "indonesian"
        case .italian:
            return "italian"
        case .japanese:
            return "japanese"
        case .kazakh:
            return "kazakh"
        case .kannada:
            return "kannada"
        case .korean:
            return "korean"
        case .lithuanian:
            return "lithuanian"
        case .marathi:
            return "marathi"
        case .malay:
            return "malay"
        case .norwegian:
            return "norwegian"
        case .dutch:
            return "dutch"
        case .odia:
            return "odia"
        case .punjabi:
            return "punjabi"
        case .portuguese:
            return "portuguese"
        case .portugueseBrazil:
            return "portugueseBrazil"
        case .romanian:
            return "romanian"
        case .russian:
            return "russian"
        case .slovak:
            return "slovak"
        case .slovenian:
            return "slovenian"
        case .swedish:
            return "swedish"
        case .tamil:
            return "tamil"
        case .telugu:
            return "telugu"
        case .thai:
            return "thai"
        case .turkish:
            return "turkish"
        case .ukrainian:
            return "ukrainian"
        case .urdu:
            return "urdu"
        case .vietnamese:
            return "vietnamese"
        case .chineseSimplified:
            return "chineseSimplified"
        case .chineseTraditional:
            return "chineseTraditional"
        case .chineseHK:
            return "chineseHK"
        }
    }
}
