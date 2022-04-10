import { Elm } from "./Dropdown.elm"
import elmSource from "./Dropdown.elm?raw"
import { ElmComponent } from "elm-storybook"

export default {
  title: "Dropdown",
  parameters: { elmSource },
  argTypes: { onAction: { action: "Elm" } },
}

export const Dropdown = (controls) =>
  ElmComponent.create(Elm.Stories.Dropdown, controls)
