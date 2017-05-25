module Conway exposing (Cell(..), apply)


type Cell = Alive | Dead


apply : Int -> Cell -> Cell
apply neighborCount cell =
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
