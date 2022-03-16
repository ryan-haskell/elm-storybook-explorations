import { Elm } from './Heading1.elm'
import elmSource from './Heading1.elm?raw'
import { ElmComponent } from 'elm-storybook'

export default {
  title: 'Typography',
  parameters: { elmSource },
  argTypes: {
    label: { control: { type: 'text' } }
  }
}

export const Heading1 = (controls) =>
  ElmComponent.create(Elm.Stories.Typography.Heading1, controls)