//
//  RulseView.swift
//  SwiftClient
//
//  Created by 19494115 on 12.04.2022.
//

import SwiftUI

struct RulseView: View {
    
    var body: some View {
        VStack(alignment: .leading) {
                Text("За что можно получить ВИШенки")
                    .foregroundColor(.blue)
                    .font(.system(size: 18))
                Text("""
                1. Участие в мероприятиях
                2. Публикация статей
                3. Помощь кафедре
                """)
                    .font(.system(size: 16))
                Text("Как потратить ВИШенки")
                    .foregroundColor(.blue)
                    .font(.system(size: 18))
                Text("Вы можете купить за ВИШенки товары\n в фирменном магазине университета")
                    .font(.system(size: 16))
            }
        .padding(.horizontal, 30)
    }
}

struct RulseView_Previews: PreviewProvider {
    static var previews: some View {
        AfichaView()
    }
}
