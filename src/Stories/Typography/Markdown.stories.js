import { Elm } from './Markdown.elm'
import { ElmComponent } from 'elm-storybook'

export default {
  title: 'Ui.Typography',
  parameters: { layout: 'centered' },
  argTypes: {
    label: { control: { type: 'text' } }
  }
}

export const Markdown = (controls) =>
  ElmComponent.create(Elm.Stories.Typography.Markdown, controls)