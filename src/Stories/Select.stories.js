import { Elm } from "./Select.elm"
import elmSource from "./Select.elm?raw"
import { ElmComponent } from "elm-storybook"

export default {
  title: "Select",
  parameters: { elmSource },
  argTypes: { onAction: { action: "Elm" } },
}

export const Select = (controls) =>
  ElmComponent.create(Elm.Stories.Select, controls)
