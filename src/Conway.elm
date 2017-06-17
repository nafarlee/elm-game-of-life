module Conway exposing (Cell(..), apply)


import Neighbors exposing (Neighbors)


type Cell = Alive | Dead


apply : Neighbors Cell -> Cell -> Cell
apply neighbors cell =
    let
        aliveNeighbors = List.filter ((==) Alive) neighbors
        neighborCount = List.length aliveNeighbors
    in
        case cell of
            Alive -> ifAlive neighborCount
            Dead -> ifDead neighborCount


ifDead : Int -> Cell
ifDead neighborCount =
    case neighborCount of
        3 -> Alive
        _ -> Dead


ifAlive : Int -> Cell
ifAlive neighborCount =
    if neighborCount <= 1 then Dead
    else if neighborCount <= 3 then Alive
    else Dead
