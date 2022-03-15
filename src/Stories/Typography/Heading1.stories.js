import { Elm } from './Heading1.elm'
import { ElmComponent } from 'elm-storybook'

export default {
  title: 'Ui.Typography',
  parameters: { layout: 'centered' },
  argTypes: {
    label: { control: { type: 'text' } }
  }
}

export const Heading1 = (controls) =>
  ElmComponent.create(Elm.Stories.Typography.Heading1, controls)