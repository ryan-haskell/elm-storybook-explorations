const Elm = require('vite-plugin-elm')

export default {
  root: 'src',
  plugins: [
    Elm.plugin({
      debug: false
    })
  ]
}