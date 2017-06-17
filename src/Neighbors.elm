module Neighbors exposing (..)


import Matrix exposing (Matrix, Location)


type alias Neighbors a = List a


getNeighbors : Location -> Matrix a -> List a
getNeighbors loc matrix =
    let
        transformer = flip Matrix.get <| matrix
        (row, column) = loc
        neighborLocations = 
            [ (row + 1, column + 1)
            , (row + 1, column)
            , (row + 1, column - 1)
            , (row, column + 1)
            , (row, column - 1)
            , (row - 1, column + 1)
            , (row - 1, column)
            , (row - 1, column - 1)]
    in
        List.filterMap transformer neighborLocations


neighborMap : (Neighbors a -> a -> b) -> Matrix a -> Matrix b
neighborMap fn matrix =
    let
        neighborsOf = flip getNeighbors <| matrix

        transformer = \loc cell -> fn (neighborsOf loc) cell
    in
        Matrix.mapWithLocation transformer matrix
