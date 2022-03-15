// import source from './Button.elm?raw'
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
    onAction: { action: 'Elm' }
  }
}

export const Primary = (controls) =>
  Button({ ...controls, kind: 'primary' })

export const Secondary = (controls) =>
  Button({ ...controls, kind: 'secondary' })

export const Danger = (controls) =>
  Button({ ...controls, kind: 'danger' })
