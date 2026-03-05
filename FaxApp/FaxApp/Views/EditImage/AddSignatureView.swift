//
//  AddSignatureView.swift
//  FaxApp
//
//  Created by Ios Dev on 25/02/2026.
//
//


import SwiftUI

struct AddSignatureView: View {
    @EnvironmentObject private var navVM: NavigateViewModel
    
    @State private var lines: [Line] = []
    @State private var currentLine: Line? = nil
    @State private var selectedColor: Color = .black
    private let signatureColors: [Color] = [
        .black, .blue, .red ,.yellow,.orange, .green, .pink
    ]
    
    var body: some View {
        VStack(spacing: 5) {
            ZStack {
                HStack {
                    Button(action: {
                        navVM.showSignatureView = false
                    }) {
                        Image(.exitImg)
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                    
                    Button(action: {
                        saveSignature()
                    }) {
                        HStack {
                            Text("Save")
                                .font(AppFont.medium.size(20))
                                .foregroundColor(.whiteClr)
                        }
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(RoundedRectangle(cornerRadius: 6).fill(.darkClr))
                    }
                    .buttonStyle(.plain)
                }
                .padding()
                .frame(maxWidth: .infinity)
                
                HStack {
                    Text("Add Signature")
                        .font(AppFont.regular.size(24))
                        .foregroundColor(.darkClr)
                }
                .padding()
                .padding(.top, 50)
                .frame(maxWidth: .infinity)
            }
            
            ZStack {
                Color.white
                
                ForEach(lines) { line in
                    SignaturePath(line: line)
                    .stroke(selectedColor, lineWidth: 2)
                }
                
                if let line = currentLine {
                    SignaturePath(line: line)
                    .stroke(selectedColor, lineWidth: 2)
                }
                
                VStack {
                    Spacer()
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .frame(height: 1)
                        .foregroundColor(.darkClr)
                        .padding(.bottom, 10)
                }
            }
            .frame(width: Constants.width * 0.8, height: Constants.height * 0.3)
            .background(RoundedRectangle(cornerRadius: 0).fill(.white))
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        let point = value.location
                        let canvasWidth  = Constants.width * 0.8
                        let canvasHeight = Constants.height * 0.29
                        
                        guard point.x >= 0, point.x <= canvasWidth,
                              point.y >= 0, point.y <= canvasHeight else { return }
                        
                        if value.translation == .zero {
                            currentLine = Line(points: [point])
                        } else {
                            currentLine?.points.append(point)
                        }
                    }
                    .onEnded { _ in
                        if let line = currentLine {
                            lines.append(line)
                            currentLine = nil
                        }
                    }
            )
            HStack(spacing: 15) {
                ForEach(signatureColors, id: \.self) { color in
                    Circle()
                        .fill(color)
                        .frame(width: 30, height: 30)
                        .overlay(
                            Circle()
                                .stroke(selectedColor == color ? Color.whiteClr : Color.clear, lineWidth: 2)
                        )
                        .onTapGesture {
                            selectedColor = color
                        }
                }
            }
            .padding(.vertical, 10)
            
            HStack(spacing: 20) {
                
                Button(action: {
                    lines.removeAll()
                    currentLine = nil
                }) {
                    HStack {
                        Text("Clear")
                            .font(AppFont.medium.size(20))
                            .foregroundColor(.whiteClr)
                    }
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .background(RoundedRectangle(cornerRadius: 6).fill(.lightClr))
                }
                .buttonStyle(.plain)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.vertical)
        .padding(.top,10)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 20).fill(.offWhiteClr))
    }
    

    func saveSignature() {
        guard !lines.isEmpty else {
            navVM.showSignatureView = false
            return
        }
        
        let size = CGSize(width: Constants.width * 0.8, height: Constants.height * 0.2)
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        defer { UIGraphicsEndImageContext() }
        
        UIColor.clear.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        
        let renderer = UIGraphicsImageRenderer(size: size)
        let signatureImage = renderer.image { ctx in
            ctx.cgContext.setStrokeColor(UIColor(selectedColor).cgColor)
            ctx.cgContext.setLineWidth(2)
            ctx.cgContext.setLineCap(.round)
            ctx.cgContext.setLineJoin(.round)
            
            for line in lines {
                guard line.points.count > 1 else { continue }
                ctx.cgContext.beginPath()
                ctx.cgContext.move(to: line.points[0])
                for point in line.points.dropFirst() {
                    ctx.cgContext.addLine(to: point)
                }
                ctx.cgContext.strokePath()
            }
        }
        
        navVM.signatureImage = signatureImage
        navVM.showSignatureView = false
    }
}

struct Line: Identifiable {
    let id = UUID()
    var points: [CGPoint]
}

struct SignaturePath: Shape {
    let line: Line
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        guard line.points.count > 1 else { return path }
        path.move(to: line.points[0])
        for point in line.points.dropFirst() {
            path.addLine(to: point)
        }
        return path
    }
}

#Preview {
    AddSignatureView()
        .environmentObject(NavigateViewModel())
}
