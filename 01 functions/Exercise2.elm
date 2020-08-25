module Main exposing (main)

import Html exposing (text)


uppercaseLongNames : String -> ( String, Int )
uppercaseLongNames name =
    let
        nameLength =
            String.length name
    in
    if nameLength > 10 then
        ( String.toUpper name, nameLength )

    else
        ( name, nameLength )


showNameWithLength : String -> String
showNameWithLength name =
    let
        ( casedName, nameLength ) =
            uppercaseLongNames name
    in
    casedName ++ " - name length: " ++ Basics.toString nameLength


main =
    text (showNameWithLength "Diogo Korok")
