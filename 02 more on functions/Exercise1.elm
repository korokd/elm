module Main exposing (main)

import Html exposing (Html, div, text)
import Html.Attributes exposing (style)


wordCount =
    String.words >> List.length


(~=) : String -> String -> Bool
(~=) leftString rightString =
    String.left 1 leftString == String.left 1 rightString


makeExerciseText : String -> String -> Html msg
makeExerciseText exercise result =
    div []
        [ text ("Exercise " ++ exercise ++ ":")
        , div []
            [ text result
            ]
        ]


main =
    let
        calledAsInfix =
            "abacate" ~= "abacaxi"

        calledAsPrefix =
            (~=) "abacate" "carambola"
    in
    div []
        [ div [ style [ ( "margin-bottom", "10px" ) ] ]
            [ makeExerciseText "1" (Basics.toString calledAsInfix)
            ]
        , div [ style [ ( "margin-bottom", "10px" ) ] ]
            [ makeExerciseText "2" (Basics.toString calledAsPrefix)
            ]
        , div []
            [ makeExerciseText "3" (Basics.toString (wordCount "Abra Kadabra Alakazam"))
            ]
        ]
