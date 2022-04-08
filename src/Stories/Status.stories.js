import { Elm } from "./Status.elm"
import elmSource from "./Status.elm?raw"
import { ElmComponent } from "elm-storybook"

export default {
  title: "Status",
  parameters: { elmSource },
  argTypes: { onAction: { action: "Elm" } },
}

export const Status = (controls) =>
  ElmComponent.create(Elm.Stories.Status, controls)
