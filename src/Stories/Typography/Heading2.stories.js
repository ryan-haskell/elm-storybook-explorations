import { Elm } from './Heading2.elm'
import { ElmComponent } from 'elm-storybook'

export default {
  title: 'Ui.Typography',
  parameters: { layout: 'centered' },
  argTypes: {
    label: { control: { type: 'text' } }
  }
}

export const Heading2 = (controls) =>
  ElmComponent.create(Elm.Stories.Typography.Heading2, controls)