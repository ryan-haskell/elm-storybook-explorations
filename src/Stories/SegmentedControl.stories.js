import { Elm } from "./SegmentedControl.elm"
import elmSource from "./SegmentedControl.elm?raw"
import { ElmComponent } from "elm-storybook"

export default {
  title: "Segmented Control",
  parameters: { elmSource },
  argTypes: {
    isDisabled: { control: 'boolean' },
    onAction: { action: "Elm" }
  },
}

export const SegmentedControl = (controls) =>
  ElmComponent.create(Elm.Stories.SegmentedControl, controls)
