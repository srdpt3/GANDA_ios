//
//  UploadPhotoView.swift
//  GANDA
//
//  Created by Dustin yang on 1/18/22.
//

import SwiftUI

struct UploadPhotoView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var uploadComplete : Bool
    @Binding var showUploadView : Bool
    @State var showLoading : Bool = false
    
    @EnvironmentObject var observer : Observer
    
    
    @ObservedObject var uploadViewModel = UploadViewModel()
    
    @State var text: String = ""
    @State var questionText: String = ""
    
    @State var image: Image = Image("logo")
    
    @State var images : [Data] = [Data()]
    @State var imagePicker = false
    // Tags..
    @State var tags: [Tag] = []
    //    @State var selectionText: [String] = []
    //    @State var selectionText: [String] = [String](repeating: 0, count: 3)
    @State var selectionText = Array(repeating: "", count: 3)
    @State var showAlert: Bool = false
    @State var index = 0
    
    
    @State var email = ""
    @State var password = ""
    @State var name = ""
    @State var number = ""
    @State var category : String = ""
    
    let haptics = UINotificationFeedbackGenerator()
    @Namespace var animation
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false){
                
                VStack(alignment: .leading, spacing: 15){
                    HStack(spacing: 15){
                        Spacer()
                        if self.images[0].count == 0{
                            
                            LottieView(filename: "upload").frame(width: 100, height: 100)
                                .clipShape(Circle()).padding(.bottom, 10).padding(.top, 10).zIndex(1)
                                .onTapGesture {
                                    self.haptics.notificationOccurred(.success)
                                    self.imagePicker.toggle()
                                }
                                .opacity(self.images[0].count > 0 ? 0 : 1)
            
                        }
                        else{
                            
                            Image(uiImage: UIImage(data: self.images[0])!)
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .cornerRadius(10)
                        }
                        DropDown(category: $category).padding(.top)
                        Spacer()
                        
                    }
                   
                }  .overlay(
                    VStack{
                        
                        HStack{
                            Spacer()
                            Button {
                                withAnimation(.spring()){
                                    
                                    showUploadView.toggle()
                                }
                                
                            } label: {
                                Spacer()
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.black.opacity(0.5))
                                    .clipShape(Circle())
                                    .opacity( showLoading ? 0 : 1 )
                                
                                
                            }
                        }.padding(.trailing)
              
                    }.frame(width: 50, height: 50).offset(x:150)
                    
                    
                )
                CustomTextField(image: "questionmark.circle", title: "내스타일 질문", value: $questionText, animation: animation)
                CustomTextField(image: "filemenu.and.selection", title: "보기 1", value: $selectionText[0], animation: animation)
                CustomTextField(image: "filemenu.and.selection", title: "보기 2", value: $selectionText[1], animation: animation)
                CustomTextField(image: "filemenu.and.selection", title: "보기 3(선택사항)", value: $selectionText[2], animation: animation)
                
                VStack{
                    VStack(spacing: 10){
                        TextField(PLEASE_ADD_TAG, text: $text)
                            .font(Font.custom(FONT, size: 14))
                            .foregroundColor(.black)
                            .padding(.vertical,10)
                            .padding(.horizontal)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .strokeBorder(Color(.gray),lineWidth: 1)
                            )
                        // Setting only Textfield as Dark..
                        //                .environment(\.colorScheme, .dark)
                            .padding(.vertical,5)
                        TagView(maxLimit: 100, tags: $tags,fontSize: 15)
                        // Default Height...
                            .frame(height: 100)
                        // Add Button..
                        HStack{
                            
                            Button {
                                
                                // Use same Font size and limit here used in TagView....
                                addTag(tags: tags, text: text, fontSize: 16, maxLimit: 150) { alert, tag in
                                    
                                    if alert{
                                        // Showing alert...
                                        showAlert.toggle()
                                    }
                                    else{
                                        // adding Tag...
                                        
                                        tags.append(tag)
                                        text = ""
                                    }
                                }
                                
                            } label: {
                                Text(ADD_TAG)
                                    .font(Font.custom(FONT, size: 16))
                                    .foregroundColor(Color.white)
                                    .padding(.vertical,12)
                                    .padding(.horizontal,45)
                                    .background(GRADIENT_COLORS[4])
                                    .cornerRadius(20)
                            }
                            // Disabling Button...
                            .disabled(text == "")
                            .opacity(text == "" ? 0.6 : 1)
                            //                        Spacer()
                            Button {
                                hideKeyboard()
                                
                                selectionText[0] = selectionText[0].trimmingCharacters(in: .whitespacesAndNewlines)
                                selectionText[1] = selectionText[1].trimmingCharacters(in: .whitespacesAndNewlines)
                                selectionText[2] = selectionText[2].trimmingCharacters(in: .whitespacesAndNewlines)
                                
                                // Use same Font size and limit here used in TagView....
                                showLoading.toggle()
                                self.uploadPicture()
                                self.haptics.notificationOccurred(.success)
                                
                            } label: {
                                
                                
                                
                                Text(UPLOAD_BUTTON)
                                    .font(Font.custom(FONT, size: 16))
                                    .foregroundColor(Color.white)
                                    .padding(.vertical,12)
                                    .padding(.horizontal,45)
                                    .background(GRADIENT_COLORS[4])
                                    .cornerRadius(20)
                            }
                            // Disabling Button...
                            .disabled((questionText == "" || self.images[0].count == 0) || showLoading ||
                                      selectionText[0].trimmingCharacters(in: .whitespacesAndNewlines) == "" || selectionText[1].trimmingCharacters(in: .whitespacesAndNewlines) == "")
                            .opacity((questionText == "" || self.images[0].count == 0 || showLoading ||
                                      selectionText[0].trimmingCharacters(in: .whitespacesAndNewlines) == "" ||  selectionText[1].trimmingCharacters(in: .whitespacesAndNewlines) == "") ? 0.6 : 1 )
                        }

                        
                        
                    }
                    
                } .padding(.horizontal, 12)
                    .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text(ERROR), message: Text(TAG_LIMIT_ERROR), dismissButton: .destructive(Text("Ok")))
                    }.sheet(isPresented: self.$imagePicker) {
                        ImagePicker(showImagePicker: self.$imagePicker, pickedImage: self.$image, imageData: self.$images[self.index])
                    }
                
                
                
            }.blur(radius : self.showLoading ? 15 : 0)
            
            if showLoading{
                LoadingView()
            }
            
            
        }.background(
            Color("BG")
                .ignoresSafeArea()
        ).environment(\.colorScheme, .light).navigationBarHidden(true).navigationBarBackButtonHidden(true)

            .alert(isPresented: $uploadComplete) {
                
                return  Alert(
                    title: Text(COMPLETE),
                    message: Text(UPLOAD_COMPLETE),
                    dismissButton: .default(Text(CONFIRM).font(.custom(FONT, size: 17)).foregroundColor(APP_THEME_COLOR), action: {
                        //                    showUploadView = false
                        showUploadView.toggle()
                        
                        
                    }))
                
                
            }
    }
    
    func uploadPicture(){
        self.observer.resetVoteData()
        
        uploadViewModel.uploadVote(title: self.questionText, selectionText: self.selectionText, tags: self.tags, imageData: self.images[0] , category: self.category) { result in
            withAnimation {

                self.uploadComplete.toggle()
                self.showLoading.toggle()
                self.observer.getMyCards()
                
            }
            
            
            
            
            
        }
    }
    
    func hide_keyboard()
    {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func verifyImages()->Bool{
        
        var status = true
        
        for i in self.images{
            
            if i.count == 0{
                
                status = false
            }
        }
        
        return status
    }
}
//
//struct UploadPhotoView_Previews: PreviewProvider {
//    static var previews: some View {
//        UploadPhotoView()
//    }
//}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif


