import SwiftUI

struct ContentView: View {
    
    @State private var gameOverFlag = false
    
    @State private var H    : Double = 0
    @State private var RA   : Double = 0
    @State private var B    : Double = 0
    @State private var LA   : Double = 0
    @State private var RL   : Double = 0
    @State private var LL   : Double = 0
    
    @State private var livesLeft: Int = 7
    
    @State private var K1 = [
        "Q","W", "E", "R", "T", "Y", "U", "I","O", "P"
    ]
    @State private var K2 = [
        "A","S", "D", "F", "G", "H", "J", "K","L"
    ]
    @State private var K3 = [
        "Z","X", "C", "V", "B", "N", "M"
    ]
    
    @State private var Selection = ""
    
    @State private var Answer: [String] =
    [
        "A", "d", "v", "a", "n", "c", "e", "d", " ",
        "P", "l", "a", "c", "e", "m", "e", "n", "t",
        ":", " ", "C", "o", "m", "p", "u", "t", "e",
        "r", " ", "S", "c", "i", "e", "n", "c", "e",
        " ", "P", "r", "i", "c", "i", "p", "l", "e",
        "s"
    ]
    @State private var AnswerLC: [String] =
    [
        "a", "d", "v", "a", "n", "c", "e", "d", " ",
        "p", "l", "a", "c", "e", "m", "e", "n", "t",
        ":", " ", "c", "o", "m", "p", "u", "t", "e",
        "r", " ", "s", "c", "i", "e", "n", "c", "e",
        " ", "p", "r", "i", "c", "i", "p", "l", "e",
        "s"
    ]
    @State private var OnScreen: [String] = [
        "_", "_", "_", "_", "_", "_", "_", "_", " ",
        "_", "_", "_", "_", "_", "_", "_", "_", "_",
        ":", " ", "_", "_", "_", "_", "_", "_", "_",
        "_", " ", "_", "_", "_", "_", "_", "_", "_",
        " ", "_", "_", "_", "_", "_", "_", "_", "_",
        "_", "_"
    ]
    @State private var OnScreenSetotare = [
        "_", "_", "_", "_", "_", "_", "_", "_", " ",
        "_", "_", "_", "_", "_", "_", "_", "_", "_",
        ":", " ", "_", "_", "_", "_", "_", "_", "_",
        "_", " ", "_", "_", "_", "_", "_", "_", "_",
        " ", "_", "_", "_", "_", "_", "_", "_", "_",
        "_", "_"
    ].joined(separator: " ")
    
    var body: some View {
        VStack(spacing:0) {
            VStack(spacing: 0){
                Image("Body")
                    .resizable()
                    .frame(width: 50, height: 250)
                Image("Head")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .opacity(H)
                HStack{
                    Image("Left")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .opacity(LA)
                        .overlay(
                            Image("Body")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .opacity(B)
                                .overlay(
                                    Image("Right")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .opacity(RA)
                                )
                        )
                }
                HStack(spacing : 0){
                    Image("Left")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .opacity(LL)
                        .overlay(
                            Image("Right")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .opacity(RL)
                        )
                }
            }
            .onChange(of: livesLeft) { newValue in
                if newValue == 6 {
                    H = 1
                } else if newValue == 5 {
                    B = 1
                } else if newValue == 4{
                    RA = 1
                } else if newValue == 3 {
                    LA = 1
                } else if newValue == 2 {
                    RL = 1
                } else if newValue == 1 {
                    LL = 1
                }
            }
            
            Text(OnScreenSetotare)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding(.bottom)
            
            HStack{
                ForEach(Array(K1.enumerated()), id: \.element) { index, letter in
                    keyboardButton(letter: letter, CViewStrct: self, gameOverFlag: $gameOverFlag)
                }
            }
            HStack{
                ForEach(Array(K2.enumerated()), id: \.element) { index, letter in
                    keyboardButton(letter: letter, CViewStrct: self, gameOverFlag: $gameOverFlag)
                }
            }
            HStack{
                ForEach(Array(K3.enumerated()), id: \.element) { index, letter in
                    keyboardButton(letter: letter, CViewStrct: self, gameOverFlag: $gameOverFlag)
                }
            }
            if gameOverFlag{
                Text("GAME OVER")
                    .font(.system(size : 150))
                    .foregroundStyle(.red)
            }
                
        }
        .padding()
    }
    
    public func LetterSubmit(inp: String) {
        var updatedOnScreen = OnScreen
        var mutableAnswer = Answer
        var decrementLives = true
        
        for (index, answerLetter) in mutableAnswer.enumerated() {
            if answerLetter.lowercased() == inp.lowercased() {
                updatedOnScreen[index] = Answer[index]
                mutableAnswer[index] = "_"
                decrementLives = false
            }
        }
        
        OnScreen = updatedOnScreen
        OnScreenSetotare = updatedOnScreen.joined(separator: " ")
        Answer = mutableAnswer
        
        if decrementLives {
            livesLeft -= 1
        }
        
        if livesLeft <= 0 {
            gameOverFlag = true
            
        }
    }
}

struct keyboardButton: View {
    @State private var isOff = false
    var letter : String
    let CViewStrct : ContentView
    @Binding var gameOverFlag: Bool
    
    var body: some View {
        Button{
            CViewStrct.LetterSubmit(inp: letter)
            isOff.toggle()
        } label:{
            Text(letter)
                .font(.system(size:40))
        }
        .buttonStyle(.bordered)
        .padding(.bottom)
        .disabled(isOff || gameOverFlag)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
