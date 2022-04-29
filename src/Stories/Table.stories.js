import { Elm } from "./Table.elm"
import elmSource from "./Table.elm?raw"
import { ElmComponent } from "elm-storybook"

export default {
  title: "Table",
  parameters: { elmSource },
  argTypes: { onAction: { action: "Elm" } },
}

export const Table = (controls) =>
  ElmComponent.create(Elm.Stories.Table, controls)
