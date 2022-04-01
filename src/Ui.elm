module Ui exposing
    ( Html, Attribute, toHtml
    , none, text
    , el, row, col
    , clickable
    , icon
    )

{-|

@docs Html, Attribute, toHtml
@docs none, text
@docs el, row, col
@docs clickable
@docs icon

-}

import Css
import Css.Global
import Html
import Html.Styled
import Html.Styled.Attributes
import Ui.Attr
import Ui.Icon


type alias Html msg =
    Html.Styled.Html msg


type alias Attribute msg =
    Ui.Attr.Attribute msg


toHtml : Html msg -> Html.Html msg
toHtml html =
    Html.Styled.toUnstyled (Html.Styled.div (List.concatMap Ui.Attr.toAttributes topLevelAttributes) [ globalCss, html ])


globalCss : Html msg
globalCss =
    Css.Global.global
        [ Css.Global.everything
            [ Css.boxSizing Css.borderBox
            , Css.minHeight Css.zero
            , Css.margin Css.zero
            , Css.padding Css.zero
            , Css.backgroundColor Css.transparent
            , Css.borderStyle Css.none
            , Css.property "font" "inherit"
            , Css.lineHeight Css.inherit
            ]
        , Css.Global.body
            [ Css.fontFamilies [ "Fira Sans", "sans-serif" ]
            , Css.lineHeight (Css.int 1)
            ]

        -- col flex alignment
        , Css.Global.selector ".elm-col.elm-align-left" [ Css.alignItems Css.flexStart ]
        , Css.Global.selector ".elm-col.elm-align-right" [ Css.alignItems Css.flexEnd ]
        , Css.Global.selector ".elm-col.elm-align-top" [ Css.justifyContent Css.flexStart ]
        , Css.Global.selector ".elm-col.elm-align-bottom" [ Css.justifyContent Css.flexEnd ]
        , Css.Global.selector ".elm-col.elm-align-center-x" [ Css.alignItems Css.center ]
        , Css.Global.selector ".elm-col.elm-align-center-y" [ Css.justifyContent Css.center ]

        -- row flex alignment
        , Css.Global.selector ".elm-row.elm-align-left" [ Css.justifyContent Css.flexStart ]
        , Css.Global.selector ".elm-row.elm-align-right" [ Css.justifyContent Css.flexEnd ]
        , Css.Global.selector ".elm-row.elm-align-top" [ Css.alignItems Css.flexStart ]
        , Css.Global.selector ".elm-row.elm-align-bottom" [ Css.alignItems Css.flexEnd ]
        , Css.Global.selector ".elm-row.elm-align-center-x" [ Css.justifyContent Css.center ]
        , Css.Global.selector ".elm-row.elm-align-center-y" [ Css.alignItems Css.center ]
        ]


topLevelAttributes : List (Attribute msg)
topLevelAttributes =
    []



-- BASICS


none : Html msg
none =
    Html.Styled.text ""


text : String -> Html msg
text str =
    Html.Styled.span [] [ Html.Styled.text str ]


icon : Ui.Icon.Icon -> Html msg
icon icon_ =
    Html.Styled.span [ Html.Styled.Attributes.class (Ui.Icon.toClassName icon_) ] []



-- LAYOUT


row : List (Attribute msg) -> List (Html msg) -> Html msg
row attrs children =
    createNode Html.Styled.div
        (Html.Styled.Attributes.class "elm-row"
            :: Html.Styled.Attributes.css rowStyles
            :: List.concatMap Ui.Attr.toAttributes attrs
        )
        children


col : List (Attribute msg) -> List (Html msg) -> Html msg
col attrs children =
    createNode Html.Styled.div
        (Html.Styled.Attributes.class "elm-col"
            :: Html.Styled.Attributes.css colStyles
            :: List.concatMap Ui.Attr.toAttributes attrs
        )
        children


el : List (Attribute msg) -> Html msg -> Html msg
el attrs child =
    row attrs [ child ]


clickable : List (Attribute msg) -> Html msg -> Html msg
clickable attrs child =
    createNode Html.Styled.button
        (Html.Styled.Attributes.class "elm-row"
            :: Html.Styled.Attributes.css rowStyles
            :: List.concatMap Ui.Attr.toAttributes attrs
        )
        [ child ]



-- INTERNALS


createNode :
    (List attr -> List html -> html)
    -> List attr
    -> List html
    -> html
createNode toNode attrs children =
    toNode attrs children


rowStyles : List Css.Style
rowStyles =
    [ Css.displayFlex ]


colStyles : List Css.Style
colStyles =
    [ Css.displayFlex
    , Css.flexDirection Css.column
    ]
