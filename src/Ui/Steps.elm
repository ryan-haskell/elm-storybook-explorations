module Ui.Steps exposing (view)

import List.Extra
import Ui
import Ui.Attr
import Ui.Icon
import Ui.Palette
import Ui.Typography


view :
    { steps : List step
    , toLabel : step -> String
    , current : step
    }
    -> Ui.Html msg
view options =
    let
        indexOfTheCurrentStep : Maybe Int
        indexOfTheCurrentStep =
            List.Extra.elemIndex options.current options.steps

        viewStep : Int -> step -> Ui.Html msg
        viewStep index step =
            let
                stepNumber : String
                stepNumber =
                    String.fromInt (index + 1)

                viewBadge : Ui.Html msg
                viewBadge =
                    case indexOfTheCurrentStep of
                        Just currentIndex ->
                            if currentIndex > index then
                                viewTickBadge

                            else if currentIndex == index then
                                viewBlueBadge stepNumber

                            else
                                viewNeutralBadge stepNumber

                        Nothing ->
                            viewNeutralBadge stepNumber
            in
            Ui.row [ Ui.Attr.align.top, Ui.Attr.gap.px4 ]
                [ viewBadge
                , Ui.Typography.h300
                    [ if indexOfTheCurrentStep == Just index then
                        Ui.Attr.fontColor Ui.Palette.b400

                      else
                        Ui.Attr.fontColor Ui.Palette.n700
                    ]
                    (options.toLabel step)
                ]
    in
    Ui.row [ Ui.Attr.gap.px24 ]
        (List.indexedMap viewStep options.steps)



-- VIEWING ICONS


viewTickBadge : Ui.Html msg
viewTickBadge =
    viewBadgeWith
        { fontColor = Ui.Palette.g400
        , backgroundColor = Ui.Palette.g200
        , content = Ui.icon.px12 Ui.Icon.tick
        }


viewBlueBadge : String -> Ui.Html msg
viewBlueBadge label =
    viewBadgeWith
        { fontColor = Ui.Palette.b500
        , backgroundColor = Ui.Palette.b200
        , content = Ui.Typography.h150 [ Ui.Attr.inherit.fontColor ] label
        }


viewNeutralBadge : String -> Ui.Html msg
viewNeutralBadge label =
    viewBadgeWith
        { fontColor = Ui.Palette.n700
        , backgroundColor = Ui.Palette.n200
        , content = Ui.Typography.h150 [ Ui.Attr.inherit.fontColor ] label
        }


viewBadgeWith :
    { content : Ui.Html msg
    , fontColor : Ui.Palette.Color
    , backgroundColor : Ui.Palette.Color
    }
    -> Ui.Html msg
viewBadgeWith options =
    Ui.el
        [ Ui.Attr.width.px16
        , Ui.Attr.height.px16
        , Ui.Attr.align.center
        , Ui.Attr.radius.px4
        , Ui.Attr.fontColor options.fontColor
        , Ui.Attr.backgroundColor options.backgroundColor
        ]
        options.content
