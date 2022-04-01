import { Elm } from "./Button.elm"
import elmSource from "./Button.elm?raw"
import { ElmComponent } from "elm-storybook"

export default {
  title: "Button",
  parameters: { elmSource },
  argTypes: { onAction: { action: "Elm" } },
}

export const Button = (controls) =>
  ElmComponent.create(Elm.Stories.Button, controls)
