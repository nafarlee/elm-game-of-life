import Time exposing (Time,second)
import Dict exposing (Dict)

import Conway exposing (Cell(Alive,Dead))


-- Model
type alias Coordinate = (Int, Int)
type alias Board = Dict Coordinate Cell


type alias Model =
    { board: Board
    }


init : (Model, Cmd Msg)
init =


-- Messages
type Msg
    = Tick Time
    | Genesis (Board)


-- View
view : Model -> Html Msg
view { board } =


-- Update
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Genesis board -> (board, Cmd.none)
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
