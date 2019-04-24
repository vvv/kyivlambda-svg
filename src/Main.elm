module Main exposing (main)

import Html exposing (Html)
import Svg
import Svg.Attributes as SvgA


main : Html msg
main =
    metroKyiv


-- Adopted from
-- https://upload.wikimedia.org/wikipedia/commons/b/be/Kyiv_Metro_logo.svg
metroKyiv : Html msg
metroKyiv =
    let
        style1 =
            SvgA.style
                "fill:#fef406; stroke-width:0.5; stroke-linejoin:bevel"

        style2 =
            SvgA.style
                "fill:#00923f; stroke-width:0.1; stroke-linejoin:miter"

        style3 =
            SvgA.style
                "fill:#fef406; stroke-width:3.5; stroke-linejoin:miter"

        style4 =
            SvgA.style
                "fill:#00923f; stroke-width:1; stroke-linejoin:miter"
    in
    Svg.svg
        [ SvgA.version "1.0"
        , SvgA.width "311.75"
        , SvgA.height "363.125"
        ]
        [ Svg.path
            [ SvgA.d
                """
                M 155.875,0
                C 77.491,0 13.875,64.512 13.875,144
                C 13.875,162.34831 17.321494,179.85689 23.5,196
                L 32,196
                C 25.447068,179.98274 21.875,162.41298 21.875,144
                C 21.875,68.9902 81.907,8.125 155.875,8.125
                C 229.843,8.125 289.875,68.9902 289.875,144
                C 289.875,162.41298 286.30294,179.98274 279.75,196
                L 288.25,196
                C 294.4285,179.85689 297.875,162.34831 297.875,144
                C 297.875,64.512 234.259,0 155.875,0
                z
                """
            , style1
            ]
            []
        , Svg.path
            [ SvgA.d
                """
                M 155.875,16.25
                C 86.323,16.25 29.875,73.46839 29.875,144
                C 29.875,162.51455 33.75476,180.11183 40.75,196
                L 271,196
                C 277.99524,180.11183 281.875,162.51455 281.875,144
                C 281.875,73.4684 225.427,16.24999 155.875,16.25
                z
                """
            , style1
            ]
            []
        , Svg.path
            [ SvgA.d
                """
                M 110.875,44
                L 44.875,178
                L 89.875,178
                L 114.875,128
                L 155.875,178
                L 196.875,128
                L 221.875,178
                L 266.875,178
                L 200.875,44
                L 155.875,106
                L 110.875,44
                z
                """
            , style2
            ]
            []
        , Svg.path
            [ SvgA.d
                """
                M 35,206
                L 0,304
                L 85.25,304
                L 140.125,236.25
                L 100.125,305
                L 155.875,363.125
                L 211.625,305
                L 171.75,236.25
                L 226.5,304
                L 311.75,304
                L 276.75,206
                L 164.5,206
                L 147.25,206
                L 35,206
                z
                """
            , style3
            ]
            []
        , Svg.path
            [ SvgA.d
                """
                M 9.875,297
                L 39.875,213
                L 149.875,213
                L 81.875,297
                L 9.875,297
                z
                """
            , style4
            ]
            []
        , Svg.path
            [ SvgA.d
                """
                M 301.875,297
                L 271.875,213
                L 161.875,213
                L 229.875,297
                L 301.875,297
                z
                """
            , style2
            ]
            []
        , Svg.path
            [ SvgA.d
                """
                M 155.875,353
                L 108.875,304
                L 155.875,223
                L 202.875,304
                L 155.875,353
                z
                """
            , style2
            ]
            []
        ]