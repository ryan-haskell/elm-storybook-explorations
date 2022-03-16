import { Elm } from './Paragraph.elm'
import elmSource from './Paragraph.elm?raw'
import { ElmComponent } from 'elm-storybook'

export default {
  title: 'Typography',
  parameters: { elmSource },
  argTypes: {
    label: { control: { type: 'text' } }
  }
}

export const Paragraph = (controls) =>
  ElmComponent.create(Elm.Stories.Typography.Paragraph, controls)