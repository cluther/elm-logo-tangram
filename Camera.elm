module Main exposing (..)

import Pieces exposing (..)
import Svg exposing (Svg, svg)
import Svg.Attributes exposing (viewBox)


colors =
    { cyan = "#00a7b5"
    , orange = "#f99000"
    , blue = "#0051a8"
    , red = "#ef4a0e"
    }


main : Svg msg
main =
    let
        bigTriangle1 =
            shapes.bigTriangle1 |> rotate 90

        bigTriangle2 =
            shapes.bigTriangle2 |> rotate 270 |> snap 2 (to bigTriangle1 3)

        smallTriangle1 =
            shapes.smallTriangle1 |> rotate 0 |> snap 3 (to bigTriangle2 1)

        square1 =
            shapes.square1 |> snap 3 (to bigTriangle2 1)

        smallTriangle2 =
            shapes.smallTriangle2 |> rotate 180 |> snap 2 (to bigTriangle2 3)

        mediumTriangle1 =
            shapes.mediumTriangle1 |> rotate -135 |> snap 1 (to bigTriangle1 2) |> add ( 0, 0.5 )

        parallelogram1 =
            shapes.parallelogram1 |> rotate 90 |> Pieces.flip |> snap 2 (to mediumTriangle1 2)
    in
        svg [ viewBox "-1.5 -3.5 10 10" ]
            (List.map (\( c, s ) -> draw c s)
                [ ( colors.cyan, bigTriangle1 )
                , ( colors.orange, bigTriangle2 )
                , ( colors.cyan, smallTriangle1 )
                , ( colors.blue, square1 )
                , ( colors.red, smallTriangle2 )
                , ( colors.blue, mediumTriangle1 )
                , ( colors.red, parallelogram1 )
                ]
            )