struct DropDown: View {
    @Binding var category : String
    @State var expand = false
    var body: some View{
        VStack(alignment: .leading, spacing: 18, content: {
            
            HStack{
                Text(category == "" ? "카테고리": category).foregroundColor(.white).font(.custom(FONT, size: 15))
                Image(systemName: expand ?  "chevron.up" :  "chevron.down").resizable().frame(width: 10, height: 10).foregroundColor(.white)
            }.onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                self.expand.toggle()
            }
            if(expand){
                
                Button(action: {
                    self.category = "데일리룩"
                    self.expand.toggle()
                }){
                    Text("데일리룩").font(.custom(FONT, size: 16))
                }.foregroundColor(.white)
                
                Button(action: {
                    self.category = "데이팅룩"
                    self.expand.toggle()
                }){
                    Text("데이팅룩").font(.custom(FONT, size: 16))
                }.foregroundColor(.white)
                Button(action: {
                    self.category = "핫아이템"
                    
                    self.expand.toggle()
                }){
                    Text("핫아이템").font(.custom(FONT, size: 16))
                }.foregroundColor(.white)
                
                Button(action: {
                    self.category = "악세사리"
                    
                    self.expand.toggle()
                }){
                    Text("악세사리").font(.custom(FONT, size: 16))
                    
                }.foregroundColor(.white)
                
                Button(action: {
                    self.category = "신발"
                    self.expand.toggle()
                }){
                    Text("신발").font(.custom(FONT, size: 16))
                }.foregroundColor(.white)
                
                
                
                Button(action: {
                    self.category = "기타"
                    
                    self.expand.toggle()
                }){
                    Text("기타").font(.custom(FONT, size: 16))
                }.foregroundColor(.white)
                
            }
            
            
            
            
        })
            .padding()
            .background(GRADIENT_COLORS[4])
        
            //            .background(LinearGradient(gradient: .init(colors:   [Color("Color5"),Color("Color11")]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(20)
            .animation(Animation.spring(response: 0.6, dampingFraction: 1.0, blendDuration: 1.0))    }
    
}
