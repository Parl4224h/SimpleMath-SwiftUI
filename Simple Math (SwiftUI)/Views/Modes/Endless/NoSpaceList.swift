//
//  NoSpaceList.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 4/3/22.
//

import SwiftUI

struct NoSpaceList: View {
    
    var body: some View {
        GeometryReader { g in
            NavigationView {
                ScrollView {
                    HStack {
                        Image(systemName: "square.grid.3x3.fill")
                            .font(.title3)
                        Spacer()
                        Text("The Happy Programmer")
                            .font(.title3)
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .font(.title3)
                    }.padding().ignoresSafeArea()
                    
                    VStack {
                        ForEach(data) { post in
                            NavigationLink(destination: NospaceListDestination(post: post)) {
                                HStack{
                                    HStack(alignment: .firstTextBaseline) {
                                        VStack(alignment: .leading) {
                                            Text(post.title)
                                                .font(.largeTitle)
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                            nospaceTags(tags: post.postType)
                                            Spacer()
                                            Divider().frame(height: 0.5).background(Color.black)
                                            HStack {
                                                Text("Post Updated")
                                                    .font(.caption)
                                                    .foregroundColor(.black)
                                                Spacer()
                                                Text(post.date)
                                                    .font(.caption)
                                                    .foregroundColor(.black)
                                            }.padding(.bottom, 20)
                                        }.padding(.top, 30)
                                        
                                        Image(systemName: "arrow.right")
                                            .foregroundColor(.iconGray)
                                            .font(.largeTitle)
                                    }
                                    .padding(.horizontal)
                                }
                                .frame(width: g.size.width, height: g.size.height / 2.5)
                                .background(post.Color)
                            }
                            
                        }
                    }
                }.frame(width: g.size.width, height: g.size.height)
                .navigationBarHidden(true)
            }
        }
    }
}



struct NospaceListDestination: View {
    @Environment(\.presentationMode) var presentationMode
    var post : ListData
    var body: some View {
        VStack {
            GeometryReader { g in
                VStack {
                    ZStack(alignment: .top) {
                        post.Color
                        Image(post.Image)
                            .resizable()
                            .frame(width: g.size.width, height: g.size.height / 2.3)
                            
//                            .overlay(LinearGradient(gradient: Gradient(colors: [post.Color, post.Color.opacity(0.1)]), startPoint: .bottom, endPoint: .top))
                            .overlay(post.Color.opacity(0.5))
                        HStack {
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Image(systemName: "arrow.left")
                                    .font(.title)
                                    .foregroundColor(.black)
                                    .padding(10)
                                    .background(post.Color.opacity(0.1))
                                    .cornerRadius(100)
                            })
                            Spacer()
                            Button(action: {
                                
                            }, label: {
                                Image(systemName: "magnifyingglass")
                                    .font(.title)
                                    .foregroundColor(.black)
                                    .padding(10)
                                    .background(post.Color.opacity(0.1))
                                    .cornerRadius(50)
                            })
                        }
                        .padding(.horizontal)
                                                .padding(.bottom)
                                                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                                            }.frame(height: g.size.height / 2.3)
                                            HStack {
                                                Text("Post Updated")
                                                    .font(.caption)
                                                    .foregroundColor(.black)
                                                Spacer()
                                                Text(post.date)
                                                    .font(.caption)
                                                    .foregroundColor(.black)
                                            }.padding(.horizontal)
                                            .padding(.vertical, 10)
                                            VStack(alignment: .leading,spacing: 30) {
                                                Text(post.title)
                                                    .font(.title)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.black)
                                                Text("One advanced diverted domestic sex repeated bringing you old. Possible procured her trifling laughter thoughts property she met way. Companions shy had solicitude favourable own.").lineSpacing(10)
                                            }.padding()
                                            Spacer()
                                            Button(action: {}) {
                                                HStack {
                                                    Spacer()
                                                    Text("Read More")
                                                        .padding(.trailing)
                                                    Image(systemName: "arrow.right")
                                                        
                                                    Spacer()
                                                }.padding()
                                                .border(Color.black, width: 1)
                                                .padding()
                                                .foregroundColor(.black)
                                            }.padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                                        }
                                    }
                                }
                                .navigationBarHidden(true)
                                .background(post.Color)
                                .ignoresSafeArea(edges: [.top,.bottom])
                            }
                        }

struct NoSpaceList_Previews: PreviewProvider {
    static var previews: some View {
        NoSpaceList()
    }
}
