module Main exposing (main)

import Html exposing (text)


(~=) : String -> String -> Bool
(~=) leftString rightString =
    String.left 1 leftString == String.left 1 rightString


main =
    text (Basics.toString ("abacate" ~= "abacaxi"))
