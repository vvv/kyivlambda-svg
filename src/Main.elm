module Main exposing (main)

import Browser
import Color exposing (black, lightGrey, rgb255)
import Html exposing (Html)
import TypedSvg as TSvg
import TypedSvg.Attributes as TSvgA
    exposing
        ( fillRule
        , stroke
        , strokeLinecap
        , strokeLinejoin
        , transform
        , viewBox
        )
import TypedSvg.Attributes.InPx exposing (height, strokeWidth, width)
import TypedSvg.Core exposing (Attribute, Svg, node)
import TypedSvg.Types
    exposing
        ( Fill(..)
        , FillRule(..)
        , StrokeLinecap(..)
        , StrokeLinejoin(..)
        , Transform(..)
        )


main : Program () Model msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = \_ model -> model
        }


----------------------------------------------------------------------
-- MODEL


type Model
  = Elm
  | Haskell
  | Rust
  | KyivMetro
  | KyivElm
  | KyivHaskell
  | KyivRust
  | KyivLambda


init : Model
init =
    Rust


----------------------------------------------------------------------
-- VIEW


view : Model -> Html msg
view model =
    TSvg.svg (attributes model) (svgs model)


attributes : Model -> List (Attribute msg)
attributes model =
    case model of
        Haskell ->
            [ width 340, height 240, viewBox 0 0 170 120 ]

        Rust ->
            [ width 144, height 144 ]

        KyivMetro ->
            [ width 311.75, height 363.125 ]

        KyivHaskell ->
            [ width 311.75, height 363.125 ]

        _ ->
            Debug.todo "XXX IMPLEMENTME"


type alias Path msg =
  { d : String
  , fill : Model -> Fill
  , otherAttrs : List (Attribute msg)
  }


svgs : Model -> List (Svg msg)
svgs model =
    let
        pathToSvg : Path msg -> Svg msg
        pathToSvg p =
            TSvg.path
                (TSvgA.d p.d :: TSvgA.fill (p.fill model) :: p.otherAttrs)
                []
    in
    case model of
        Haskell ->
            List.map pathToSvg [ gtSymbol, lambdaSymbol, eqSymbol ]

        Rust ->
            List.map pathToSvg [ rustWheel, rustCogs ]

        KyivMetro ->
            List.map pathToSvg
                [ outerArc
                , innerSemicircle
                , letterM
                , leavesBg
                , leafLeft
                , leafMiddle
                , leafRight
                ]

        KyivHaskell ->
            List.map pathToSvg
                [ outerArc
                , leafLeft
                , leafMiddle
                , leafRight
                ]
                ++ [ node "svg"
                        [ viewBox 0 0 170 120 ]  -- XXX Use `attributes`?
                        [ TSvg.g
                            [ transform [ Scale 0.65 0.65, Translate 55 -15 ] ]
                            (svgs Haskell)
                        ]
                   ]

        _ ->
            Debug.todo "XXX IMPLEMENTME"


----------------------------------------------------------------------
-- Haskell logo adapted from
-- https://upload.wikimedia.org/wikipedia/commons/1/1c/Haskell-Logo.svg


gtSymbol : Path msg
gtSymbol =
    Path
        """
        M 0,120
        L 40,60
        L 0,0
        L 30,0
        L 70,60
        L 30,120
        z
        """
        fillLeaf
        []


lambdaSymbol : Path msg
lambdaSymbol =
    Path
        """
        M 40,120
        L 80,60
        L 40,0
        L 70 0
        L 150,120
        L 120,120
        L 95,82.5
        L 70,120
        z
        """
        (Fill << always (rgb255 0x68 0x5a 0x93))
        []


eqSymbol : Path msg
eqSymbol =
    Path
        """
        M 116.666667,55
        L 103.333333,35
        L 170,35
        L 170,55
        z
        M 136.666667,85
        L 123.333333,65
        L 170,65
        L 170,85
        z
        """
        (Fill << always (rgb255 0x8f 0x52 0x8c))
        []


----------------------------------------------------------------------
-- Rust logo adapted from
-- https://github.com/rust-lang/www.rust-lang.org/blob/master/static/logos/rust-logo-blk.svg

