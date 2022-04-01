module Stories.Typography exposing (main)

import Storybook.Component exposing (Component)
import Storybook.Controls
import Ui
import Ui.Attr
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
    Ui.col [ Ui.Attr.align.left, Ui.Attr.gap.px16 ]
        [ Ui.Typography.h900 [] "Headline H-900"
        , Ui.Typography.h800 [] "Headline H-800"
        , Ui.Typography.h700 [] "Headline H-700"
        , Ui.Typography.h600 [] "Headline H-600"
        , Ui.Typography.h500 [] "Headline H-500"
        , Ui.Typography.h400 [] "Headline H-400"
        , Ui.Typography.h300 [] "Headline H-300"
        , Ui.Typography.h200 [] "Heading 200"
        , Ui.Typography.h100 [] "Heading 100"
        , Ui.Typography.p300 [] "Paragraph 300"
        , Ui.Typography.p200 [] "Paragraph 200"
        , Ui.Typography.p100 [] "Paragraph 100"
        , Ui.Typography.codeMinimal [] "Code minimal"
        , Ui.Typography.code [] "Code example"
        ]
