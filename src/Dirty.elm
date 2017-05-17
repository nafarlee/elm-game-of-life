module Dirty exposing (find)


import Set exposing (Set)

import Cardinal exposing (Coordinate,Bounds)


find : Set (Coordinate) -> Bounds -> Set (Coordinate)
find alive bounds =


reducer : Coordinate -> Set(Coordinate) -> Set(Coordinate)
reducer current accumulated =
     Set.union (Cardinal.findNeighbors current) accumulated
