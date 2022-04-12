module Ui exposing
    ( Html, Attribute, toHtml
    , none, text
    , el, row, col
    , clickable
    , input, label
    , icon
    )

{-|

@docs Html, Attribute, toHtml
@docs none, text
@docs el, row, col
@docs clickable
@docs input, label
@docs icon

-}

import Css
import Css.Global
import Html
import Html.Styled
import Html.Styled.Attributes
import Html.Styled.Events
import Ui.Action
import Ui.Attr
import Ui.Icon


type alias Html msg =
    Html.Styled.Html msg


type alias Attribute msg =
    Ui.Attr.Attribute msg


toHtml : Html msg -> Html.Html msg
toHtml html =
    Html.Styled.toUnstyled (Html.Styled.div (Ui.Attr.toAttributes topLevelAttributes) [ globalCss, html ])


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
        , Css.Global.selector "::placeholder"
            [ Css.property "font" "inherit"
            , Css.color Css.inherit
            ]
        , Css.Global.input
            [ Css.width (Css.pct 100)
            ]

        -- Ui.col alignment
        , Css.Global.selector ".elm-col > *" [ Css.flexShrink Css.zero ]
        , Css.Global.selector ".elm-col.elm-align-left" [ Css.alignItems Css.flexStart ]
        , Css.Global.selector ".elm-col.elm-align-right" [ Css.alignItems Css.flexEnd ]
        , Css.Global.selector ".elm-col.elm-align-top" [ Css.justifyContent Css.flexStart ]
        , Css.Global.selector ".elm-col.elm-align-bottom" [ Css.justifyContent Css.flexEnd ]
        , Css.Global.selector ".elm-col.elm-align-center-x" [ Css.alignItems Css.center ]
        , Css.Global.selector ".elm-col.elm-align-center-y" [ Css.justifyContent Css.center ]

        -- Ui.row alignment
        , Css.Global.selector ".elm-row.elm-align-left" [ Css.justifyContent Css.flexStart ]
        , Css.Global.selector ".elm-row.elm-align-right" [ Css.justifyContent Css.flexEnd ]
        , Css.Global.selector ".elm-row.elm-align-top" [ Css.alignItems Css.flexStart ]
        , Css.Global.selector ".elm-row.elm-align-bottom" [ Css.alignItems Css.flexEnd ]
        , Css.Global.selector ".elm-row.elm-align-center-x" [ Css.justifyContent Css.center ]
        , Css.Global.selector ".elm-row.elm-align-center-y" [ Css.alignItems Css.center ]

        -- Ui.absolute alignment
        , Css.Global.class "elm-absolute" [ Css.position Css.absolute ]
        , Css.Global.selector ".elm-absolute.elm-align-left" [ Css.left Css.zero ]
        , Css.Global.selector ".elm-absolute.elm-align-right" [ Css.right Css.zero ]
        , Css.Global.selector ".elm-absolute.elm-align-top" [ Css.top Css.zero ]
        , Css.Global.selector ".elm-absolute.elm-align-bottom" [ Css.bottom Css.zero ]
        , Css.Global.selector ".elm-absolute.elm-align-toLeftOf" [ Css.right (Css.pct 100) ]
        , Css.Global.selector ".elm-absolute.elm-align-toRightOf" [ Css.left (Css.pct 100) ]
        , Css.Global.selector ".elm-absolute.elm-align-above" [ Css.bottom (Css.pct 100) ]
        , Css.Global.selector ".elm-absolute.elm-align-below" [ Css.top (Css.pct 100) ]
        , Css.Global.selector ".elm-absolute.elm-align-center-x"
            [ Css.left (Css.pct 50)
            , Css.transform (Css.translateX (Css.pct -50))
            ]
        , Css.Global.selector ".elm-absolute.elm-align-center-y"
            [ Css.top (Css.pct 50)
            , Css.transform (Css.translateY (Css.pct -50))
            ]

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
    rowWithTag Html.Styled.div attrs children


col : List (Attribute msg) -> List (Html msg) -> Html msg
col attrs children =
    createNode Html.Styled.div
        (Html.Styled.Attributes.class "elm-col"
            :: Html.Styled.Attributes.css colStyles
            :: Ui.Attr.toAttributes attrs
        )
        children


el : List (Attribute msg) -> Html msg -> Html msg
el attrs child =
    rowWithTag Html.Styled.div attrs [ child ]


absolute : List (Attribute msg) -> Html msg -> Html msg
absolute attrs child =
    rowWithTag Html.Styled.div (Ui.Attr.absolute :: attrs) [ child ]


label : List (Attribute msg) -> Html msg -> Html msg
label attrs child =
    rowWithTag Html.Styled.label attrs [ child ]


input :
    List (Attribute msg)
    ->
        { placeholder : String
        , value : String
        , onInput : String -> msg
        }
    -> Html msg
input attrs options =
    createNode Html.Styled.input
        (Html.Styled.Attributes.class "elm-row"
            :: Html.Styled.Attributes.css rowStyles
            :: Html.Styled.Attributes.placeholder options.placeholder
            :: Html.Styled.Events.onInput options.onInput
            :: Html.Styled.Attributes.value options.value
            :: Ui.Attr.toAttributes attrs
        )
        []


clickable : Ui.Action.Action msg -> List (Attribute msg) -> Html msg -> Html msg
clickable action attrs child =
    rowWithTag (Ui.Action.toHtmlNode action) attrs [ child ]



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
        , Html.Styled.Attributes.css [ Css.important (Css.fontSize (Css.px size)) ]
        ]
        []


rowWithTag :
    (List (Html.Styled.Attribute msg) -> List (Html.Styled.Html msg) -> Html.Styled.Html msg)
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
rowWithTag tag attrs children =
    createNode tag
        (Html.Styled.Attributes.class "elm-row"
            :: Html.Styled.Attributes.css rowStyles
            :: Ui.Attr.toAttributes attrs
        )
        children
