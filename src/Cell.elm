module Cell exposing (Cell)


import Random exposing (Generator)


type Cell = Alive | Dead


generator : Generator Cell
generator = Random.map Random.bool boolToCell


boolToCell : Bool -> Cell
boolToCell bool =
    case bool of
        True -> Alive
        False -> Dead
