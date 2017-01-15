module Main exposing (..)

import Svg exposing (..)
import Svg.Attributes exposing (..)


type alias Point =
    ( Float, Float )


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
            triangle 2
                |> rotate (45 + 180)

        parallelogram1 =
            parallelogram
                |> rotate -45
                |> snap 1 (to bigTriangle1 3)

        mediumTriangle =
            triangle (sqrt 2)
                |> rotate -90
                |> snap 3 (to parallelogram1 4)
    in
        svg [ viewBox "-3 -3 10 10" ]
            [ bigTriangle1
                |> draw colors.gray
            , triangle 2
                |> rotate -45
                |> draw colors.blue
            , triangle 1
                |> rotate (45 + 90)
                |> draw colors.orange
            , parallelogram1
                |> draw colors.green
            , mediumTriangle
                |> draw colors.blue
            , square
                |> rotate 45
                |> draw colors.green
            , triangle 1
                |> rotate 45
                |> snap 2 (to mediumTriangle 2)
                |> draw colors.orange
            ]


to : List Point -> Int -> Point
to ps pointNumber =
    ps
        |> List.drop (pointNumber - 1)
        |> List.head
        |> Maybe.withDefault ( 0, 0 )


snap : Int -> Point -> List Point -> List Point
snap pointNumber snapTarget ps =
    case
        ps
            |> List.drop (pointNumber - 1)
            |> List.head
    of
        Just pivot ->
            ps
                |> sub pivot
                |> add snapTarget

        Nothing ->
            ps


add : Point -> List Point -> List Point
add ( dx, dy ) ps =
    List.map (\( x, y ) -> ( x + dx, y + dy )) ps


sub : Point -> List Point -> List Point
sub ( x, y ) =
    add ( -x, -y )


rotate : Float -> List Point -> List Point
rotate angle ps =
    let
        rad =
            degrees angle

        rotate_ ( x, y ) =
            ( cos rad * x + sin rad * y
            , sin rad * -x + cos rad * y
            )
    in
        List.map rotate_ ps


triangle : Float -> List Point
triangle size =
    [ ( 0, 0 )
    , ( size, 0 )
    , ( 0, size )
    ]


parallelogram : List Point
parallelogram =
    [ ( 0, 0 )
    , ( 1, 0 )
    , ( 2, -1 )
    , ( 1, -1 )
    ]


square : List Point
square =
    [ ( 0, 0 )
    , ( 1, 0 )
    , ( 1, 1 )
    , ( 0, 1 )
    ]


draw : String -> List Point -> Svg msg
draw color ps =
    polygon
        [ ps
            |> List.concatMap (\( x, y ) -> [ x, y ])
            |> List.map toString
            |> String.join ","
            |> points
        , fill color
        , stroke "white"
        , strokeWidth "0.05"
        ]
        []
