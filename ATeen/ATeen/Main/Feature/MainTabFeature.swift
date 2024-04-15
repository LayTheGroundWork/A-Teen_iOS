//
//  MainTabFeature.swift
//  ATeen
//
//  Created by 최동호 on 4/11/24.
//

import ComposableArchitecture

import Foundation

enum TabState: String {
    case Home = "Home"
    case Board = "Board"
    case Messenger = "Messenger"
    case Profile = "Profile"
}

@Reducer
struct MainTabFeature {
    @ObservableState
    struct State: Equatable {
        @Presents var destination: Destination.State?

        var isFetchedData: Bool = true
        var tabState: TabState = .Home

    }
    
    enum Action {
        case changeTab(TabState)
        case destination(PresentationAction<Destination.Action>)
        case openLoginView
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .changeTab(tabState):
                state.tabState = tabState
                return .none
            case .destination:
                return .none
            case .openLoginView:
                state.destination = .openLoginView(
                    LoginFeature.State(
                        user: User(name: "",
                                   phoneNumber: "",
                                   birth: "",
                                   schoolName: "",
                                   age: 0,
                                   gender: "")
                    )
                )
                return .none

            }
        }
        .ifLet(\.$destination, action: \.destination)

    }
}

extension MainTabFeature {
    @Reducer(state: .equatable)
    enum Destination {
        case openLoginView(LoginFeature)
    }
}
