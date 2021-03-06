module Main exposing (main)

import Html exposing (Html, text)


uppercaseNameLongerThan : String -> Int -> String
uppercaseNameLongerThan name maxLength =
    if String.length name > maxLength then
        String.toUpper name

    else
        name


main : Html msg
main =
    let
        name =
            "Diogo Korok"

        length =
            String.length name
    in
    uppercaseNameLongerThan name 10
        ++ " - length: "
        ++ Basics.toString length
        |> Html.text
