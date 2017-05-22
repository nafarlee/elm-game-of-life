module Conway exposing (..)


processAlive : Int -> Bool
processAlive neighborCount =
    if neighborCount == 2 || neighborCount == 3 then
        True
    else
        False


processDead : Int -> Bool
processDead neighborCount =
    if neighborCount == 3 then
        True
    else
        False
