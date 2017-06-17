module SetExtensions exposing (unionMap)


import Set exposing (Set)


unionMap : (comparable -> Set comparable) -> Set comparable -> Set comparable
unionMap mapping source =
        Set.foldl (reducer mapping) Set.empty source


reducer : (comparable -> Set comparable) -> comparable -> Set comparable -> Set comparable
reducer mapping current accumulatedSet =
    Set.union accumulatedSet <| mapping current
