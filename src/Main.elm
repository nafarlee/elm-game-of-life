import Time exposing (Time,second)
import Html exposing (Html,text)
import Set exposing (Set)
import Cardinal exposing (Coordinate,Bound)
import Random


-- Model
type alias Model =
    { alive : Set Coordinate
    , width : Int
    , height : Int}


init : (Model, Cmd Msg)
init =
  let
      width = 10
      widthCoordinateGenerator = Random.int 0 <| width - 1
      height = 10
      heightCoordinateGenerator = Random.int 0 <| height - 1
      locationGenerator = Random.pair widthCoordinateGenerator heightCoordinateGenerator
      listGenerator = Random.list (width * height // 2) locationGenerator
  in
    ({alive = Set.empty
    , width = width
    , height = height}, Random.generate Genesis listGenerator)


-- Messages
type Msg
    = Tick Time
    | Genesis (List(Coordinate))


-- View
view : Model -> Html Msg
view model = text <| toString model


-- Update
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Tick _ -> (model, Cmd.none)
        Genesis points ->
          ( { model | alive = Set.fromList points }
          , Cmd.none)


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
