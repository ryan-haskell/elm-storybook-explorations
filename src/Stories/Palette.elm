module Stories.Palette exposing (main)

import Storybook.Component exposing (Component)
import Storybook.Controls
import Ui
import Ui.Attr
import Ui.Palette exposing (..)
import Ui.Typography


main : Component () msg
main =
    Storybook.Component.stateless
        { controls = Storybook.Controls.none
        , view = view
        }



-- VIEW


view : () -> Ui.Html msg
view _ =
    Ui.col [ Ui.Attr.gap.px32 ] (List.map viewSection sections)


type alias Section =
    { title : String, colors : List Ui.Palette.Color }


sections : List Section
sections =
    [ { title = "Primary", colors = [ blue, dark, light ] }
    , { title = "Secondary", colors = [ green, yellow, red, violet, teal, pink, orange ] }
    , { title = "Extended Neutral", colors = [ n900, n800, n700, n600, n500, n400, n300, n200, n100, n75, n50, n0 ] }
    , { title = "Extended Blue", colors = [ b600, b500, b400, b300, b200, b100, b50 ] }
    , { title = "Extended Green", colors = [ g600, g500, g400, g300, g200, g100, g50 ] }
    , { title = "Extended Yellow", colors = [ y600, y500, y400, y300, y200, y100, y50 ] }
    , { title = "Extended Red", colors = [ r600, r500, r400, r300, r200, r100, r50 ] }
    , { title = "Extended Violet", colors = [ v600, v500, v400, v300, v200, v100, v50 ] }
    , { title = "Extended Teal", colors = [ t600, t500, t400, t300, t200, t100, t50 ] }
    , { title = "Extended Pink", colors = [ p600, p500, p400, p300, p200, p100, p50 ] }
    , { title = "Extended Orange", colors = [ o600, o500, o400, o300, o200, o100, o50 ] }
    , { title = "Chart Colors", colors = chartColors }
    ]


viewSection : Section -> Ui.Html msg
viewSection section =
    Ui.col [ Ui.Attr.gap.px8 ]
        [ Ui.Typography.h800 [] section.title
        , Ui.row [ Ui.Attr.gap.px8 ]
            (List.map viewSquare section.colors)
        ]


viewSquare : Ui.Palette.Color -> Ui.Html msg
viewSquare color =
    Ui.el
        [ Ui.Attr.backgroundColor color
        , if color == Ui.Palette.n0 then
            Ui.Attr.border.px1 Ui.Palette.n400

          else
            Ui.Attr.none
        , Ui.Attr.radius.px4
        , Ui.Attr.width.px80
        , Ui.Attr.height.px80
        ]
        Ui.none
