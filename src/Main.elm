import Time exposing (Time,second)
import Html exposing (Html)
import Svg exposing (Svg)
import Svg.Attributes exposing(x, y, width, height)
import Set exposing (Set)
import SetExtensions
import Cardinal exposing (Coordinate,Bounds)
import Conway
import Random


-- Model
type alias Model =
    { alive : Set Coordinate
    , bounds : Bounds
    }


init : (Model, Cmd Msg)
init =
  let
      bounds = { x = 0, y = 0, width = 10, height = 10 }
      widthCoordinateGenerator = Random.int bounds.x <| bounds.width - 1
      heightCoordinateGenerator = Random.int bounds.y <| bounds.height - 1
      locationGenerator = Random.pair widthCoordinateGenerator heightCoordinateGenerator
      listGenerator = Random.list (bounds.width * bounds.height // 2) locationGenerator
  in
    ({alive = Set.empty
    , bounds = bounds
    }, Random.generate Genesis listGenerator)


-- Messages
type Msg
    = Tick Time
    | Genesis (List(Coordinate))


drawRect : Bounds -> Int -> Int -> Coordinate -> Svg Msg
drawRect bounds svgWidth svgHeight coord =
    let
        (xPos, yPos) = coord
        w = svgWidth // bounds.width
        h = svgHeight // bounds.height
    in
        Svg.rect
            [ x <| toString <| xPos * w
            , y <| toString <| yPos * h
            , width <| toString <| w
            , height <| toString <| h
            ]
            []

-- View
view : Model -> Html Msg
view { alive, bounds } =
    let
        pxWidth = 800
        pxHeight = 800
    in
        Svg.svg
            [ width <| toString pxWidth
            , height <| toString pxHeight
            ]
            (alive |> Set.toList |> List.map (drawRect bounds pxWidth pxHeight))


-- Update
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Tick _ -> (tick model)
        Genesis points ->
          ( { model | alive = Set.fromList points }
          , Cmd.none)


tick : Model -> (Model, Cmd Msg)
tick { alive, bounds } =
    let
        isBoundedFn = Cardinal.withinBound bounds
        getNeighborCount = \coord -> Cardinal.findNeighbors coord
            |> Set.intersect alive
            |> Set.size

        stillAlive = Set.filter (getNeighborCount >> Conway.processAlive) alive

        deadNeighbors = alive
            |> SetExtensions.unionMap Cardinal.findNeighbors
            |> Set.filter isBoundedFn
            |> (flip Set.diff) alive
        newlyAlive = Set.filter (getNeighborCount >> Conway.processDead) deadNeighbors
    in
        ({ alive = Set.union newlyAlive stillAlive, bounds = bounds }, Cmd.none)


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
