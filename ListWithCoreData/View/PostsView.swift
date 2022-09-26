//
//  PostsView.swift
//  ListWithCoreData
//
//  Created by Bilal Durnagöl on 23.09.2022.
//

import SwiftUI

enum ViewState {
    case loading
    case locale
    case finish
}

struct PostsView: View {
    
    // MARK: - Properties
    
    @StateObject var viewModel = PostViewModel()
    
    // MARK: - Body
    
    var body: some View {
        ScrollViewReader {scrollView in
            List {
                ForEach(viewModel.posts) { post in
                    // Header(profile image, username, ...)
                    // PostImage
                    // ActionBar(like comment send save)
                    // Post details (username, description)
                    VStack(alignment: .leading) {
                        headerView(path: post.thumbnailUrl, username: String(format: USERNAME, post.id))
                        postImage(withPath: post.url)
                        actionBar()
                        postDetails(userName: String(format: USERNAME, post.id), title: post.title)
                    }
                }
            }
            .modifier(SkeletonViewModifier(isLoading: viewModel.isLoading))
            .listRowSeparator(.hidden)
            .onAppear {
                UITableView.appearance().backgroundColor = UIColor.clear
                
            }
        }
    }
}

// MARK: - Preview

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}

extension PostsView {
    
    // MARK: - Header View
    @ViewBuilder
    func headerView(path: String, username: String) -> some View {
        HStack {
            BiloImage(withPath: path)
                .resizable()
                .scaledToFill()
                .clipped()
                .clipShape(Circle())
                .frame(width: 40, height: 40)
            
            Text(username)
                .font(.callout)
                .fontWeight(.semibold)
            
            Spacer()
            
            Image(systemName: "ellipsis")
        }
        .padding(.horizontal, 4)
        .padding(.bottom, 4)
    }
    
    // MARK: - Post Image
    
    @ViewBuilder
    func postImage(withPath path: String) -> some View {
        BiloImage(withPath: path)
            .resizable()
            .antialiased(true)
            .aspectRatio(1, contentMode: .fill)
            .clipped()
            .cornerRadius(8.0)
    }
    
    // MARK: - Action Bar
    
    @ViewBuilder
    func actionBar() -> some View {
        HStack(spacing: 8.0) {
            
            Image(systemName: "heart")
                .resizable()
                .fixedSize()
            
            Image(systemName: "message")
                .resizable()
                .fixedSize()
            Image(systemName: "paperplane")
                .resizable()
                .fixedSize()
            
            Spacer()
            
            Image(systemName: "square.and.arrow.up")
                .resizable()
                .fixedSize()
        }
        .padding(.horizontal, 4)
        .padding(.bottom, 4)
    }
    
    // MARK: - Post Details
    
    @ViewBuilder
    func postDetails(userName: String, title: String) -> some View {
        HStack(alignment: .top,spacing: 8) {
            Text(userName)
                .font(.callout)
                .fontWeight(.semibold)
            
            Text(title)
                .font(.footnote)
        }
    }
}


struct SkeletonViewModifier: ViewModifier {
    var isLoading: Bool
    func body(content: Content) -> some View {
        if isLoading {
            content
                .redacted(reason: .placeholder)
            
        } else {
            
            content
            
        }
        
    }
}
