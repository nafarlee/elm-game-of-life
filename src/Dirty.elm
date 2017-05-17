module Dirty exposing (find)


import Set exposing (Set)

import Cardinal exposing (Coordinate,Bounds)


find : Set (Coordinate) -> Bounds -> Set (Coordinate)
find alive bounds =


reducer : Coordinate -> Set(Coordinate) -> Set(Coordinate)
reducer current accumulated =
  let
      (x, y) = current
      new = Set.fromList
        [ (x + 1, y + 1)
        , (x + 1, y)
        , (x + 1, y - 1)
        , (x, y + 1)
        , (x, y - 1)
        , (x - 1, y + 1)
        , (x - 1, y)
        , (x - 1, y - 1)
        ]
  in
     Set.union accumulated new


predicate : 
