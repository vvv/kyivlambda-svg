module Main exposing (main)

import Browser
import Color exposing (lightGrey, rgb255)
import Html exposing (Html)
import TypedSvg as TSvg
import TypedSvg.Attributes as TSvgA exposing (fill, strokeLinejoin, viewBox)
import TypedSvg.Attributes.InPx exposing (height, strokeWidth, width)
import TypedSvg.Core exposing (Attribute, Svg)
import TypedSvg.Types exposing (Fill(..), StrokeLinejoin(..))


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
  | KyivMetro
  | KyivHaskell
  | KyivElm
  | KyivRust
  | KyivLambda


init : Model
init =
    KyivMetro


----------------------------------------------------------------------
-- VIEW


view : Model -> Html msg
view model =
    TSvg.svg (attributes model) (svgs model)


----------------------------------------------------------------------


attributes : Model -> List (Attribute msg)
attributes model =
    case model of
        Haskell ->
            [ viewBox 0 0 170 120 ]

        KyivMetro ->
            [ width 311.75, height 363.125 ]

        _ ->
            Debug.todo "XXX IMPLEMENTME"


type alias Path msg =
  { d : String
  , style : Model -> List (Attribute msg)
  }


svgs : Model -> List (Svg msg)
svgs model =
    let
        path : Path msg -> Svg msg
        path p =
            TSvg.path (TSvgA.d p.d :: p.style model) []
    in
    case model of
        Haskell ->
            Debug.todo "XXX IMPLEMENTME"

        KyivMetro ->
            List.map path
                [ outerArc
                , innerSemicircle
                , letterM
                , leavesBg
                , leafLeft
                , leafMiddle
                , leafRight
                ]

        _ ->
            Debug.todo "XXX IMPLEMENTME"


----------------------------------------------------------------------
-- Haskell logo adapted from
-- https://upload.wikimedia.org/wikipedia/commons/1/1c/Haskell-Logo.svg


element1_XXX : Path msg
element1_XXX =
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
        (Debug.todo "XXX IMPLEMENTME")


----------------------------------------------------------------------
-- Kyiv Metro logo adapted from
-- https://upload.wikimedia.org/wikipedia/commons/b/be/Kyiv_Metro_logo.svg


colorLeaf : Model -> Fill
colorLeaf model =
    Fill <|
        if model == KyivMetro then
            rgb255 0 0x92 0x3f
        else
            rgb255 0x46 0x3c 0x62


colorEdge : Model -> Fill
colorEdge model =
    Fill <|
        if model == KyivMetro then
            rgb255 0xfe 0xf4 6
        else
            lightGrey


style1_XXX : Model -> List (Attribute msg)
style1_XXX model =
    [ fill (colorEdge model)
    , strokeWidth 0.5
    , strokeLinejoin StrokeLinejoinBevel
    ]


style2_XXX : Model -> List (Attribute msg)
style2_XXX model =
    [ fill (colorLeaf model)
    , strokeWidth 0.1
    , strokeLinejoin StrokeLinejoinMiter
    ]


style3_XXX : Model -> List (Attribute msg)
style3_XXX model =
    [ fill (colorEdge model)
    , strokeWidth 3.5
    , strokeLinejoin StrokeLinejoinMiter
    ]


style4_XXX : Model -> List (Attribute msg)
style4_XXX model =
    [ fill (colorLeaf model)
    , strokeWidth 1
    , strokeLinejoin StrokeLinejoinMiter
    ]


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
        style1_XXX


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
        style1_XXX


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
        style2_XXX


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
        style3_XXX


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
        style4_XXX


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
        style2_XXX


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
        style2_XXX


{--XXX
colorLeaf : String
colorLeaf =
    -- "#00923f"
    "#463c62"


-- Adapted from
-- https://upload.wikimedia.org/wikipedia/commons/1/1c/Haskell-Logo.svg
-- and
-- https://d21ii91i3y6o6h.cloudfront.net/gallery_images/from_proof/3377/large/1417630540/haskell.png
logoHaskell : Html msg
logoHaskell =
    Svg.svg
        [ SvgA.viewBox "0 0 170 120" ]
        [ Svg.path
            [ SvgA.d
                """
                M 0,120
                L 40,60
                L 0,0
                L 30,0
                L 70,60
                L 30,120
                z
                """
            , SvgA.style <| "fill:" ++ colorLeaf
            ]
            []
        , Svg.path
            [ SvgA.d
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
            , SvgA.style "fill:#685a93"
            ]
            []
        , Svg.g
            [ SvgA.style "fill:#8f528c" ]
            [ Svg.path
                [ SvgA.d
                    """
                    M 116.666667,55
                    L 103.333333,35
                    L 170,35
                    L 170,55
                    z
                    """
                ]
                []
            , Svg.path
                [ SvgA.d
                    """
                    M 136.666667,85
                    L 123.333333,65
                    L 170,65
                    L 170,85
                    z
                    """
                ]
                []
            ]
        ]


-- Adapted from
-- https://upload.wikimedia.org/wikipedia/commons/b/be/Kyiv_Metro_logo.svg
logoKyivMetro : Html msg
logoKyivMetro =
    let
        yellow =
            "lightgrey"
            -- "#fef406"

        style1 =
            SvgA.style <|
                "fill:"
                    ++ yellow
                    ++ "; stroke-width:0.5; stroke-linejoin:bevel"

        style2 =
            SvgA.style <|
                "fill:"
                    ++ colorLeaf
                    ++ "; stroke-width:0.1; stroke-linejoin:miter"

        style3 =
            SvgA.style <|
                "fill:"
                    ++ yellow
                    ++ "; stroke-width:3.5; stroke-linejoin:miter"

        style4 =
            SvgA.style <|
                "fill:"
                    ++ colorLeaf
                    ++ "; stroke-width:1; stroke-linejoin:miter"

        outerArc =
            Svg.path
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

        innerSemicircle =
            Svg.path
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

        letterM =
            Svg.path
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

        leavesBg =
            Svg.path
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

        leafLeft =
            Svg.path
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

        leafMiddle =
            Svg.path
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

        leafRight =
            Svg.path
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
    in
    Svg.svg
        [ SvgA.width "311.75"
        , SvgA.height "363.125"
        ]
        [ outerArc
        -- , innerSemicircle
        -- , letterM
        -- , leavesBg
        , leafLeft
        , leafMiddle
        , leafRight
        , Svg.g
            [ SvgA.transform "scale(0.65) translate(105 7)" ]
            [ logoHaskell ]
        ]
--}
