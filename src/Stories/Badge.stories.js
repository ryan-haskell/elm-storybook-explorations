import { Elm } from "./Badge.elm"
import elmSource from "./Badge.elm?raw"
import { ElmComponent } from "elm-storybook"

export default {
  title: "Badge",
  parameters: { elmSource },
  argTypes: { onAction: { action: "Elm" } },
}

export const Badge = (controls) =>
  ElmComponent.create(Elm.Stories.Badge, controls)
