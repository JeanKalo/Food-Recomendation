//
//  FoodCardView.swift
//  Food Recommendation
//
//  Created by Sioma on 18/02/22.
//

import SwiftUI

struct FoodCardView : View {
    
    @ObservedObject var foodItem : Food
    
    @Binding var isUserFavorite : Bool
    
    var body: some View{
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                //MARK: nombre
                Text(foodItem.name.capitalized)
                    .lineLimit(2)
                    .font(.system(size: 18))
                //MARK: descripción
                Text(foodItem.description)
                    .lineLimit(2)
                    .font(.system(size: 12))
                    .foregroundColor(.black.opacity(0.9))
                Spacer()
                HStack {
                    //MARK: likes
                    Text(foodItem.numberOfLikes.description)
                        .lineLimit(1)
                        .font(.system(size: 12,weight: .bold))
                        .foregroundColor(.pink)
                    //MARK: boton de me gusta
                    Image(systemName:isUserFavorite ? "heart.fill":  "heart")
                        .foregroundColor(.pink)
                        .scaleEffect(isUserFavorite ? 1.5 : 1.0)
                        .opacity(isUserFavorite ? 1.0 : 0.5)
                }
            }
           
            Spacer(minLength: 150)
        }
        .padding()
        .frame(width: FoodModelData.GetScreenSize() - 40, height: 110)
        .background(foodItem.cardColor)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .gray.opacity(0.5), radius: 7, x: 2, y: 8)
        .onTapGesture(count: 2){
            if foodItem.isUserFavorite {
                withAnimation(Animation.default) {
                    isUserFavorite = false
                }
            }else{
                withAnimation(Animation.default) {
                    isUserFavorite = true
                }
            }
        }
        .overlay(
            //MARK: imagen
            foodItem.image
                .resizable()
                .aspectRatio( contentMode: .fill)
                .frame(width: 120, height: 150)
                .padding(0)
            ,alignment: .bottomTrailing

        )
    }
    
    
}

struct FoodCardView_Previews: PreviewProvider {
    static var previews: some View {
        FoodCardView(
            foodItem: Food(
                id:100,
                name: "Burger",
                image_name: "burger",
                description: "1 Flame grilled"
            ), isUserFavorite: .constant(true)
        )
    }
}
