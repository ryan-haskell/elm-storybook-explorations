import { Elm } from "./Palette.elm"
import elmSource from "./Palette.elm?raw"
import { ElmComponent } from "elm-storybook"

export default {
  title: "Palette",
  parameters: { elmSource },
  argTypes: { onAction: { action: "Elm" } },
}

export const Palette = (controls) =>
  ElmComponent.create(Elm.Stories.Palette, controls)
