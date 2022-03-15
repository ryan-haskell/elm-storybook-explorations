module Stories.Tabs exposing (main)

import Html exposing (Html)
import Json.Encode
import Storybook.Component exposing (Component)
import Storybook.Controls
import Ui.Button
import Ui.Tabs
import Ui.Typography


main : Component Model Msg
main =
    Storybook.Component.sandbox
        { controls = Storybook.Controls.none
        , init = init
        , update = update
        , view = view
        }



-- TABS


type Tab
    = Primary
    | Secondary
    | Danger


toTabLabel : Tab -> String
toTabLabel tab =
    case tab of
        Primary ->
            "Primary"

        Secondary ->
            "Secondary"

        Danger ->
            "Danger"


viewTabContent : Tab -> Html msg
viewTabContent tab =
    Ui.Typography.markdown
        ("This is content for the __" ++ toTabLabel tab ++ "__ tab! \n\nIf you click a different tab above, you will see the previous paragraph change it's message.")



-- INIT


type alias Model =
    { selected : Tab
    }


init : Model
init =
    { selected = Primary
    }



-- UPDATE


type Msg
    = UserClickedTab Tab


update : Msg -> Model -> Model
update msg model =
    case msg of
        UserClickedTab tab ->
            { model | selected = tab }



-- VIEW


view : {} -> Model -> Html (Storybook.Component.Msg Msg)
view controls model =
    let
        onTabClicked : Tab -> Storybook.Component.Msg Msg
        onTabClicked tab =
            Storybook.Component.sendMessageAndLogAction
                { msg = UserClickedTab tab
                , action =
                    { name = "onTabClicked"
                    , payload = Json.Encode.string (toTabLabel tab)
                    }
                }
    in
    Ui.Tabs.view
        { selected = model.selected
        , tabs = [ Primary, Secondary, Danger ]
        , onTabClicked = onTabClicked
        , toTabLabel = toTabLabel
        , viewTabContent = viewTabContent
        }
