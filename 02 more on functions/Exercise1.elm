module Main exposing (main)

import Html exposing (Html, div, text)
import Html.Attributes exposing (style)


(~=) : String -> String -> Bool
(~=) leftString rightString =
    String.left 1 leftString == String.left 1 rightString


makeExerciseText : Int -> Bool -> Html msg
makeExerciseText exercise almostEqual =
    div []
        [ text ("Exercise " ++ Basics.toString exercise ++ ":")
        , div []
            [ text (Basics.toString almostEqual)
            ]
        ]


main =
    let
        calledInfix =
            "abacate" ~= "abacaxi"

        calledPrefix =
            (~=) "abacate" "carambola"
    in
    div []
        [ div [ style [("margin-bottom", "10px")] ]
            [ makeExerciseText 1 calledInfix
            ]
        , div []
            [ makeExerciseText 2 calledPrefix
            ]
        ]
