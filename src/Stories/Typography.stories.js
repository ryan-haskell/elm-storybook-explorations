import { Elm } from './Typography.elm'
import { ElmComponent } from 'elm-storybook'

const Typography = (flags) =>
  ElmComponent.create(Elm.Stories.Typography, flags)

export default {
  title: 'Ui.Typography',
  parameters: {
    layout: 'centered'
  }
}

export const Heading1 = () =>
  Typography({ kind: 'h1', label: 'Heading 1' })

export const Heading2 = () =>
  Typography({ kind: 'h2', label: 'Heading 2' })

export const Heading3 = () =>
  Typography({ kind: 'h3', label: 'Heading 3' })

export const Heading4 = () =>
  Typography({ kind: 'h4', label: 'Heading 4' })