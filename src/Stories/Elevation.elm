module Stories.Elevation exposing (main)

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
    Ui.col [ Ui.Attr.gap.px16 ]
        [ Ui.Typography.h800 [] "Elevation"
        , Ui.row [ Ui.Attr.gap.px40 ]
            [ viewSquare "Elevation 1" [ Ui.Attr.elevation.level1 ]
            , viewSquare "Elevation 2" [ Ui.Attr.elevation.level2 ]
            , viewSquare "Elevation 3" [ Ui.Attr.elevation.level3 ]
            ]
        ]


viewSquare : String -> List (Ui.Attribute msg) -> Ui.Html msg
viewSquare label attrs =
    Ui.el
        (attrs
            ++ [ Ui.Attr.backgroundColor Ui.Palette.light
               , Ui.Attr.fontColor Ui.Palette.n700
               , Ui.Attr.width.px80
               , Ui.Attr.height.px80
               , Ui.Attr.radius.px4
               , Ui.Attr.align.center
               , Ui.Attr.textAlign.center
               ]
        )
        (Ui.Typography.p100 [] label)
