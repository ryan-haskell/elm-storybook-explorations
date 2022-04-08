module Ui.SegmentedControl exposing (..)

{-|

@docs view
@docs viewWithPills
@docs viewWithStatus

-}

import Ui
import Ui.Action
import Ui.Attr
import Ui.Palette
import Ui.Pill
import Ui.Status
import Ui.Typography
import Util.List


view :
    { tabs : List tab
    , selected : tab
    , onClick : tab -> msg
    , isDisabled : Bool
    , toLabel : tab -> String
    }
    -> Ui.Html msg
view options =
    viewHelper
        { tabs = options.tabs
        , selected = options.selected
        , onClick = options.onClick
        , isDisabled = options.isDisabled
        , mode = LabelOnly { toLabel = options.toLabel }
        }


viewWithPills :
    { tabs : List tab
    , selected : tab
    , onClick : tab -> msg
    , isDisabled : Bool
    , toLabel : tab -> String
    , toPill : tab -> String -> Ui.Pill.Pill
    , toPillValue : tab -> String
    }
    -> Ui.Html msg
viewWithPills options =
    viewHelper
        { tabs = options.tabs
        , selected = options.selected
        , onClick = options.onClick
        , isDisabled = options.isDisabled
        , mode =
            LabelWithPills
                { toLabel = options.toLabel
                , toPill = options.toPill
                , toPillValue = options.toPillValue
                }
        }


viewWithStatuses :
    { tabs : List tab
    , selected : tab
    , onClick : tab -> msg
    , isDisabled : Bool
    , toLabel : tab -> String
    , toStatus : tab -> String -> Ui.Status.Status
    }
    -> Ui.Html msg
viewWithStatuses options =
    viewHelper
        { tabs = options.tabs
        , selected = options.selected
        , onClick = options.onClick
        , isDisabled = options.isDisabled
        , mode =
            LabelWithStatus
                { toLabel = options.toLabel
                , toStatus = options.toStatus
                }
        }



-- INTERNALS


type Mode tab
    = LabelOnly
        { toLabel : tab -> String
        }
    | LabelWithPills
        { toLabel : tab -> String
        , toPill : tab -> String -> Ui.Pill.Pill
        , toPillValue : tab -> String
        }
    | LabelWithStatus
        { toLabel : tab -> String
        , toStatus : tab -> String -> Ui.Status.Status
        }


viewHelper :
    { tabs : List tab
    , selected : tab
    , mode : Mode tab
    , onClick : tab -> msg
    , isDisabled : Bool
    }
    -> Ui.Html msg
viewHelper options =
    let
        action tab =
            Ui.Action.fromMsg (options.onClick tab)

        fontColorWhenUnselected : tab -> Ui.Palette.Color -> Ui.Attr.Attribute msg
        fontColorWhenUnselected tab inactiveFontColor =
            if tab == options.selected then
                Ui.Attr.fontColor Ui.Palette.b400

            else
                Ui.Attr.fontColor inactiveFontColor

        viewTab : { isFirst : Bool, isLast : Bool } -> tab -> Ui.Html msg
        viewTab position tab =
            Ui.clickable (action tab)
                [ Ui.Attr.padXY.px16.px8
                , if tab == options.selected then
                    Ui.Attr.backgroundColor Ui.Palette.b50

                  else
                    Ui.Attr.backgroundColor Ui.Palette.n0
                , fontColorWhenUnselected tab Ui.Palette.n700
                , Ui.Attr.border.px1 Ui.Palette.n400
                , Ui.Attr.cursor.pointer
                , if position.isFirst then
                    Ui.Attr.radius.left.px4

                  else
                    Ui.Attr.none
                , if position.isLast then
                    Ui.Attr.radius.right.px4

                  else
                    Ui.Attr.none
                , Ui.Attr.isDisabled options.isDisabled
                , Ui.Attr.whenHovered
                    [ Ui.Attr.backgroundColor Ui.Palette.n100
                    , fontColorWhenUnselected tab Ui.Palette.n800
                    ]
                , Ui.Attr.whenPressed
                    [ Ui.Attr.backgroundColor Ui.Palette.n200
                    , fontColorWhenUnselected tab Ui.Palette.n800
                    ]
                , Ui.Attr.whenFocused
                    [ fontColorWhenUnselected tab Ui.Palette.n700
                    , Ui.Attr.outline.px2 Ui.Palette.b200
                    ]
                , Ui.Attr.whenDisabled
                    [ Ui.Attr.cursor.disabled
                    , Ui.Attr.fontColor Ui.Palette.n500
                    , if tab == options.selected then
                        Ui.Attr.backgroundColor Ui.Palette.b50

                      else
                        Ui.Attr.backgroundColor Ui.Palette.n0
                    ]
                ]
                (viewContent tab)

        labelAttributes : List (Ui.Attr.Attribute msg)
        labelAttributes =
            [ Ui.Attr.inherit.fontColor ]

        viewContent : tab -> Ui.Html msg
        viewContent tab =
            case options.mode of
                LabelOnly { toLabel } ->
                    Ui.Typography.h300 labelAttributes
                        (toLabel tab)

                LabelWithPills { toLabel, toPill, toPillValue } ->
                    Ui.row [ Ui.Attr.gap.px8 ]
                        [ Ui.Typography.h300 labelAttributes
                            (toLabel tab)
                        , Ui.Pill.view
                            (if options.isDisabled then
                                Ui.Pill.disabled (toPillValue tab)

                             else
                                toPill tab (toPillValue tab)
                            )
                        ]

                LabelWithStatus { toLabel, toStatus } ->
                    Ui.Status.viewH300 labelAttributes
                        (if options.isDisabled then
                            Ui.Status.disabled (toLabel tab)

                         else
                            toStatus tab (toLabel tab)
                        )
    in
    Ui.row [] (Util.List.mapWithPositionInfo viewTab options.tabs)
