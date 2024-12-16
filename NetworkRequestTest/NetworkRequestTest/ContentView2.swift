import SwiftUI

struct ContentView2: View {
    @State private var brodyObject: BrodyInfo?
    var body: some View {
        ZStack{
            Color.blue
            VStack {
                Button(action:{
                    Task {
                        do {
                            brodyObject = try await aquireBrodyInfo()
                        }
                        catch BrodyErrors.HTTPURLResponse{
                            print("failed making response var as a httpURLResponse")
                        } catch BrodyErrors.error404 {
                            print("Response status 404")
                        }
                        catch BrodyErrors.error500 {
                            print("Response status 500")
                        }
                        catch BrodyErrors.errorDecoding {
                            print("Error Decoding")
                        }
                        catch BrodyErrors.nonTrackResponseError {
                            print("nonTrackResponseError")
                        }
                        catch {
                            print("uncaught error")
                        }
                        
                        
                    }
                }, label:{
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.orange)
                        Text("Aquire Brody's Info")
                    }
                })
                .frame(width: 200, height: 120)
                
                VStack{
                    Text("Info About Brody")
                        .font(.title.bold())
                        .foregroundStyle(.white)
                    
                }
            }
        }
        
    }
}



struct BrodyInfo: Decodable {
    var name: String
    var number: Int
    var dog: String
    var girlfriend: String
    
    enum CodingKeys: String, CodingKey{
        case name
        case number = "favoriteNumber"
        case dog
        case girlfriend
    }
}

func aquireBrodyInfo() async throws -> BrodyInfo {
    guard let url = URL(string: "http://127.0.0.1:5000") else { throw BrodyErrors.urlInvalid }
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let response = response as? HTTPURLResponse else { throw BrodyErrors.HTTPURLResponse}
    switch response.statusCode {
    case 200:
        break
    case 404:
        throw BrodyErrors.error404
    case 500:
        throw BrodyErrors.error500
    default:
        throw BrodyErrors.nonTrackResponseError
    }
    
    do {
        let decoder = try JSONDecoder().decode(BrodyInfo.self, from: data)
        return decoder
    } catch {
        throw BrodyErrors.errorDecoding
    }
}

enum BrodyErrors: Error {
    case urlInvalid
    case HTTPURLResponse
    case nonTrackResponseError
    case error404
    case error500
    case errorDecoding
}


#Preview {
    ContentView2()
}

