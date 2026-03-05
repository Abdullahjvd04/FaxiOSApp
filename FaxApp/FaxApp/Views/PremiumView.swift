//
//  PremiumView.swift
//  FaxApp
//
//  Created by Ios Dev on 23/02/2026.
//
//



import SwiftUI

struct PremiumView: View {
    
    @EnvironmentObject private var navVM: NavigateViewModel
    @State private var selectedId: UUID? = nil

    let priceButtons: [Pricing] = [
        Pricing(title: "Weekly Access",
                price: "$2.99",
                bottomText: "Just $2.12 per week",
                bottomImg: .prodown),
        
        Pricing(title: "Yearly Access",
                price: "$2.99",
                bottomText: "Just $2.12 per week",
                bottomImg: .prodown),
        
        Pricing(title: "Monthly Access",
                price: "$2.99",
                bottomText: "Just $2.12 per week",
                bottomImg: .prodown)
    ]
    
    let leftFeatures: [LocalizedStringKey] = [
        "Send unlimited faxes",
        "Editing Tools"
    ]

    let rightFeatures: [LocalizedStringKey] = [
        "Complete history",
        "Mark as Favorite"
    ]
    
    var body: some View {
        
        ZStack{
            
                Image(.proBack)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            VStack(spacing: 0){
                    Text("Go Premium")
                        .font(AppFont.semiBold.size(42))
                        .foregroundColor(.blackClr)
                    Text("No Commitment .CANCEL ANYTIME")
                        .font(AppFont.regular.size(16))
                        .foregroundColor(.noCommitClr)
                HStack(spacing: 15) {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(leftFeatures.indices, id: \.self) { index in
                            Features(title: leftFeatures[index])
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(rightFeatures.indices, id: \.self) { index in
                            Features(title: rightFeatures[index])
                        }
                    }
                }
                .padding(.top)
                
                
                VStack(spacing: 10){
                    ForEach(priceButtons) { button in
                        proButton(
                            button: button,
                            isSelected: selectedId == button.id
                        )
                        .onTapGesture {
                            selectedId = button.id
                        }
                    }
                }
                .padding(.top)
                .padding(.horizontal)
                
                
                Button(action:{
                    navVM.showProView = false

                }){
                    HStack{
                        Text("Get 3  Days free access")
                            .font(AppFont.medium.size(22))
                            .foregroundColor(.black)
                    }
                    .padding()
                    
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.proBtnClr))
                    .padding()
                    
                }
                VStack(spacing: 8){
                    Text("Payment secured by apple")
                        .font(AppFont.regular.size(15))
                        .foregroundColor(.grayClr)
                    
                    HStack{
                        Button(action:{
                            
                        }){
                            Text("Terms of Use")
                                .font(AppFont.regular.size(10))
                                .foregroundColor(.grayClr)
                            
                        }
                        Rectangle()
                            .frame(width: 1,height: 15)
                            .padding(.horizontal)
                            .foregroundColor(.blackClr)
                        Button(action:{
                            
                        }){
                            Text("Privacy Policy")
                                .font(AppFont.regular.size(10))
                                .foregroundColor(.grayClr)
                            
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
            }
            .onAppear {
                if selectedId == nil {
                    selectedId = priceButtons.indices.contains(1) ? priceButtons[1].id : priceButtons.first?.id
                }
            }
            .padding(.top,190)
            VStack{
                HStack{
                    Button(action:{
                        navVM.showProView = false

                    }){
                        
                        Image(systemName: "xmark")
                                   .font(.system(size: 18, weight: .semibold))
                                   .foregroundColor(.black)
                    }
                    Spacer()
                    Button(action:{
                        
                    }){
                        HStack{
                            Text("Restore & Purchase")
                                .font(AppFont.regular.size(10))
                                .foregroundColor(.black)
                        }
                        .padding(.vertical,10)
                        .padding(.horizontal)
                        .background(RoundedRectangle(cornerRadius: 38).fill(.white))
                        .overlay(
                            RoundedRectangle(cornerRadius: 38)
                                .stroke()
                                .fill(Color(.black))
                        )
                    }
                }
                .padding(.top)
            }
            .padding(.horizontal)
            .padding(.top)
            .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
            
        }
    }
}


struct Pricing : Identifiable{
    let  id = UUID()
    let  title: LocalizedStringKey
    let  price: LocalizedStringKey
    let  bottomText: LocalizedStringKey
    let  bottomImg: ImageResource
    
    
}

struct proButton: View {
    let button: Pricing
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: -5){
            HStack{
                Text(button.title)
                    .font(AppFont.medium.size(20))
                Spacer()
                Text(button.price)
                    .font(AppFont.regular.size(25))
            }
            .padding(.vertical,10)
            .padding(.horizontal)
            .foregroundColor(.blackClr)
            .background(
                RoundedRectangle(cornerRadius: 38)
                    .fill(isSelected ? Color.proBtnClr : Color.whiteClr)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 38)
                    .stroke()
                    .fill(isSelected ? Color.whiteClr : Color.blackClr)
            )
            
            .overlay(
                RoundedRectangle(cornerRadius: 38)
                    .stroke()
                    .fill(isSelected ? Color.whiteClr : Color.blackClr)
            )
            
            ZStack{
                Image(button.bottomImg)
                    .foregroundColor(isSelected ? Color.blueClr : Color.noProSelect)
                Text(button.bottomText)
                    .font(AppFont.regular.size(14))
                    .foregroundColor(isSelected ? Color.whiteClr : Color.blackClr)
                
            }
        }
    }
}

struct Features: View {
    var title: LocalizedStringKey
    
    var body: some View {
        HStack(spacing: 8) {
            Circle()
                .fill(Color.blackClr)
                .frame(width: 10, height: 10)
            
            Text( title)
                .font(AppFont.regular.size(17))
                .foregroundColor(.blackClr)
        }
    }
}
#Preview {
    PremiumView()
}

