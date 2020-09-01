module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Player =
    { id : Int
    , name : String
    }


playerPoints : List Play -> Player -> Int
playerPoints plays player =
    List.filterMap
        (\play ->
            if play.playerId == player.id then
                Just play.points

            else
                Nothing
        )
        plays
        |> List.sum


type alias Play =
    { id : Int
    , playerId : Int
    , points : Int
    }


playScorer : List Player -> Play -> String
playScorer players play =
    List.filterMap
        (\player ->
            if player.id == play.playerId then
                Just player.name

            else
                Nothing
        )
        players
        |> List.head
        |> Maybe.withDefault ""


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
        Cancel ->
            { model | name = initModel.name, playerId = Nothing }

        DeletePlay { id } ->
            { model | plays = List.filter (\play -> play.id /= id) model.plays }

        Edit player ->
            if model.playerId == Just player.id then
                { model | name = "", playerId = Nothing }

            else
                { model | name = player.name, playerId = Just player.id }

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

        Score player points ->
            score model player points


score : Model -> Player -> Int -> Model
score model player points =
    let
        newPlay =
            Play (List.length model.plays) player.id points
    in
    { model | plays = newPlay :: model.plays }


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
            Player (List.length model.players) model.name
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
        , playerList model
        , playerForm model
        , playList model
        ]


playList : Model -> Html Msg
playList model =
    div []
        [ playListHeader
        , playListBody model
        ]


playListHeader : Html Msg
playListHeader =
    header []
        [ div [] [ text "Plays" ]
        , div [] [ text "Points" ]
        ]


playListBody : Model -> Html Msg
playListBody model =
    let
        playToListItem =
            playListItem model
    in
    model.plays
        |> List.map playToListItem
        |> ul []


playListItem : Model -> Play -> Html Msg
playListItem model play =
    li []
        [ i
            [ class "Remove"
            , onClick (DeletePlay play)
            ]
            []
        , div [] [ text (playScorer model.players play) ]
        , div [] [ text (toString play.points) ]
        ]


playerForm : Model -> Html Msg
playerForm model =
    Html.form [ onSubmit Save ]
        [ input [ type_ "text", placeholder "Add/Edit Player...", onInput Input, value model.name ] []
        , button [ type_ "Submit" ] [ text "Save" ]
        , button [ type_ "Button", onClick Cancel ] [ text "Cancel" ]
        ]


playerList : Model -> Html Msg
playerList model =
    div []
        [ playerListHeader
        , playerListBody model
        , playerListFooter model
        ]


playerListHeader : Html Msg
playerListHeader =
    header []
        [ div [] [ text "Name" ]
        , div [] [ text "Points" ]
        ]


playerListBody : Model -> Html Msg
playerListBody model =
    let
        playerToListItem =
            playerListItem model
    in
    model.players
        |> List.sortBy .name
        |> List.map playerToListItem
        |> ul []


playerListItem : Model -> Player -> Html Msg
playerListItem model player =
    li []
        [ i
            [ class "edit"
            , onClick (Edit player)
            ]
            []
        , div []
            [ text player.name ]
        , button
            [ type_ "button"
            , onClick (Score player 2)
            ]
            [ text "2pt" ]
        , button
            [ type_ "button"
            , onClick (Score player 3)
            ]
            [ text "3pt" ]
        , div []
            [ text (toString (playerPoints model.plays player)) ]
        ]


playerListFooter : Model -> Html Msg
playerListFooter model =
    let
        totalPoints =
            List.map .points model.plays |> List.sum
    in
    footer []
        [ div [] [ text "Total:" ]
        , div [] [ text (toString totalPoints) ]
        ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initModel, update = update, view = view }
