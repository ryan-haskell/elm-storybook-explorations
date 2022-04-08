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
import Ui.Action
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
            , Css.color Css.inherit
            ]
        , Css.Global.body
            [ Css.fontFamilies [ "Inter", "sans-serif" ]
            , Css.lineHeight (Css.int 1)
            ]

        -- Ui.col flex align properties
        , Css.Global.selector ".elm-col.elm-align-left" [ Css.alignItems Css.flexStart ]
        , Css.Global.selector ".elm-col.elm-align-right" [ Css.alignItems Css.flexEnd ]
        , Css.Global.selector ".elm-col.elm-align-top" [ Css.justifyContent Css.flexStart ]
        , Css.Global.selector ".elm-col.elm-align-bottom" [ Css.justifyContent Css.flexEnd ]
        , Css.Global.selector ".elm-col.elm-align-center-x" [ Css.alignItems Css.center ]
        , Css.Global.selector ".elm-col.elm-align-center-y" [ Css.justifyContent Css.center ]

        -- Ui.row flex align properties
        , Css.Global.selector ".elm-row.elm-align-left" [ Css.justifyContent Css.flexStart ]
        , Css.Global.selector ".elm-row.elm-align-right" [ Css.justifyContent Css.flexEnd ]
        , Css.Global.selector ".elm-row.elm-align-top" [ Css.alignItems Css.flexStart ]
        , Css.Global.selector ".elm-row.elm-align-bottom" [ Css.alignItems Css.flexEnd ]
        , Css.Global.selector ".elm-row.elm-align-center-x" [ Css.justifyContent Css.center ]
        , Css.Global.selector ".elm-row.elm-align-center-y" [ Css.alignItems Css.center ]

        -- Refs allow for design edge cases where using normal CSS would be easier.
        -- I am very afraid of these being abused, so please add refs with caution!
        -- There is likely a nicer solution here, but I haven't come up with a
        -- clear API that would support edge cases like these yet...
        --
        -- ( All refs must be captured in one place: `Ui.Attr.ref` )
        --
        -- EDGE CASE 1: Changing an icon's color when a button is hovered/pressed/focused.
        , Css.Global.selector "[ref=button]:hover [ref=icon]" [ Css.color Css.inherit ]
        , Css.Global.selector "[ref=button]:active [ref=icon]" [ Css.color Css.inherit ]
        , Css.Global.selector "[ref=button]:focus [ref=icon]" [ Css.color Css.inherit ]
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


icon :
    { px12 : Ui.Icon.Icon -> Html msg
    , px16 : Ui.Icon.Icon -> Html msg
    }
icon =
    { px12 = toIcon 12
    , px16 = toIcon 16
    }



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


clickable : Ui.Action.Action msg -> List (Attribute msg) -> Html msg -> Html msg
clickable action attrs child =
    createNode (Ui.Action.toHtmlNode action)
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


toIcon : Float -> Ui.Icon.Icon -> Html.Styled.Html msg
toIcon size icon_ =
    Html.Styled.span
        [ Html.Styled.Attributes.class (Ui.Icon.toClassName icon_)
        , Html.Styled.Attributes.css [ Css.fontSize (Css.px size) ]
        ]
        []
