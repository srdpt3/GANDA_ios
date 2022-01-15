//
//  SelectionView.swift
//  Demo-blackcow
//
//  Created by Dustin yang on 1/4/22.
//

import SwiftUI

struct SelectionView: View {
    var maxLimit: Int
    @State var tags:  [Tag] = []
    
    var fontSize: CGFloat = 16
    
    // Adding Geometry Effect to Tag...
    @Namespace var animation
    
    var body: some View {
       
        VStack(alignment: .leading, spacing: 15) {
           
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    // Displaying Tags.....
                    
                    ForEach(getRows(),id: \.self){rows in
                        
                        HStack(spacing: 6){
                            
                            ForEach(rows){row in
                                
                                RowView(tag: row)
                            }
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 80,alignment: .leading)
                .padding(.vertical)
                .padding(.bottom,20)
            }
            .frame(maxWidth: .infinity)
            .background(
            
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(Color("white"),lineWidth: 3)
            )
            // Animation...
//            .animation(.easeInOut, value: tags)
        }
        // Since onChange will perfrom little late...
//        .onChange(of: tags) { newValue in
//        }
    }
    
    @ViewBuilder
    func RowView(tag: Tag)->some View{
        
        Text(tag.text)
        // applying same font size..
        // else size will vary..
            .font(.system(size: fontSize))
        // adding capsule..
            .padding(.horizontal,14)
            .padding(.vertical,8)
            .background(
            
                Capsule()
                    .fill(Color("Blue"))
            )
            .foregroundColor(Color.white)
            .lineLimit(1)
        // Delete...
            .contentShape(Capsule())
            .matchedGeometryEffect(id: tag.id, in: animation)
    }
    
    func getIndex(tag: Tag)->Int{
        
        let index = tags.firstIndex { currentTag in
            return tag.id == currentTag.id
        } ?? 0
        
        return index
    }
    
    // Basic Logic..
    // Splitting the array when it exceeds the screen size....
    func getRows()->[[Tag]]{
        
        var rows: [[Tag]] = []
        var currentRow: [Tag] = []
        
        // caluclating text width...
        var totalWidth: CGFloat = 0
        
        // For safety extra 10....
        let screenWidth: CGFloat = UIScreen.main.bounds.width - 90
        
        tags.forEach { tag in
            
            // updating total width...
            
            // adding the capsule size into total width with spacing..
            // 14 + 14 + 6 + 6
            // extra 6 for safety...
            totalWidth += (tag.size + 40)
            
            // checking if totalwidth is greater than size...
            if totalWidth > screenWidth{
                
                // adding row in rows...
                // clearing the data...
                // checking for long string...
                totalWidth = (!currentRow.isEmpty || rows.isEmpty ? (tag.size + 40) : 0)
                
                rows.append(currentRow)
                currentRow.removeAll()
                currentRow.append(tag)
                
            }else{
                currentRow.append(tag)
            }
        }
        
        // Safe check...
        // if having any value storing it in rows...
        if !currentRow.isEmpty{
            rows.append(currentRow)
            currentRow.removeAll()
        }
        
        return rows
    }
    
    
}

//struct SelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectionView()
//    }
//}
