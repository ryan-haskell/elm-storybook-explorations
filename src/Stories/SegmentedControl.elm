module Stories.SegmentedControl exposing (main)

import Storybook.Component exposing (Component)
import Storybook.Controls
import Ui
import Ui.Attr
import Ui.Pill
import Ui.SegmentedControl
import Ui.Status


main : Component Model Msg
main =
    Storybook.Component.sandbox
        { controls =
            Storybook.Controls.new Controls
                |> Storybook.Controls.withBool
                    { name = "isDisabled"
                    , fallback = False
                    }
        , init = init
        , update = update
        , view = view
        }



-- CONTROLS


type alias Controls =
    { isDisabled : Bool
    }



-- INIT


type alias Model =
    { selected : Tab
    , selectedTabForPillsExample : Tab
    , selectedTabForStatusesExample : Tab
    }


type Tab
    = Tab1
    | Tab2
    | Tab3


init : Model
init =
    { selected = Tab1
    , selectedTabForPillsExample = Tab1
    , selectedTabForStatusesExample = Tab1
    }



-- UPDATE


type Msg
    = UserClickedTab Tab
    | UserClickedTabWithPills Tab
    | UserClickedTabWithStatuses Tab


update : Msg -> Model -> Model
update msg model =
    case msg of
        UserClickedTab tab ->
            { model | selected = tab }

        UserClickedTabWithPills tab ->
            { model | selectedTabForPillsExample = tab }

        UserClickedTabWithStatuses tab ->
            { model | selectedTabForStatusesExample = tab }



-- VIEW


view : Controls -> Model -> Ui.Html Msg
view controls model =
    Ui.col
        [ Ui.Attr.align.left
        , Ui.Attr.gap.px40
        ]
        [ Ui.SegmentedControl.view
            { tabs = [ Tab1, Tab2, Tab3 ]
            , selected = model.selected
            , onClick = UserClickedTab
            , isDisabled = controls.isDisabled
            , toLabel = fromTabToLabel
            }
        , Ui.SegmentedControl.viewWithPills
            { tabs = [ Tab1, Tab2, Tab3 ]
            , selected = model.selectedTabForPillsExample
            , onClick = UserClickedTabWithPills
            , isDisabled = controls.isDisabled
            , toLabel = fromTabToLabel
            , toPill = fromTabToPill
            , toPillValue = fromTabToPillValue
            }
        , Ui.SegmentedControl.viewWithStatuses
            { tabs = [ Tab1, Tab2 ]
            , selected = model.selectedTabForStatusesExample
            , onClick = UserClickedTabWithStatuses
            , isDisabled = controls.isDisabled
            , toLabel = fromTabToLabel
            , toStatus = fromTabToStatus
            }
        ]



-- TABS


fromTabToLabel : Tab -> String
fromTabToLabel tab =
    case tab of
        Tab1 ->
            "Tab 1"

        Tab2 ->
            "Tab 2"

        Tab3 ->
            "Tab 3"


fromTabToPill : Tab -> String -> Ui.Pill.Pill
fromTabToPill tab label =
    case tab of
        Tab1 ->
            Ui.Pill.blue label

        Tab2 ->
            Ui.Pill.blue label

        Tab3 ->
            Ui.Pill.red label


fromTabToPillValue : Tab -> String
fromTabToPillValue tab =
    "6"


fromTabToStatus : Tab -> String -> Ui.Status.Status
fromTabToStatus tab =
    case tab of
        Tab1 ->
            Ui.Status.green

        Tab2 ->
            Ui.Status.red

        Tab3 ->
            Ui.Status.red
