import { Elm } from "./Steps.elm"
import elmSource from "./Steps.elm?raw"
import { ElmComponent } from "elm-storybook"

export default {
  title: "Steps",
  parameters: { elmSource },
  argTypes: { onAction: { action: "Elm" } },
}

export const Steps = (controls) =>
  ElmComponent.create(Elm.Stories.Steps, controls)
