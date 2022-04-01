import { Elm } from "./Card.elm"
import elmSource from "./Card.elm?raw"
import { ElmComponent } from "elm-storybook"

export default {
  title: "Card",
  parameters: { elmSource },
  argTypes: { onAction: { action: "Elm" } },
}

export const Card = (controls) =>
  ElmComponent.create(Elm.Stories.Card, controls)
