const Elm = require('vite-plugin-elm')

export default {
  root: 'public',
  publicDir: 'public/static',
  plugins: [
    Elm.plugin({
      debug: false
    })
  ]
}