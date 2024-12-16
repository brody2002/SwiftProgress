//
//  ContentView.swift
//  NetworkRequestTest
//
//  Created by Brody on 12/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var githubUser: GitHubUser?
    var body: some View {
        ZStack{
            VStack {
                AsyncImage(url: URL(string: githubUser?.image ?? ""), scale: 1.0) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(
                            Capsule()
                        )
                        .frame(
                            width :200,
                            height :200
                        )
                } placeholder: {
                    Capsule()
                        .frame(
                            width: 200,
                            height: 200
                        )
                }
                Spacer()
                    .frame(height: UIScreen.main.bounds.height * 0.05)
                Text("Name: \(githubUser?.name ?? "n/a")")
                Spacer()
                    .frame(height: UIScreen.main.bounds.height * 0.05)
                Text("Bio")
                    .multilineTextAlignment(.center)
                Text("\(githubUser?.bio ?? "empty bio")")
                
                HStack{
                    Text("Followers: \(githubUser?.followers ?? 0)")
                    Text("Following: \(githubUser?.following ?? 0)")
                    Text("# Public Repos: \(githubUser?.publicRepos ?? 0)")
                }
                
        
                Spacer()
                Button(action:{
                    
                    Task{
                        do {
                            githubUser = try await aquireData()
                        }
                        catch GitHubError.decoder{
                            print("decoding error")
                        } catch GitHubError.other {
                            print("couldn't get a response")
                        } catch GitHubError.response404 {
                            print("error code 404")
                        } catch GitHubError.response500 {
                            print("error code 500")
                        } catch{
                            print("default error")
                        }
                    }
                },
                    label:{
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.green)
                        Text("Load Info")
                            .foregroundStyle(.white)
                            .bold()
                            
                    }
                    
                    }
                )
            
                
            }
            .padding()
        }
    }
    
}

#Preview {
    ContentView()
}


struct GitHubUser: Codable {
    var name: String
    var bio: String
    var publicRepos: Int
    var followers: Int
    var following: Int
    var image: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case bio
        case publicRepos = "public_repos"
        case followers
        case following
        case image = "avatar_url"
    }
}


/*
 var request = URLRequest(url: URL(string: "https://api.github.com/users/brody2002")!)
 request.httpMethod = "GET"

 let (data, response) = try await URLSession.shared.data(for: request)

 
 */

func aquireData() async throws -> GitHubUser {
    let link = "https://api.github.com/users/brody2002"
    guard let url = URL(string: link) else { throw GitHubError.url }
    
    let (data,  response)  = try await URLSession.shared.data(from: url)
    
    guard let response = response as? HTTPURLResponse else {
        throw GitHubError.other
    }

    switch response.statusCode {
    case 200:
        break // Status is OK, proceed normally
    case 404:
        throw GitHubError.response404
    case 500:
        throw GitHubError.response500
    default:
        throw GitHubError.other
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(GitHubUser.self, from: data)
    }
    catch {
        throw GitHubError.decoder
    }
}

enum GitHubError: Error {
    case url
    case response404
    case response500
    case other
    case decoder
}

