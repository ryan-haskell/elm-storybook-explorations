module Stories.Elevation exposing (main)

import Storybook.Component exposing (Component)
import Storybook.Controls
import Ui
import Ui.Attr
import Ui.Palette exposing (..)


main : Component () msg
main =
    Storybook.Component.stateless
        { controls = Storybook.Controls.none
        , view = view
        }



-- VIEW


view : () -> Ui.Html msg
view _ =
    Ui.row [ Ui.Attr.gap.px32 ]
        [ viewSquare []
        , viewSquare [ Ui.Attr.elevation.level1 ]
        , viewSquare [ Ui.Attr.elevation.level2 ]
        , viewSquare [ Ui.Attr.elevation.level3 ]
        ]


viewSquare : List (Ui.Attribute msg) -> Ui.Html msg
viewSquare attrs =
    Ui.el
        (attrs
            ++ [ Ui.Attr.backgroundColor Ui.Palette.light
               , Ui.Attr.width.px80
               , Ui.Attr.height.px80
               , Ui.Attr.radius.px4
               , Ui.Attr.border.px1 Ui.Palette.n200
               ]
        )
        Ui.none