rustWheel : Path msg
rustWheel =
    Path
        "m71.05 23.68c-26.06 0-47.27 21.22-47.27 47.27s21.22 47.27 47.27 47.27 47.27-21.22 47.27-47.27-21.22-47.27-47.27-47.27zm-.07 4.2a3.1 3.11 0 0 1 3.02 3.11 3.11 3.11 0 0 1 -6.22 0 3.11 3.11 0 0 1 3.2-3.11zm7.12 5.12a38.27 38.27 0 0 1 26.2 18.66l-3.67 8.28c-.63 1.43.02 3.11 1.44 3.75l7.06 3.13a38.27 38.27 0 0 1 .08 6.64h-3.93c-.39 0-.55.26-.55.64v1.8c0 4.24-2.39 5.17-4.49 5.4-2 .23-4.21-.84-4.49-2.06-1.18-6.63-3.14-8.04-6.24-10.49 3.85-2.44 7.85-6.05 7.85-10.87 0-5.21-3.57-8.49-6-10.1-3.42-2.25-7.2-2.7-8.22-2.7h-40.6a38.27 38.27 0 0 1 21.41-12.08l4.79 5.02c1.08 1.13 2.87 1.18 4 .09zm-44.2 23.02a3.11 3.11 0 0 1 3.02 3.11 3.11 3.11 0 0 1 -6.22 0 3.11 3.11 0 0 1 3.2-3.11zm74.15.14a3.11 3.11 0 0 1 3.02 3.11 3.11 3.11 0 0 1 -6.22 0 3.11 3.11 0 0 1 3.2-3.11zm-68.29.5h5.42v24.44h-10.94a38.27 38.27 0 0 1 -1.24-14.61l6.7-2.98c1.43-.64 2.08-2.31 1.44-3.74zm22.62.26h12.91c.67 0 4.71.77 4.71 3.8 0 2.51-3.1 3.41-5.65 3.41h-11.98zm0 17.56h9.89c.9 0 4.83.26 6.08 5.28.39 1.54 1.26 6.56 1.85 8.17.59 1.8 2.98 5.4 5.53 5.4h16.14a38.27 38.27 0 0 1 -3.54 4.1l-6.57-1.41c-1.53-.33-3.04.65-3.37 2.18l-1.56 7.28a38.27 38.27 0 0 1 -31.91-.15l-1.56-7.28c-.33-1.53-1.83-2.51-3.36-2.18l-6.43 1.38a38.27 38.27 0 0 1 -3.32-3.92h31.27c.35 0 .59-.06.59-.39v-11.06c0-.32-.24-.39-.59-.39h-9.15zm-14.43 25.33a3.11 3.11 0 0 1 3.02 3.11 3.11 3.11 0 0 1 -6.22 0 3.11 3.11 0 0 1 3.2-3.11zm46.05.14a3.11 3.11 0 0 1 3.02 3.11 3.11 3.11 0 0 1 -6.22 0 3.11 3.11 0 0 1 3.2-3.11z"
        (Fill << always black)
        []


rustCogs : Path msg
rustCogs =
    Path
        "m115.68 70.95a44.63 44.63 0 0 1 -44.63 44.63 44.63 44.63 0 0 1 -44.63-44.63 44.63 44.63 0 0 1 44.63-44.63 44.63 44.63 0 0 1 44.63 44.63zm-.84-4.31 6.96 4.31-6.96 4.31 5.98 5.59-7.66 2.87 4.78 6.65-8.09 1.32 3.4 7.46-8.19-.29 1.88 7.98-7.98-1.88.29 8.19-7.46-3.4-1.32 8.09-6.65-4.78-2.87 7.66-5.59-5.98-4.31 6.96-4.31-6.96-5.59 5.98-2.87-7.66-6.65 4.78-1.32-8.09-7.46 3.4.29-8.19-7.98 1.88 1.88-7.98-8.19.29 3.4-7.46-8.09-1.32 4.78-6.65-7.66-2.87 5.98-5.59-6.96-4.31 6.96-4.31-5.98-5.59 7.66-2.87-4.78-6.65 8.09-1.32-3.4-7.46 8.19.29-1.88-7.98 7.98 1.88-.29-8.19 7.46 3.4 1.32-8.09 6.65 4.78 2.87-7.66 5.59 5.98 4.31-6.96 4.31 6.96 5.59-5.98 2.87 7.66 6.65-4.78 1.32 8.09 7.46-3.4-.29 8.19 7.98-1.88-1.88 7.98 8.19-.29-3.4 7.46 8.09 1.32-4.78 6.65 7.66 2.87z"
        (Fill << always black)
        [ fillRule FillRuleEvenOdd
        , stroke black
        , strokeLinecap StrokeLinecapRound
        , strokeLinejoin StrokeLinejoinRound
        , strokeWidth 3
        ]


----------------------------------------------------------------------
-- Kyiv Metro logo adapted from
-- https://upload.wikimedia.org/wikipedia/commons/b/be/Kyiv_Metro_logo.svg


fillLeaf : Model -> Fill
fillLeaf model =
    Fill <|
        if model == KyivMetro then
            rgb255 0 0x92 0x3f
        else
            rgb255 0x46 0x3c 0x62


fillEdge : Model -> Fill
fillEdge model =
    Fill <|
        if model == KyivMetro then
            rgb255 0xfe 0xf4 6
        else
            lightGrey


outerArc : Path msg
outerArc =
    Path
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
        fillEdge
        []


innerSemicircle : Path msg
innerSemicircle =
    Path
        """
        M 155.875,16.25
        C 86.323,16.25 29.875,73.46839 29.875,144
        C 29.875,162.51455 33.75476,180.11183 40.75,196
        L 271,196
        C 277.99524,180.11183 281.875,162.51455 281.875,144
        C 281.875,73.4684 225.427,16.24999 155.875,16.25
        z
        """
        fillEdge
        []


letterM : Path msg
letterM =
    Path
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
        fillLeaf
        []


leavesBg : Path msg
leavesBg =
    Path
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
        fillEdge
        []


leafLeft : Path msg
leafLeft =
    Path
        """
        M 9.875,297
        L 39.875,213
        L 149.875,213
        L 81.875,297
        L 9.875,297
        z
        """
        fillLeaf
        []


leafMiddle : Path msg
leafMiddle =
    Path
        """
        M 155.875,353
        L 108.875,304
        L 155.875,223
        L 202.875,304
        L 155.875,353
        z
        """
        fillLeaf
        []


leafRight : Path msg
leafRight =
    Path
        """
        M 301.875,297
        L 271.875,213
        L 161.875,213
        L 229.875,297
        L 301.875,297
        z
        """
        fillLeaf
        []
