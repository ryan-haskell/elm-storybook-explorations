import { Elm } from './Tabs.elm'
import { ElmComponent } from 'elm-storybook'

export default {
  title: 'Ui.Tabs',
  parameters: {
    layout: 'centered',
    controls: { hideNoControlsWarning: true }
  },
  argTypes: {
    onAction: { action: 'Elm' }
  }
}

export const Tabs = (controls) =>
  ElmComponent.create(Elm.Stories.Tabs, controls)

Tabs.storyName = 'Ui.Tabs'