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

export const Paragraph = (args) =>
  Typography({ ...args, label: args.label || sampleParagraph, kind: 'p' })

const sampleParagraph = `This is a paragraph of text. As we add more content, you can see that it eventually hits a maximum width and begins to wrap. Defining a maximum width helps with readability! If the text is too wide, it's hard to find the next line. If it's too short, then the user is constantly interrupted by jumping from one line to another!`