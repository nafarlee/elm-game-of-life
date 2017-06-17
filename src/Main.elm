import Time exposing (Time,second)
import Html exposing (Html,table,tr,td)
import Html.Attributes exposing(style,height,width)
import Random

import Matrix exposing (Matrix)

import Conway exposing (Cell(Alive,Dead))
import Neighbors exposing (neighborMap)


-- Model
type alias Model = Matrix Cell


cell : Bool -> Cell
cell b =
    if b then
        Alive
    else
        Dead


init : (Model, Cmd Msg)
init =
    let
        size = 100
        matrix = Matrix.square size <| always Dead
        matrixGenerator
            = Random.bool
            |> Random.map cell
            |> Random.list size
            |> Random.list size
            |> Random.map Matrix.fromList
    in
        (matrix, Random.generate Genesis matrixGenerator)


-- Messages
type Msg
    = Tick Time
    | Genesis (Matrix Cell)


-- View
view : Model -> Html Msg
view matrix =
    let
        innerMap = \cell ->
            case cell of
                Alive -> td [style [("backgroundColor", "black")]] []
                Dead -> td [style [("backgroundColor", "white")]] []

        outerMap = \row ->
            tr [] <| List.map innerMap row
    in
        table
            [ style
                [ ("table-layout", "fixed")
                , ("height", "800px")
                , ("width", "800px")
                ]
            ] <| List.map outerMap <| Matrix.toList matrix


-- Update
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Genesis matrix -> (matrix, Cmd.none)
        Tick _ -> (neighborMap Conway.apply model, Cmd.none)


-- Subscriptions
subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every second Tick


-- Main
main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
