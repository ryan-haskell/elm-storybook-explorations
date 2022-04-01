import { Elm } from "./Elevation.elm"
import elmSource from "./Elevation.elm?raw"
import { ElmComponent } from "elm-storybook"

export default {
  title: "Elevation",
  parameters: { elmSource },
  argTypes: { onAction: { action: "Elm" } },
}

export const Elevation = (controls) =>
  ElmComponent.create(Elm.Stories.Elevation, controls)
