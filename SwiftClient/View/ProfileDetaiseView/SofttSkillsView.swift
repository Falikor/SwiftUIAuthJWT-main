//
//  SofttSkillsView.swift
//  SwiftClient
//
//  Created by 19494115 on 05.05.2022.
//

import Foundation
import SwiftUI

struct SofttSkillsView: View {
    @StateObject var exampleVM: ExampleOfProgressViewModels
    @StateObject var postViewModel = ProgressViewModels()
    @State var skillsSoft = [AllSkill.COMMUNICATIONS, AllSkill.CRITICAL_THINKING, AllSkill.PROJECT_MANAGEMENT]
    @State var tagsTap: [AllSkill]
    
    var body: some View {
        Text("Soft-skills")
        HStack {
            ForEach(skillsSoft, id: \.self) { tagChose in
                Button(action: {
                    if tagsTap.contains(tagChose) {
                        guard let index = tagsTap.firstIndex(of: tagChose) else { return }
                        tagsTap.remove(at: index)
                        
                    } else {
                        tagsTap.append(tagChose)
                    }
                }) {
                    if tagsTap.contains(tagChose) {
                        Text(tagChose.rawValue)
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                            .padding(4)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.blue)
                            )
                    } else {
                        Text(tagChose.rawValue)
                            .foregroundColor(.blue)
                            .font(.system(size: 14))
                            .padding(4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 0.5)
                            )
                    }
                }
            }
        }
        Spacer()
        Button(action: {
            postViewModel.tagsTap = tagsTap
            postViewModel.postAccount()
            
        }) {
                Text("Сохранить")
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .foregroundColor(.white)
        .background(Color.blue)
        .cornerRadius(20)
        .padding(.horizontal, 20)
        
    }
}

