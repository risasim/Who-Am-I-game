//
//  SettingsView.swift
//  WhoAmIGame
//
//  Created by Richard on 06.12.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isFirstTime") var isFirstTime : Bool = false
    @AppStorage("username") var username: String = "username"
    @AppStorage("gameTime") var timeSelect: Int = 30
    @AppStorage("showLinks")var link = true
    @AppStorage("localLanguage")var selectedLanguage:String = "en"
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20){
// MARK: - General info
                    GroupBox {
                        Divider().padding(.vertical, 4)
                        HStack(alignment: .center, spacing: 10){
                            Image("logo2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .cornerRadius(9)
                            Text("game.Description")
                                .font(.footnote)
                        }
                    } label: {
                        SettingsLabelView(label: "Who am I?", image: "info.circle")
                    }
                    .padding(.top, 10)
// MARK: - Settings
                    GroupBox {
                        Divider().padding(.vertical, 4)
                        //Can delete
                    #if DEBUG
                        Toggle("set.Username", isOn: $isFirstTime)
                            .foregroundColor(.gray)
                        Divider().padding(.vertical, 4)
                        Button {
                            StartingDatabase()
                        } label: {
                            Text("set.AddPacks")
                        }
                    #endif
                        Divider().padding(.vertical, 4)
                        Toggle("set.showLinks", isOn: $link)
                            .foregroundColor(.gray)
                        Divider().padding(.vertical, 4)
                        HStack{
                            Text("set.linkLang")
                                .foregroundColor(.gray)
                            Spacer()
                            Picker("set.linkLang", selection: $selectedLanguage) {
                                ForEach(languages, id: \.self) { lang in
                                    Text(lang.uppercased())
                                        .tag(lang)
                                }
                            }
                        }
                        SettingsRowView(label: "set.username", description: username)
                        VStack{
                            Divider().padding(.vertical, 4)
                            Text("set.gameDur")
                                .foregroundColor(.gray)
                            Picker("", selection: $timeSelect) {
                                        ForEach(times, id: \.self) { time in
                                            Text("\(time) sec")
                                        }
                                    }.pickerStyle(SegmentedPickerStyle())
                                        .padding(5)
                            
                        }
                    } label: {
                        SettingsLabelView(label: "set.set", image: "gear")
                    }
// MARK: - Application info
                    GroupBox(content: {
                        SettingsRowView(label: "set.dev", description: "Richie")
                        SettingsRowView(label: "Buy me a cofee", linkLabel: "Link", linkDestination:"https://www.buymeacoffee.com/richiesimonik")
                        SettingsRowView(label: "set.compat", description: "iOS 16")
                        SettingsRowView(label: "X", linkLabel: "@risasimonik", linkDestination: "twitter.com/risasimonik")
                        SettingsRowView(label: "SwiftUI", description: "6.0")
                        SettingsRowView(label: "set.Ver",description: "1.0")
                    }, label: {
                        SettingsLabelView(label: "set.app", image: "apps.iphone")
                    })
                }
            }
            .navigationTitle("set.set")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }

        }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView()
        }
    }
}
