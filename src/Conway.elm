module Conway exposing (Cell(..), apply)


import Cell exposing (Cell)


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
    if neighborCount < 2 || neighborCount > 3 then
        Dead
    else
        Alive
