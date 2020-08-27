module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Player =
    { id : Int
    , name : String
    , points : Int
    }


type alias Play =
    { id : Int, playerId : Int, name : String, points : Int }


type alias Model =
    { players : List Player
    , name : String
    , playerId : Maybe Int
    , plays : List Play
    }


initModel : Model
initModel =
    { players = [], name = "", playerId = Nothing, plays = [] }


type Msg
    = Edit Player
    | Score Player Int
    | Input String
    | Save
    | Cancel
    | DeletePlay Play


update : Msg -> Model -> Model
update msg model =
    case msg of
        Input name ->
            { model | name = name }

        _ ->
            model


playerForm : Model -> Html Msg
playerForm model =
    Html.form [ onSubmit Save ]
        [ input [ type_ "text", placeholder "Add/Edit Player...", onInput Input, value model.name ] []
        , button [ type_ "Submit" ] [ text "Save" ]
        , button [ type_ "Button", onClick Cancel ] [ text "Cancel" ]
        ]


view : Model -> Html Msg
view model =
    div [ class "scoreboard" ]
        [ h1 [] [ text "Score Keeper" ]
        , playerForm model
        ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initModel, update = update, view = view }
