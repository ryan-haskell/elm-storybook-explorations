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
    = Apple
    | Banana
    | Cherry



-- INIT


type alias Model =
    { selected : Tab
    }


init : Model
init =
    { selected = Apple
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


view : () -> Model -> Html Msg
view controls model =
    Ui.Tabs.view
        { selected = model.selected
        , tabs = [ Apple, Banana, Cherry ]
        , onTabClicked = UserClickedTab
        , toTabLabel = toTabLabel
        , viewTabContent = viewTabContent
        }


toTabLabel : Tab -> String
toTabLabel tab =
    case tab of
        Apple ->
            "Apple"

        Banana ->
            "Banana"

        Cherry ->
            "Cherry"


viewTabContent : Tab -> Html Msg
viewTabContent tab =
    Ui.Typography.markdown
        (String.join "\n\n"
            [ "This is content for the __" ++ toTabLabel tab ++ "__ tab!"
            , "If you click a different tab above, you will see the previous paragraph change it's message."
            ]
        )
