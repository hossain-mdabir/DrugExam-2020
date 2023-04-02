//
//  LogInView.swift
//  DrugExam 2020
//
//  Created by Md Abir Hossain on 29/3/23.
//

import SwiftUI

struct LogInView: View {
    // MARK: - PROPERTIES
    @State private var userid = ""
    @State private var password = ""
    @State private var goDashboard: Bool = false
    @State private var isNeedUpdate: Bool = false
    // Open's Link
    @Environment(\.openURL) var openURL
    
    // Toast
    @State private var isToast: Bool = false
    @State private var toastMsg = ""
    
    var body: some View {
        ZStack {
            VStack {
                Image("drug-120")
                Spacer()
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(Color("NavBar"))
                    
                    FloatingTextField(title: "username", text: $userid)
                }
                
                Divider()
                
                HStack {
                    Image(systemName: "lock.fill")
                        .foregroundColor(Color("NavBar"))
                    
                    FloatingSecureTextField(title: "password", text: $password, isSecure: true)
                }
                
                Divider()
                NavigationLink("", destination: DashboardView(), isActive: $goDashboard)
                
                Button(action: {
                    logIn()
                }, label: {
                    Text("L O G I N")
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color("NavBar"))
                        .cornerRadius(15)
                })
                .padding(.vertical, 50)
                
                Spacer()
            }
            .padding()
        }
        // MARK: - Toast Alert's
        .toastNotification(isNeedToShow: $isToast, msg: $toastMsg)
        .toolbarColorScheme(.light, for: .navigationBar)
        
        // App version update
        .alert("It is recommended to update the app for a better experience.", isPresented: $isNeedUpdate) {
            Button("Update Now") {
                // Go to App Store
                openURL(URL(string: "https://apps.apple.com/us/app/thp-online/id6443422997")!)
                print("Tapped Ok to new UPDATE available") }
        }
    }
    // LogIn Function
    func logIn() {
        var logIn = LogInPost()
        
        logIn.androidVersion = Int(UIDevice.current.systemVersion.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil))
        logIn.appVersionName = "\(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") ?? "")"
        logIn.pkg = "\(Bundle.main.bundleIdentifier ?? "")"
        logIn.userCurrentAppVersion = Int(Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String)
        logIn.userName = userid
        logIn.userPass = password
        logIn.userPhone = "\(UIDevice.current.name)-\(UIDevice.current.systemVersion)"
        
        logInAuth(logIn: logIn) { (response, error) in
            print("response \(response)")
            userData(response: response?.objResponse)
            print("response.userRole \(response?.objResponse?.userRole)")
            print("UserDataUI : \(UserData().readStringData(key: UserData().USER_ROLE))")
            
            if response?.objResponse?.userIsActive == 1 {
                if response?.objResponse?.examFlag == 1 && response?.objResponse?.needUpdate != 1 {
                    goDashboard = true
                } else {
                    if response?.objResponse?.examFlag != 1 {
                        isToast = true
                        toastMsg = "User is not eligible for exam"
                        print("Cannot sit for exam")
                    } else if response?.objResponse?.needUpdate == 1 {
                        self.isNeedUpdate = true
                        print("Need to update DrugExam 2020 App")
                    }
                }
            } else {
                print("User Not Active")
            }
        }
    }
    
    // Save log in response data
    func userData(response: UserDataRes?) {
        UserData().writeAnyData(key: UserData().SYSTEM_USER_ID, value: response?.systemUserid ?? "")
        UserData().writeAnyData(key: UserData().USER_CODE, value: response?.userCode ?? "")
        UserData().writeAnyData(key: UserData().USER_NAME, value: response?.userName ?? "")
        UserData().writeAnyData(key: UserData().USER_PASS, value: response?.userPass ?? "")
        UserData().writeAnyData(key: UserData().PARENT_ID, value: response?.parentId ?? "")
        UserData().writeAnyData(key: UserData().MPO_GROUP, value: response?.mpoGroup ?? "")
        UserData().writeAnyData(key: UserData().USER_IS_ACTIVE, value: response?.userIsActive ?? "")
        UserData().writeAnyData(key: UserData().SERVER_APP_VERSION_CODE, value: response?.serverAppVersionCode ?? "")
        UserData().writeAnyData(key: UserData().EXAM_FLAG, value: response?.examFlag ?? "")
        UserData().writeAnyData(key: UserData().APP_VERSION_NAME, value: response?.appVersionName ?? "")
        UserData().writeAnyData(key: UserData().USER_CURRENT_APP_VERSION, value: response?.userCurrentAppVersion ?? "")
        UserData().writeAnyData(key: UserData().USER_ROLE, value: response?.userRole ?? "")
        UserData().writeAnyData(key: UserData().NEED_UPDATE, value: response?.needUpdate ?? "")
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
