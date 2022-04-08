import { Elm } from "./Pill.elm"
import elmSource from "./Pill.elm?raw"
import { ElmComponent } from "elm-storybook"

export default {
  title: "Pill",
  parameters: { elmSource },
  argTypes: { onAction: { action: "Elm" } },
}

export const Pill = (controls) =>
  ElmComponent.create(Elm.Stories.Pill, controls)
