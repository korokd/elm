module Main exposing (main)

import Html exposing (div, text)


(~=) : String -> String -> Bool
(~=) leftString rightString =
    String.left 1 leftString == String.left 1 rightString


main =
    let
        calledInfix =
            "abacate" ~= "abacaxi"

        calledPrefix =
            (~=) "abacate" "carambola"
    in
    div []
        [ div []
            [ text (Basics.toString calledInfix)
            ]
        , div []
            [ text (Basics.toString calledPrefix)
            ]
        ]
