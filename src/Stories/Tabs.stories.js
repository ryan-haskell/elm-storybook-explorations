import { Elm } from './Tabs.elm'
import elmSource from './Tabs.elm?raw'
import { ElmComponent } from 'elm-storybook'

export default {
  title: 'Tabs',
  parameters: { elmSource },
  argTypes: { onAction: { action: 'Elm' } }
}

export const Tabs = (controls) =>
  ElmComponent.create(Elm.Stories.Tabs, controls)
