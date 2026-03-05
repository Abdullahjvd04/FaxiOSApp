//
//  ContentView.swift
//  FaxApp
//
//  Created by Ios Dev on 23/02/2026.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var navVM: NavigateViewModel
    @EnvironmentObject private var languageManager: LanguageManager
    
    @State private var showLanguageSheet = false
    
    private var settingsItems: [SettingItem] {
        [
            SettingItem(
                icon: .moreApps,
                title: "More Apps",
                trailing: nil,
                action: nil
            ),
            
            SettingItem(
                icon: .language,
                title: "Language",
                trailing: languageManager.currentLanguage.localizedName,
                action: {
                    showLanguageSheet = true
                }
            ),
            
            SettingItem(
                icon: .privacy,
                title: "Privacy Plicy",
                trailing: nil,
                action: nil
            ),
            
            SettingItem(
                icon: .terms,
                title: "Terms and Conditions",
                trailing: nil,
                action: nil
            ),
            
            SettingItem(
                icon: .rateUs,
                title: "Rate US",
                trailing: nil,
                action: nil
            ),
            
            SettingItem(
                icon: .help,
                title: "Help",
                trailing: nil,
                action: nil
            )
        ]
    }
    
    var body: some View {
        VStack {
            
            HStack {
                VStack(spacing: 0) {
                    Text("Settings")
                        .font(AppFont.bold.size(40))
                        .foregroundColor(.darkClr)
                    
                    Image(.settingLines)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            VStack(spacing: 0) {
                ForEach(settingsItems) { item in
                    SettingRow(item: item)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(.offWhiteClr)
            )
            Button(action: {
                navVM.showProView = true
            }) {
                ZStack {
                    Image(.settingPro)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            
                            Text("Fax Pro")
                                .font(AppFont.semiBold.size(20))
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Enjoy benefits")
                                    .font(AppFont.regular.size(16))
                                
                                Text("of the App")
                                    .font(AppFont.regular.size(16))
                            }
                        }
                        .padding(.leading, 9)
                        
                        Spacer()
                        
                        ZStack {
                            Image(.upgradeSetting)
                            
                            Text("Upgrade")
                                .font(AppFont.semiBold.size(20))
                                .padding(.leading, 25)
                                .padding(.bottom, 10)
                        }
                    }
                    .padding()
                }
                .foregroundColor(.whiteClr)
                .padding(.top)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            RoundedRectangle(cornerRadius: 0)
                .fill(.whiteClr)
        )
        .sheet(isPresented: $showLanguageSheet) {
            LanguageSelectionView()
                .environmentObject(languageManager)
        }
    }
}



struct SettingRow: View {
    
    let item: SettingItem
    
    var body: some View {
        Button(action: {
            item.action?()
        }) {
            HStack {
                Image(item.icon)
                
                Text(item.title)
                    .foregroundColor(.darkClr)
                    .font(AppFont.regular.size(19))
                
                Spacer()
                
                if let trailing = item.trailing {
                    Text(trailing)
                        .foregroundColor(.darkClr)
                        .font(AppFont.regular.size(16))
                }
                
                Image(.next)
            }
            .padding(.horizontal, 5)
            .padding(.vertical)
        }
        .buttonStyle(.plain)
    }
}



struct SettingItem: Identifiable {
    let id = UUID()
    let icon: ImageResource
    let title: LocalizedStringKey
    let trailing: LocalizedStringKey?
    let action: (() -> Void)?
}


struct LanguageSelectionView: View {
    
    @EnvironmentObject private var languageManager: LanguageManager
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Select Language")
                .font(AppFont.semiBold.size(22))
                .foregroundColor(.darkClr)
                .padding(.top)
            
            ScrollView(showsIndicators: false){
            VStack(spacing: 12) {
                ForEach(SupportedLanguage.allCases) { language in
                    
                    Button {
                        languageManager.setLanguage(language)
                        dismiss()
                    } label: {
                        HStack {
                            Text(language.localizedName)
                                .foregroundColor(.darkClr)
                                .font(AppFont.regular.size(20))
                            
                            Spacer()
                            
                            if languageManager.currentLanguage == language {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.darkClr)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.offWhiteClr)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(
                                    languageManager.currentLanguage == language
                                    ? Color.darkClr
                                    : Color.gray.opacity(0.3),
                                    lineWidth: 1
                                )
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
        }
            Spacer()
        }
        .padding()
        .background(.whiteClr)
    }
}

#Preview {
    SettingsView()
}

