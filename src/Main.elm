import Time exposing (Time,second)
import Html exposing (Html,text)
import Set exposing (Set)


-- Model
type alias Coordinate = (Int, Int)


type alias Model =
    { alive : Set Coordinate
    , width : Int
    , height : Int}


init : (Model, Cmd Msg)
init =
    ({alive = Set.empty
    , width = 10
    , height = 10}, Cmd.none)


-- Messages
type Msg
    = Tick Time


-- View
view : Model -> Html Msg
view matrix = text "banana"


-- Update
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Tick _ -> (model, Cmd.none)


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
