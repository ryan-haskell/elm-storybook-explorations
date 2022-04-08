module Stories.Card exposing (main)

import Storybook.Component exposing (Component)
import Storybook.Controls
import Ui
import Ui.Action
import Ui.Attr
import Ui.Card
import Ui.Palette exposing (..)
import Ui.Typography


main : Component () Msg
main =
    Storybook.Component.stateless
        { controls = Storybook.Controls.none
        , view = view
        }



-- VIEW


type Msg
    = UserClickedCard


view : () -> Ui.Html Msg
view _ =
    Ui.col [ Ui.Attr.gap.px40 ]
        [ Ui.col [ Ui.Attr.gap.px16, Ui.Attr.align.left ]
            [ Ui.Typography.h900 [] "Card"
            , Ui.Card.view []
                (Ui.Action.fromMsg UserClickedCard)
                Ui.none
            ]
        , Ui.col [ Ui.Attr.gap.px16 ]
            [ Ui.Typography.h800 [] "All interaction states"
            , Ui.row [ Ui.Attr.gap.px40 ]
                (List.map viewExample examples)
            ]
        ]


type alias Example msg =
    { label : String
    , view : Ui.Html msg
    }


examples : List (Example Msg)
examples =
    [ { label = "Enabled"
      , view = Ui.Card.view [ Ui.Card.alwaysEnabled ] (Ui.Action.fromMsg UserClickedCard) Ui.none
      }
    , { label = "Focused"
      , view = Ui.Card.view [ Ui.Card.alwaysFocused ] (Ui.Action.fromMsg UserClickedCard) Ui.none
      }
    , { label = "Hovered"
      , view = Ui.Card.view [ Ui.Card.alwaysHovered ] (Ui.Action.fromMsg UserClickedCard) Ui.none
      }
    , { label = "Disabled"
      , view = Ui.Card.view [ Ui.Card.alwaysDisabled ] (Ui.Action.fromMsg UserClickedCard) Ui.none
      }
    ]


viewExample : Example msg -> Ui.Html msg
viewExample example =
    Ui.col [ Ui.Attr.gap.px8 ]
        [ Ui.Typography.p200 [] example.label
        , example.view
        ]
