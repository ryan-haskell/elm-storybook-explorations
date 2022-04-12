module Stories.Select exposing (main)

import Storybook.Component exposing (Component)
import Storybook.Controls
import Ui
import Ui.Attr
import Ui.Select


main : Component () Msg
main =
    Storybook.Component.stateless
        { controls = Storybook.Controls.none
        , view = view
        }


type Msg
    = UserClickedSelect
    | UserPressedArrowUp
    | UserPressedArrowDown



-- VIEW


view : () -> Ui.Html Msg
view _ =
    Ui.row
        [ Ui.Attr.gap.px40
        ]
        [ Ui.col [ Ui.Attr.gap.px16 ]
            [ Ui.Select.view
                { placeholder = "Select a fruit"
                , value = Nothing
                , error = Nothing
                , buttonId = Nothing
                , onClick = UserClickedSelect
                , onArrowUp = UserPressedArrowUp
                , onArrowDown = UserPressedArrowDown
                , isDisabled = False
                }
            , Ui.Select.view
                { placeholder = "Select a fruit"
                , value = Just "Apples"
                , error = Nothing
                , buttonId = Nothing
                , onClick = UserClickedSelect
                , onArrowUp = UserPressedArrowUp
                , onArrowDown = UserPressedArrowDown
                , isDisabled = False
                }
            , Ui.Select.view
                { placeholder = "Select a fruit"
                , value = Just "Apples"
                , error = Just "Something went wrong."
                , buttonId = Nothing
                , onClick = UserClickedSelect
                , onArrowUp = UserPressedArrowUp
                , onArrowDown = UserPressedArrowDown
                , isDisabled = False
                }
            ]
        , Ui.col [ Ui.Attr.gap.px16 ]
            [ Ui.Select.view
                { placeholder = "Select a fruit"
                , value = Nothing
                , error = Nothing
                , buttonId = Nothing
                , onClick = UserClickedSelect
                , onArrowUp = UserPressedArrowUp
                , onArrowDown = UserPressedArrowDown
                , isDisabled = True
                }
            , Ui.Select.view
                { placeholder = "Select a fruit"
                , value = Just "Apples"
                , error = Nothing
                , buttonId = Nothing
                , onClick = UserClickedSelect
                , onArrowUp = UserPressedArrowUp
                , onArrowDown = UserPressedArrowDown
                , isDisabled = True
                }
            , Ui.Select.view
                { placeholder = "Select a fruit"
                , value = Nothing
                , error = Just "Something went wrong."
                , buttonId = Nothing
                , onClick = UserClickedSelect
                , onArrowUp = UserPressedArrowUp
                , onArrowDown = UserPressedArrowDown
                , isDisabled = True
                }
            ]
        ]
