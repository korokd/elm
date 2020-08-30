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
    { id : Int
    , playerId : Int
    , points : Int
    }


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

        Save ->
            if String.isEmpty model.name then
                model

            else
                let
                    modelWithPlayerChanges =
                        save model
                in
                { modelWithPlayerChanges | name = initModel.name, playerId = initModel.playerId }

        Cancel ->
            { model | name = initModel.name, playerId = Nothing }

        _ ->
            model


save : Model -> Model
save model =
    case model.playerId of
        Just id ->
            edit model id

        Nothing ->
            add model


add : Model -> Model
add model =
    let
        player =
            Player (List.length model.players) model.name 0
    in
    { model | players = player :: model.players }


edit : Model -> Int -> Model
edit model id =
    let
        newPlayers =
            List.map
                (\player ->
                    if player.id == id then
                        { player | name = model.name }

                    else
                        player
                )
                model.players
    in
    { model | players = newPlayers }


view : Model -> Html Msg
view model =
    div [ class "scoreboard" ]
        [ h1 [] [ text "Score Keeper" ]

        -- , playerList model
        , playerForm model
        , text (toString model)
        ]


playerForm : Model -> Html Msg
playerForm model =
    Html.form [ onSubmit Save ]
        [ input [ type_ "text", placeholder "Add/Edit Player...", onInput Input, value model.name ] []
        , button [ type_ "Submit" ] [ text "Save" ]
        , button [ type_ "Button", onClick Cancel ] [ text "Cancel" ]
        ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initModel, update = update, view = view }
