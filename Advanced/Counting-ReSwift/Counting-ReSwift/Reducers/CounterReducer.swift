//
//  CounterReducer.swift
//  Counting-ReSwift
//
//  Created by SHIN YOON AH on 2021/12/02.
//

import ReSwift

func counterReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()
    
    switch action {
    case is CounterActionIncrease:
        state.counter += 1
    case is CounterActionDecrease:
        state.counter -= 1
    default:
        break
    }
    
    return state
}
