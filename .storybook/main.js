const Elm = require('vite-plugin-elm')
const path = require('path')

const folder = path.resolve(__dirname, './elm-storybook')

module.exports = {
  "stories": [
    "../src/**/*.stories.mdx",
    "../src/**/*.stories.@(js|jsx|ts|tsx)"
  ],
  "addons": [
    "@storybook/addon-a11y",
    "@storybook/addon-actions",
    "@storybook/addon-controls",
  ],
  "framework": "@storybook/html",
  "core": {
    "builder": "storybook-builder-vite"
  },
  async viteFinal (config) {
    // Allow .elm files to be imported
    config.plugins.push(Elm.plugin({ debug: false }))
    config.resolve = config.resolve || {}
    config.resolve.alias = config.resolve.alias || {}
    config.resolve.alias['elm-storybook'] = folder
    return config
  }
}