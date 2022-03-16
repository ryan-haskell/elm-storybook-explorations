import { Elm } from './Heading2.elm'
import elmSource from './Heading2.elm?raw'
import { ElmComponent } from 'elm-storybook'

export default {
  title: 'Typography',
  parameters: { elmSource },
  argTypes: {
    label: { control: { type: 'text' } }
  }
}

export const Heading2 = (controls) =>
  ElmComponent.create(Elm.Stories.Typography.Heading2, controls)