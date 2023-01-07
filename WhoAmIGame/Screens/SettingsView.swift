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
    @AppStorage("username") var username: String = "lol xd"
    @AppStorage("gameTime") var timeSelect: Int = 30
    @AppStorage("showLinks")var link = true
    @AppStorage("localLanguage")var selectedLanguage:String = "EN"
   // @State var link = UserDefaults.standard.bool(forKey: "showLinks")
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20){
// MARK: - General info
                    GroupBox {
                        Divider().padding(.vertical, 4)
                        HStack(alignment: .center, spacing: 10){
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .cornerRadius(9)
                            Text("Who am I? app was inspired by Heads up! game. It was developed as a example of building apps with Swift and SwiftUI for the Final Maturita Thesis.")
                                .font(.footnote)
                        }
                    } label: {
                        SettingsLabelView(label: "Who am I?", image: "info.circle")
                    }
                    .padding(.top, 10)
// MARK: - Settings
                    GroupBox {
                        Divider().padding(.vertical, 4)
                        Toggle("Username screen", isOn: $isFirstTime)
                            .foregroundColor(.gray)
                        Divider().padding(.vertical, 4)
                        Toggle("Show links in results", isOn: $link)
                            .foregroundColor(.gray)
                        Divider().padding(.vertical, 4)
                        HStack{
                            Text("Link language")
                                .foregroundColor(.gray)
                            Spacer()
                            Picker("Link language", selection: $selectedLanguage) {
                                ForEach(languages, id: \.self) { lang in
                                        Text(lang.uppercased())
                                    }
                            }
                        }
                        SettingsRowView(label: "Username", description: username)
                        VStack{
                            Divider().padding(.vertical, 4)
                            Text("Game duration")
                                .foregroundColor(.gray)
                            Picker("", selection: $timeSelect) {
                                        ForEach(times, id: \.self) { time in
                                            Text("\(time) sec")
                                        }
                                    }.pickerStyle(SegmentedPickerStyle())
                                        .padding(5)
                            
                        }
                    } label: {
                        SettingsLabelView(label: "Settings", image: "gear")
                    }
// MARK: - Application info
                    GroupBox(content: {
                        SettingsRowView(label: "Developer", description: "Richie")
                        SettingsRowView(label: "Compatibility", description: "iOS 16")
                        SettingsRowView(label: "Twitter", linkLabel: "@risasimonik", linkDestination: "twitter.com/risasimonik")
                        SettingsRowView(label: "SwiftUI", description: "6.0")
                        SettingsRowView(label: "Version",description: "0.9")
                    }, label: {
                        SettingsLabelView(label: "Application", image: "apps.iphone")
                    })
                }
            }
            .navigationTitle("Settings")
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
