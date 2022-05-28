module Main exposing (..)

import Array
import Browser
import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (onClick)
import Maybe exposing (withDefault)
import Random



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view >> toUnstyled
        }



-- MODEL


type alias Model =
    { diceFace : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 1
    , Cmd.none
    )



-- UPDATE


type Msg
    = Roll
    | NewFace Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model
            , Random.generate NewFace roll
            )

        NewFace newFace ->
            ( Model newFace
            , Cmd.none
            )


roll : Random.Generator Int
roll =
    Random.int 1 6



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ h1 [] [ text (String.fromInt model.diceFace) ]
            , button [ onClick Roll ] [ text "随机" ]
            ]
        , choose_face model.diceFace
        ]


type DiceFace
    = First
    | Second
    | Third
    | Fourth
    | Fifth
    | Sixth


enumDiceFace =
    Array.fromList
        [ First
        , Second
        , Third
        , Fourth
        , Fifth
        , Sixth
        ]


choose_face num =
    let
        f =
            withDefault First (Array.get (num - 1) enumDiceFace)
    in
    case f of
        First ->
            first_face

        Second ->
            second_face

        Third ->
            third_face

        Fourth ->
            fourth_face

        Fifth ->
            fifth_face

        Sixth ->
            sixth_face


pip =
    [ display block
    , width (px 24)
    , height (px 24)
    , borderRadius (pct 50)
    , margin (px 4)
    , backgroundColor (hex "#333")
    , boxShadow4 inset (px 0) (px 3) (hex "#111")
    , boxShadow4 inset (px 0) (px -3) (hex "#555")
    ]


face =
    [ displayFlex
    , boxSizing borderBox
    , backgroundColor (hex "#e7e7e7")
    , width (px 104)
    , height (px 104)
    , boxShadow4 inset (px 0) (px 5) (hex "#fff")
    , boxShadow4 inset (px 0) (px -5) (hex "#bbb")
    , boxShadow4 inset (px 5) (px 0) (hex "#d7d7d7")
    , boxShadow4 inset (px -5) (px 0) (hex "#d7d7d7")
    , borderRadius (pct 10)
    ]


first_face =
    div
        [ css
            (List.append face
                [ justifyContent center
                , alignItems center
                ]
            )
        ]
        [ span [ css pip ] []
        ]


second_face =
    div
        [ css
            (List.append face
                [ justifyContent spaceBetween
                ]
            )
        ]
        [ span [ css pip ] []
        , span [ css (List.append pip [ alignSelf flexEnd ]) ] []
        ]


third_face =
    div
        [ css
            (List.append face
                [ justifyContent spaceBetween
                ]
            )
        ]
        [ span [ css pip ] []
        , span [ css (List.append pip [ alignSelf center ]) ] []
        , span [ css (List.append pip [ alignSelf flexEnd ]) ] []
        ]


fourth_face =
    div
        [ css
            (List.append face
                [ justifyContent spaceBetween
                ]
            )
        ]
        [ div [ css [ displayFlex, flexDirection column, justifyContent spaceBetween ] ]
            [ span [ css pip ] []
            , span [ css pip ] []
            ]
        , div [ css [ displayFlex, flexDirection column, justifyContent spaceBetween ] ]
            [ span [ css pip ] []
            , span [ css pip ] []
            ]
        ]


fifth_face =
    div
        [ css
            (List.append face
                [ justifyContent spaceBetween
                ]
            )
        ]
        [ div [ css [ displayFlex, flexDirection column, justifyContent spaceBetween ] ]
            [ span [ css pip ] []
            , span [ css pip ] []
            ]
        , div [ css [ displayFlex, flexDirection column, justifyContent center ] ]
            [ span [ css pip ] []
            ]
        , div [ css [ displayFlex, flexDirection column, justifyContent spaceBetween ] ]
            [ span [ css pip ] []
            , span [ css pip ] []
            ]
        ]


sixth_face =
    div
        [ css
            (List.append face
                [ justifyContent spaceBetween
                ]
            )
        ]
        [ div [ css [ displayFlex, flexDirection column, justifyContent spaceBetween ] ]
            [ span [ css pip ] []
            , span [ css pip ] []
            , span [ css pip ] []
            ]
        , div [ css [ displayFlex, flexDirection column, justifyContent spaceBetween ] ]
            [ span [ css pip ] []
            , span [ css pip ] []
            , span [ css pip ] []
            ]
        ]
