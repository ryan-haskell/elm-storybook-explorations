import { Elm } from './Heading3.elm'
import elmSource from './Heading3.elm?raw'
import { ElmComponent } from 'elm-storybook'

export default {
  title: 'Typography',
  parameters: { elmSource },
  argTypes: {
    label: { control: { type: 'text' } }
  }
}

export const Heading3 = (controls) =>
  ElmComponent.create(Elm.Stories.Typography.Heading3, controls)