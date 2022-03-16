import { Elm } from './Secondary.elm'
import elmSource from './Secondary.elm?raw'
import { ElmComponent } from 'elm-storybook'

export default {
  title: 'Button',
  parameters: { elmSource },
  argTypes: {
    label: { control: { type: 'text' } },
    onAction: { action: 'Elm' }
  }
}

export const Secondary = (controls) =>
  ElmComponent.create(Elm.Stories.Button.Secondary, controls)