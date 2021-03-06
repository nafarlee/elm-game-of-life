module Cardinal exposing (..)


import Set exposing (Set)


type alias Coordinate = (Int, Int)


type alias Bounds =
    { x : Int
    , y : Int
    , width : Int
    , height : Int
    }


findNeighbors : Coordinate -> Set(Coordinate)
findNeighbors coord =
    let
        (x, y) = coord
    in
        Set.fromList
          [ ( x + 1, y + 1 )
          , ( x + 1, y )
          , ( x + 1, y - 1 )
          , ( x, y + 1 )
          , ( x, y - 1 )
          , ( x - 1, y + 1 )
          , ( x - 1, y )
          , ( x - 1, y - 1 )
          ]


withinBound : Bounds -> Coordinate -> Bool
withinBound bounds coord =
    let
        (x, y) = coord
    in
        x >= bounds.x &&
        x < bounds.x + bounds.width &&
        y >= bounds.y &&
        y < bounds.y + bounds.height
