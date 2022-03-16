import { Elm } from './Danger.elm'
import elmSource from './Danger.elm?raw'
import { ElmComponent } from 'elm-storybook'

export default {
  title: 'Button',
  parameters: { elmSource },
  argTypes: {
    label: { control: { type: 'text' } },
    onAction: { action: 'Elm' }
  }
}

export const Danger = (controls) =>
  ElmComponent.create(Elm.Stories.Button.Danger, controls)