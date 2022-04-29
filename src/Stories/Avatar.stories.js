import { Elm } from "./Avatar.elm"
import elmSource from "./Avatar.elm?raw"
import { ElmComponent } from "elm-storybook"

export default {
  title: "Avatar",
  parameters: { elmSource },
  argTypes: { onAction: { action: "Elm" } },
}

export const Avatar = (controls) =>
  ElmComponent.create(Elm.Stories.Avatar, controls)
