module Pieces exposing (shapes, to, snap, rotate, flip, add, draw)

import Svg exposing (..)
import Svg.Attributes exposing (..)


type alias Point =
    ( Float, Float )


type alias Shape =
    List Point


shapes =
    { bigTriangle1 = triangle 2
    , bigTriangle2 = triangle 2
    , mediumTriangle1 = triangle (sqrt 2)
    , smallTriangle1 = triangle 1
    , smallTriangle2 = triangle 1
    , parallelogram1 = parallelogram
    , square1 = square
    }


to : List Point -> Int -> Point
to shape pointNumber =
    shape
        |> List.drop (pointNumber - 1)
        |> List.head
        |> Maybe.withDefault ( 0, 0 )


snap : Int -> Point -> Shape -> Shape
snap pointNumber snapTarget shape =
    case
        shape
            |> List.drop (pointNumber - 1)
            |> List.head
    of
        Just pivot ->
            shape
                |> sub pivot
                |> add snapTarget

        Nothing ->
            shape


add : Point -> Shape -> Shape
add ( dx, dy ) shape =
    List.map (\( x, y ) -> ( x + dx, y + dy )) shape


sub : Point -> Shape -> Shape
sub ( x, y ) =
    add ( -x, -y )


rotate : Float -> Shape -> Shape
rotate angle shape =
    let
        rad =
            degrees angle

        rotate_ ( x, y ) =
            ( cos rad * x + sin rad * y
            , sin rad * -x + cos rad * y
            )
    in
        List.map rotate_ shape


flip : Shape -> Shape
flip shape =
    List.map (\( x, y ) -> ( -x, y )) shape


triangle : Float -> Shape
triangle size =
    [ ( 0, 0 )
    , ( size, 0 )
    , ( 0, size )
    ]


parallelogram : Shape
parallelogram =
    [ ( 0, 0 )
    , ( 1, 0 )
    , ( 2, -1 )
    , ( 1, -1 )
    ]


square : Shape
square =
    [ ( 0, 0 )
    , ( 1, 0 )
    , ( 1, 1 )
    , ( 0, 1 )
    ]


draw : String -> Shape -> Svg msg
draw color shape =
    polygon
        [ shape
            |> List.concatMap (\( x, y ) -> [ x, y ])
            |> List.map toString
            |> String.join ","
            |> points
        , fill color
        , stroke "white"
        , strokeWidth "0.05"
        ]
        []
