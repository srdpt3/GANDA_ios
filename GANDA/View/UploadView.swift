//
//  UploadView.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/2/22.
//

import SwiftUI

struct UploadView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var uploadComplete : Bool
    @Binding var showUploadView : Bool
    
    
    
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
    
    let haptics = UINotificationFeedbackGenerator()
    @Namespace var animation
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false, content: {
            
            VStack{
                
                VStack(alignment: .leading, spacing: 20){
                    
                    HStack(spacing: 15){
                        
                        ZStack{
                            
                            if self.images[0].count == 0{
                                
                                LottieView(filename: "plus").frame(width: 100, height: 100)
                                    .clipShape(Circle()).padding(.bottom, 10).padding(.top, 10).zIndex(1)
                                    .onTapGesture {
                                        self.index = 0
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
                                    .frame(width: 150, height: 150)
                                    .cornerRadius(10)
                                
                            }
                        }

                        VStack{
                            //                            Text("나의 스타일 올리기").font(.system(size: 16, weight: .bold)).foregroundColor(.black)
                            //                            //                            Spacer()
                            CustomTextField(image: "questionmark.circle", title: "내스타일 질문", value: $questionText, animation: animation)
                                .padding(.top,5)
                            
                        }
                    }.padding(.leading)
                    
                    
                    
                    
                    
                }
                .padding(10)
                .cornerRadius(20)
                .background(
                    Color("BG")
                        .ignoresSafeArea()
                )
                
                
                CustomTextField(image: "filemenu.and.selection", title: "보기 1", value: $selectionText[0], animation: animation)
                CustomTextField(image: "filemenu.and.selection", title: "보기 2", value: $selectionText[1], animation: animation)
                CustomTextField(image: "filemenu.and.selection", title: "보기 3", value: $selectionText[2], animation: animation)
                
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
                            .frame(height: 150)
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
                                
                                // Use same Font size and limit here used in TagView....
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
                            .disabled((tags.count < 5 || questionText == "" || self.images[0].count == 0))
                            .opacity((tags.count < 5 || questionText == "" || self.images[0].count == 0) ? 0.6 : 1)
 
                            
                        }

                    }

                }
                .padding(10)
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(ERROR), message: Text(TAG_LIMIT_ERROR), dismissButton: .destructive(Text("Ok")))
                }.sheet(isPresented: self.$imagePicker) {
                    ImagePicker(showImagePicker: self.$imagePicker, pickedImage: self.$image, imageData: self.$images[self.index])
                }
                
                
                
            }
        })
            .background(
                Color("BG")
                    .ignoresSafeArea()
            )
            .environment(\.colorScheme, .light)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .overlay(
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
                            
                        }
                    }.padding(.trailing)
                    Spacer()
                }
                
                
            )
   
        
    }
    
    
    func uploadPicture(){
        
        uploadViewModel.uploadVote(title: self.questionText, selectionText: self.selectionText, tags: self.tags, imageData: self.images[0])
        self.uploadComplete = true
        self.presentationMode.wrappedValue.dismiss()
        //        if(!self.noVotePic && self.vote.imageLocation != ""){
        //            historyViewModel.persistPastVoteData(vote: self.vote)
        //            //            if(!historyViewModel.isLoading){
        //            //            }
        //
        //        }
        self.uploadComplete = true
        //        self.showAlert.toggle()
        //         self.activeAlert = ActiveAlert.second
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

struct UploadView_Previews: PreviewProvider {
    @State static var isShowing = false
    @State static var showUploadView = false
    
    static var previews: some View {
        UploadView(uploadComplete: $isShowing, showUploadView: $showUploadView)
    }
}



public struct CustomStyle : TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(7)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color.black, lineWidth: 1)
            )
    }
    
}
