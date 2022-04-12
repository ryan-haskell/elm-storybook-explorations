module Stories.Dropdown exposing (main)

import Browser.Dom
import Layers
import Layers.Dropdown
import List.Extra
import Storybook.Component exposing (Component)
import Storybook.Controls
import Ui
import Ui.Attr
import Ui.Dropdown
import Ui.Typography


main : Component Model Msg
main =
    Storybook.Component.element
        { controls = Storybook.Controls.none
        , init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- INIT


type alias Model =
    { layers : Layers.Model Item
    , selected : Maybe Fruit
    , searchInputValue : String
    }


init : ( Model, Cmd Msg )
init =
    ( { layers = Layers.init
      , selected = Nothing
      , searchInputValue = ""
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = LayersSentMsg (Layers.Msg Item)
    | UserClickedSelect
    | UserClickedOption Fruit
    | UserChangedSearchInput String
    | UserPressedArrowUpOnSelect
    | UserPressedArrowDownOnSelect


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LayersSentMsg layersMsg ->
            Layers.update
                { model = model.layers
                , msg = layersMsg
                , toAppMsg = LayersSentMsg
                , toAppModel = \layers -> { model | layers = layers }
                }

        UserClickedSelect ->
            Layers.toggleMenu
                { item = DropdownMenu
                , model = model.layers
                , toAppMsg = LayersSentMsg
                , toAppModel = \layers -> { model | layers = layers }
                }

        UserClickedOption fruit ->
            ( { model | selected = Just fruit }
            , Cmd.none
            )

        UserChangedSearchInput string ->
            ( { model | searchInputValue = string }
            , Cmd.none
            )

        UserPressedArrowUpOnSelect ->
            ( { model | selected = previous model.selected }
            , Cmd.none
            )

        UserPressedArrowDownOnSelect ->
            ( { model | selected = next model.selected }
            , Cmd.none
            )


previous : Maybe Fruit -> Maybe Fruit
previous maybe =
    case maybe of
        Just fruit ->
            List.Extra.elemIndex fruit fruits
                |> Maybe.map decrementIndex
                |> Maybe.andThen getItemAtIndex

        Nothing ->
            getItemAtIndex (List.length fruits - 1)


next : Maybe Fruit -> Maybe Fruit
next maybe =
    case maybe of
        Just fruit ->
            List.Extra.elemIndex fruit fruits
                |> Maybe.map incrementIndex
                |> Maybe.andThen getItemAtIndex

        Nothing ->
            getItemAtIndex 0


decrementIndex : Int -> Int
decrementIndex index =
    keepWithinBounds (index - 1)


incrementIndex : Int -> Int
incrementIndex index =
    keepWithinBounds (index + 1)


keepWithinBounds : Int -> Int
keepWithinBounds index =
    clamp 0 (List.length fruits - 1) index


getItemAtIndex : Int -> Maybe Fruit
getItemAtIndex index =
    List.Extra.getAt index fruits



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


type Fruit
    = Apple
    | Banana
    | Cherry


fruits : List Fruit
fruits =
    [ Apple
    , Banana
    , Cherry
    ]


fromFruitToLabel : Fruit -> String
fromFruitToLabel fruit =
    case fruit of
        Apple ->
            "Apple"

        Banana ->
            "Banana"

        Cherry ->
            "Cherry"


view : () -> Model -> Ui.Html Msg
view _ model =
    Layers.view
        { model = model.layers
        , toAppMsg = LayersSentMsg
        , viewAppLayer = viewAppLayer model
        , viewLayerItem = viewLayerItem model
        }


viewAppLayer : Model -> Ui.Html Msg
viewAppLayer model =
    Ui.col [ Ui.Attr.align.left ]
        [ Ui.Dropdown.view
            { placeholder = "Select fruit"
            , toLabel = fromFruitToLabel
            , buttonId = Layers.idForItem DropdownMenu model.layers
            , onSelectClicked = UserClickedSelect
            , onSelectArrowUp = UserPressedArrowUpOnSelect
            , onSelectArrowDown = UserPressedArrowDownOnSelect
            , selected = model.selected
            }
        , Ui.Typography.p200 [ Ui.Attr.relative ] "Hey I'm a paragraph, and I love blocking dropdown menus!!"
        ]



-- DROPDOWN MENUS


type Item
    = DropdownMenu


viewLayerItem : Model -> String -> Item -> Browser.Dom.Element -> Ui.Html Msg
viewLayerItem model id item parent =
    case item of
        DropdownMenu ->
            Layers.Dropdown.viewLeft parent
                (Ui.Dropdown.viewMenu
                    { menuId = id
                    , selected = model.selected
                    , toLabel = fromFruitToLabel
                    , items =
                        [ Ui.Dropdown.group "Fruits"
                        , Ui.Dropdown.item Apple
                        , Ui.Dropdown.item Banana
                        , Ui.Dropdown.item Cherry
                        ]
                    , searchInputValue = model.searchInputValue
                    , onOptionClicked = UserClickedOption
                    , onSearchInputChanged = UserChangedSearchInput
                    }
                )
