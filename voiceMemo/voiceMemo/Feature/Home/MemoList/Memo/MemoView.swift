//
//  MemoView.swift
//  voiceMemo
//

import SwiftUI

struct MemoView: View {
    
    @EnvironmentObject private var pathModel : PathModel
    @EnvironmentObject private var memoListViewModel : MemoListViewModel
    @StateObject  var memoViewModel : MemoViewModel
    @State var isCreateMode : Bool = true
    
    var body: some View {
        ZStack{
            VStack{
                CustomNavigationBar(
                    leftBtnAction: {
                        pathModel.paths.removeLast()
                    },
                    rightBtnAction: {
                        if isCreateMode {
                            memoListViewModel.addMemo(memoViewModel.memo)
                        } else {
                            memoListViewModel.updateMemo(memoViewModel.memo)
                        }
                        pathModel.paths.removeLast()
                    },
                    rightBtnType: isCreateMode ? .create : .complete
                )
                MemoTitleInputView(
                    memoViewModel: memoViewModel,
                    isCreateMode: $isCreateMode
                )
                .padding(.top,20)
                MemoContentInputView(memoViewModel: memoViewModel)
                    .padding(.top,20)
                
                if !isCreateMode {
                    RemoveMemoBtnView(memoViewModel: memoViewModel)
                        .padding(.trailing,20)
                        .padding(.top,50)
                }
            }
            
        }
    }
}

private struct MemoTitleInputView : View {
    @ObservedObject private var memoViewModel : MemoViewModel
    @FocusState private var isTitleFildFocused: Bool
    @Binding private var isCreateMode : Bool
    
    init(
        memoViewModel: MemoViewModel,
        isCreateMode: Binding<Bool>) {
            self.memoViewModel = memoViewModel
            self._isCreateMode = isCreateMode
        }
    var body: some View {
        TextField("제목을 입력하시요",
                  text: $memoViewModel.memo.title
        )
        .font(.system(size: 30))
        .padding(.horizontal,20)
        .focused($isTitleFildFocused)
        .onAppear{
            if isCreateMode{
                isTitleFildFocused = true
            }
        }
    }
}

private struct MemoContentInputView : View {
    @ObservedObject private var memoViewModel : MemoViewModel
    init(
        memoViewModel: MemoViewModel) {
            self.memoViewModel = memoViewModel
        }
    var body: some View {
        ZStack(alignment: .topLeading){
            TextEditor(text: $memoViewModel.memo.content)
                .font(.system(size: 20))
            
            if memoViewModel.memo.content.isEmpty {
                Text("메모를 입력하세요")
                    .font(.system(size: 16))
                    .foregroundColor(.customGray1)
                    .allowsHitTesting(false) // 터치 인식 안되게 false로 설정해줌
                    .padding(.top,10)
                    .padding(.leading,5)
            }
        }
        .padding(.horizontal,20)
    }
}

private struct RemoveMemoBtnView : View {
    @EnvironmentObject private var pathModel : PathModel
    @EnvironmentObject private var memoListVIewModel : MemoListViewModel
    @ObservedObject private var memoViewModel : MemoViewModel
    
    init(  memoViewModel: MemoViewModel) {
        
        self.memoViewModel = memoViewModel
    }
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Spacer()
                Button(
                    action: {
                        memoListVIewModel.removeMemo(memoViewModel.memo)
                        pathModel.paths.removeLast()
                    },
                    label: {
                    Image("trash")
                            .resizable()
                            .frame(width: 40,height: 40)
                })
            }
            
        }
    }
}

struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        MemoView(
            memoViewModel: .init(
                memo: .init(title: "", content: "", date: Date()))
        )
        
        
    }
}
