import { Elm } from './Markdown.elm'
import elmSource from './Markdown.elm?raw'
import { ElmComponent } from 'elm-storybook'

export default {
  title: 'Typography',
  parameters: { elmSource },
  argTypes: {
    label: { control: { type: 'text' } }
  }
}

export const Markdown = (controls) =>
  ElmComponent.create(Elm.Stories.Typography.Markdown, controls)