//
//  ContentView.swift
//  ToDoList_SwiftUI
//
//  Created by Aliya on 18.07.2023.
//

import SwiftUI
var tasks = taskList
var showDoneOnly = false

struct statusLine: View {
    var body: some View {
        HStack {
            Text("Выполнено — \(tasks.filter { $0.isDone == true }.count)")
                .foregroundColor(Colors.captureColor(color: Colors.labelTertiary))
            Spacer()
            Button("Показать") { }
                .bold()

        }
        .font(Constants.setFont(font: Constants.font15))
        .padding(EdgeInsets(top: 0,
                            leading: 32,
                            bottom: 0,
                            trailing: 32))
    }
}

struct cellView: View {
    var task: TodoItem
    var body: some View {
        HStack {
            Image(uiImage: Images.choosePropImage(item: task))
            VStack(alignment: .leading, spacing: 0) {
                Text(task.text).lineLimit(3)
                if let deadline = task.deadline {
                    HStack (spacing: 2) {
                        Images.getImage(image: Images.calendar)
                        Text(deadline.dateStringShortRU)
                            .foregroundColor(Colors.captureColor(color: Colors.labelTertiary))
                    }
                }
            }
        }
        .swipeActions(edge: .leading) {
            Button {
                print("isDone changed")
            } label: {
                Images.getImage(image: Images.complete)
            }
            .tint(Colors.captureColor(color: Colors.colorGreen))
        }
        .swipeActions(edge: .trailing) {
            Button {
                print("item deleted")
            } label: {
                Images.getImage(image: Images.delete)
            }
            .tint(Colors.captureColor(color: Colors.colorRed))
        }
    }

}

struct ContentView: View {
    var body: some View {
        NavigationStack {

            VStack {
                statusLine()
                ZStack(alignment: .bottom) {
                    List(tasks) { task in
                        cellView(task: task)
                    }

                    .listStyle(.inset)
                    .cornerRadius(16)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    .ignoresSafeArea()
                    Button {
                        print("plus tapped")
                    } label: {
                        ZStack {
                            Images.getImage(image: Images.plusFill)
                            Images.getImage(image: Images.plus)
                                .resizable()
                                .frame(width: 44, height: 44)
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Colors.captureColor(color: Colors.backPrimary))
            .navigationTitle(Text("Мои дела"))
        }
    }

}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
