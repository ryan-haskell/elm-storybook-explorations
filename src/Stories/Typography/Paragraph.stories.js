import { Elm } from './Paragraph.elm'
import { ElmComponent } from 'elm-storybook'

export default {
  title: 'Ui.Typography',
  parameters: { layout: 'centered' },
  argTypes: {
    label: { control: { type: 'text' } }
  }
}

export const Paragraph = (controls) =>
  ElmComponent.create(Elm.Stories.Typography.Paragraph, controls)