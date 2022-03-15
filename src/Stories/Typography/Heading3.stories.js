import { Elm } from './Heading3.elm'
import { ElmComponent } from 'elm-storybook'

export default {
  title: 'Ui.Typography',
  parameters: { layout: 'centered' },
  argTypes: {
    label: { control: { type: 'text' } }
  }
}

export const Heading3 = (controls) =>
  ElmComponent.create(Elm.Stories.Typography.Heading3, controls)