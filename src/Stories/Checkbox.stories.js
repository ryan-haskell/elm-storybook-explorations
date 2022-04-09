import { Elm } from "./Checkbox.elm"
import elmSource from "./Checkbox.elm?raw"
import { ElmComponent } from "elm-storybook"

export default {
  title: "Checkbox",
  parameters: { elmSource },
  argTypes: {
    isDisabled: { control: 'boolean' },
    onAction: { action: "Elm" }
  },
}

export const Checkbox = (controls) =>
  ElmComponent.create(Elm.Stories.Checkbox, controls)
