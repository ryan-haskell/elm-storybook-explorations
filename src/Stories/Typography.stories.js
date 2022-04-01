import { Elm } from "./Typography.elm"
import elmSource from "./Typography.elm?raw"
import { ElmComponent } from "elm-storybook"

export default {
  title: "Typography",
  parameters: { elmSource },
  argTypes: { onAction: { action: "Elm" } },
}

export const Typography = (controls) =>
  ElmComponent.create(Elm.Stories.Typography, controls)
