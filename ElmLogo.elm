module Main exposing (..)

import Pieces exposing (..)
import Svg exposing (Svg, svg)
import Svg.Attributes exposing (viewBox)


colors =
    { gray = "#5a6378"
    , green = "#83c833"
    , orange = "#efa500"
    , blue = "#5fb4ca"
    }


main : Svg msg
main =
    let
        bigTriangle1 =
            shapes.bigTriangle1 |> rotate (45 + 180)

        bigTriangle2 =
            shapes.bigTriangle2 |> rotate -45

        smallTriangle1 =
            shapes.smallTriangle1 |> rotate (45 + 90)

        square1 =
            shapes.square1 |> rotate 45

        parallelogram1 =
            shapes.parallelogram1 |> rotate -45 |> snap 1 (to bigTriangle1 3)

        mediumTriangle1 =
            shapes.mediumTriangle1 |> rotate -90 |> snap 2 (to square1 3)

        smallTriangle2 =
            shapes.smallTriangle2 |> rotate 45 |> snap 2 (to square1 3)
    in
        svg [ viewBox "-2.1 -2.1 10 10" ]
            (List.map (\( c, s ) -> draw c s)
                [ ( colors.gray, bigTriangle1 )
                , ( colors.blue, bigTriangle2 )
                , ( colors.orange, smallTriangle1 )
                , ( colors.green, square1 )
                , ( colors.green, parallelogram1 )
                , ( colors.blue, mediumTriangle1 )
                , ( colors.orange, smallTriangle2 )
                ]
            )
