import { Elm } from './Button.elm'
import { ElmComponent } from 'elm-storybook'

const Button = (flags) =>
  ElmComponent.create(Elm.Stories.Button, flags)

export default {
  title: 'Ui.Button',
  parameters: {
    layout: 'centered'
  },
  argTypes: {
    label: { control: { type: 'text' } },
    onClick: { action: 'onClick' }
  }
}

export const Primary = (args) =>
  Button({ ...args, kind: 'primary' })

export const Secondary = (args) =>
  Button({ ...args, kind: 'secondary' })

export const Danger = (args) =>
  Button({ ...args, kind: 'danger' })
