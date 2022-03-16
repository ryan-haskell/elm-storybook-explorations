import { Elm } from './Primary.elm'
import elmSource from './Primary.elm?raw'
import { ElmComponent } from 'elm-storybook'

export default {
  title: 'Button',
  parameters: { elmSource },
  argTypes: {
    label: { control: { type: 'text' } },
    onAction: { action: 'Elm' }
  }
}

export const Primary = (controls) =>
  ElmComponent.create(Elm.Stories.Button.Primary, controls)