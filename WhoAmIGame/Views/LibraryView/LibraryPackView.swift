import SwiftUI
///View that represents the pack in the library, same as in ``ChoosingPackView``, simplified ``ListItemView``.
struct LibraryPackView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var pack : NormalQuestionPack
    @State var showDetails = false
    @State private var change = false
    @EnvironmentObject var saved:SavedPacks
    @EnvironmentObject var realm:RealmGuess
    
    var width: CGFloat {
          if UIDevice.current.userInterfaceIdiom == .phone {
              return UIScreen.main.bounds.width * 0.44
          } else {
              return UIScreen.main.bounds.width * 0.2
          }
      }
    
    var body: some View {
        ZStack{
            Image(pack.imageStr)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
            RoundedRectangle(cornerRadius: 23)
                .foregroundColor(.white)
            Blur(style: colorScheme == .dark ? .prominent : .dark)
            Image(pack.imageStr)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .mask(LinearGradient(gradient: Gradient(colors: [Color.white, Color.white.opacity(0)]), startPoint: .top, endPoint: .bottom))
            VStack{
                HStack{
                    Button {
                    if(!saved.isSaved(pack: pack)){
                            saved.addPack(realm: realm, pack: pack)
                        }
                        change.toggle()
                    } label: {
                        if #available(iOS 17.0, *) {
                            Image(systemName: saved.isSaved(pack: pack) ? "checkmark.diamond" : "square.and.arrow.down")
                                .contentTransition(.symbolEffect(.replace))
                                .font(.system(size: 25))
                                .foregroundColor(pack.isFavourite ? .red : .white)
                                .if(saved.isSaved(pack: pack)) { view in
                                    view.symbolEffect(.bounce.up, value: change)
                                }
                        } else {
                            Image(systemName: saved.isSaved(pack: pack) ? "checkmark.diamond" : "square.and.arrow.down")
                                .font(.system(size: 25))
                                .foregroundColor(pack.isFavourite ? .red : .white)
                        }
                    }

                    Spacer()
                }
                Spacer()
                Text(pack.name)
                    .font(.title3)
                    .fontWeight(.semibold)
                HStack {
                   // Text(String(pack.questions.count))
                    Text(pack.author)
                }
            }
            .foregroundColor(.white)
            .padding(20)
        }
        .onTapGesture {
            showDetails.toggle()
        }
       // .frame(width: width, height: width)
        .cornerRadius(23)
        .defersSystemGestures(on: .bottom)
        .sheet(isPresented: $showDetails) {
            LibraryPackOVerView(pack: $pack)
        }
    }
}

