import { Elm } from './Typography.elm'
import { ElmComponent } from 'elm-storybook'

const Typography = (flags) =>
  ElmComponent.create(Elm.Stories.Typography, flags)

export default {
  title: 'Ui.Typography',
  parameters: {
    layout: 'centered'
  },
  argTypes: {
    label: { control: { type: 'text' } }
  }
}

export const Heading1 = (args) =>
  Typography({ ...args, kind: 'h1' })

export const Heading2 = (args) =>
  Typography({ ...args, kind: 'h2' })

export const Heading3 = (args) =>
  Typography({ ...args, kind: 'h3' })

export const Heading4 = (args) =>
  Typography({ ...args, kind: 'h4' })