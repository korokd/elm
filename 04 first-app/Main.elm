module Main exposing (main)

import Debug exposing (log)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



-- model


type alias Model =
    { currentCalories : Int
    , caloriesToAdd : Int
    }


initModel : Model
initModel =
    { currentCalories = 0
    , caloriesToAdd = 0
    }



-- update


type Msg
    = AddCalorie
    | Clear
    | SetCalorie String


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddCalorie ->
            { model | currentCalories = model.currentCalories + model.caloriesToAdd, caloriesToAdd = 0 }

        Clear ->
            initModel

        SetCalorie caloriesToAdd ->
            { model | caloriesToAdd = caloriesToAdd |> String.toInt |> Result.withDefault 0 }



-- view


view : Model -> Html Msg
view model =
    div []
        [ h3 []
            [ text ("Total Calories: " ++ toString model.currentCalories) ]
        , div []
            [ input [ type_ "number", step "1", placeholder "Calories", value (toString model.caloriesToAdd), onInput SetCalorie ] []
            ]
        , button
            [ type_ "button"
            , onClick AddCalorie
            ]
            [ text "Add" ]
        , button
            [ type_ "button"
            , onClick Clear
            ]
            [ text "Clear" ]
        ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initModel
        , update = update
        , view = view
        }
