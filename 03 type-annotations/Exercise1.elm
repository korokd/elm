module Main exposing (main)

import Html exposing (text)


cart =
    [ { name = "Lemon", qty = 1, freeQty = 0 }
    , { name = "Apple", qty = 5, freeQty = 0 }
    , { name = "Pear", qty = 10, freeQty = 0 }
    ]


applyFreeQty minQty qtyToFree item =
    if item.freeQty == 0 && item.qty >= minQty then
        { item | freeQty = qtyToFree }

    else
        item


promoedCart =
    List.map (applyFreeQty 10 3 >> applyFreeQty 5 1) cart


main =
    text (Basics.toString promoedCart)
