/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
import SwiftUI

struct CardView: View {
    var model: CardModel
    @State var showContent = false
    @State var deleting = false
    @State var showAlert = false
  
    var body: some View {
        ZStack {
            backView.opacity(showContent ? 1 : 0)
            frontView.opacity(showContent ? 0 : 1)
        }
        .frame(width: 250, height: 200)
        .background(
            ZStack {
                showContent
                    ? Color(.gray)
                    : Color(.blue).opacity(0.5)
        
                Image(systemName: "cloud.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(Color(.white).opacity(0.4))
                    .offset(y: 20)
            }
        )
        .cornerRadius(20)
        .shadow(
            color: Color(.blue).opacity(0.9),
            radius: 5, x: 10, y: 10
        )
        .scaleEffect(deleting ? 1.2 : 1)
        .rotation3DEffect(.degrees(showContent ? 180.0 : 0.0), axis: (x: 0, y: -1, z: 0))
        // .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
        .onTapGesture {
            withAnimation {
                showContent.toggle()
            }
        }
        .onLongPressGesture {
            withAnimation {
                showAlert = true
                deleting = true
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Remove Card"),
                message: Text("Are you sure you want to remove this card?"),
                primaryButton: .destructive(Text("Remove")) {
                    withAnimation {
                        model.remove()
                    }
                },
                secondaryButton: .cancel {
                    withAnimation {
                        deleting = false
                    }
                }
            )
        }
    }
  
    var frontView: some View {
        VStack(alignment: .center) {
            Spacer()
            Text(model.card.question)
                .foregroundColor(.white)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(20.0)
            Spacer()
            if !model.card.successful {
                Text("You answered this one incorrectly before")
                    .foregroundColor(.white)
                    .font(.system(size: 11.0))
                    .fontWeight(.bold)
                    .padding()
            }
        }
    }
  
    var backView: some View {
        VStack {
            Spacer()
      
            Text(model.card.answer)
                .foregroundColor(.black)
                .font(.system(size: 20))
                .padding(20.0)
                .multilineTextAlignment(.center)
            // .animation(.easeInOut)
      
            Spacer()

            HStack(spacing: 40) {
                Button {
                    markSuccess(true)
                }
          label: {
                    Image(systemName: "hand.thumbsup.fill")
                        .padding()
                        .background(Color.green)
                        .font(.title)
                        .foregroundColor(.white)
                        //.clipShape(Circle())
                }
                Button {
                    markSuccess(false)
                }
          label: {
                    Image(systemName: "hand.thumbsdown.fill")
                        .padding()
                        .background(Color.red)
                        .font(.title)
                        .foregroundColor(.white)
                        //.clipShape(Circle())
                }
            }
            .padding()
        }
        .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
    }
  
    private func markSuccess(_ successful: Bool) {
        var updatedCard = model.card
        updatedCard.successful = successful
        model.update(card: updatedCard)
        showContent.toggle()
    }
  
    func update(card: Card) {
        model.update(card: card)
        showContent.toggle()
    }
}

// struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        let card = testData[0]
//        let model = CardView.Model(card: card, repository: CardRepository())
//        return CardView(model: model)
//    }
// }
