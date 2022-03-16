# @ryannhg/elm-storybook
> Build your next design system with [Elm](https://elm-lang.org) and [Storybook](https://storybook.js.org)!

![Screenshot of Elm in Storybook](./.storybook/elm-storybook/demo.gif)

## Live demo

Check out [elm-storybook.rhg.dev](https://elm-storybook.rhg.dev/) to see Elm and Storybook in action!

## Local development

If you have the latest version of [Node.js](https://nodejs.org) installed, this repo is ready to run on your own machine:

```bash
# Get the code...
git clone https://github.com/ryannhg/elm-storybook
cd elm-storybook

# and run it with node!
npm install
npm run storybook
```

## "What is it for?"

[Storybook](https://storybook.js.org) describes itself as "_an open source tool for building UI components and pages in isolation_". It's a popular tool for creating __design systems__ in your favorite language/framework.

This repo is an example of how to use Storybook, with [Elm](https://elm-lang.org). Elm is a great way to build reliable web applications. It doesn't throw any runtime errors in the browser, and it has __really friendly__ compiler messages as you code.

## "What can I do with it?"

Storybook has a lot of great plugins that make working with a design/product team feel awesome. This repo has examples of how you can leverage many of those features in Elm:

### ❤️ __Accessibility__
Make your UI more user-friendly for everyone, by getting things like color-contrast warnings or invalid HTML in the "Accessibility" tab.

### 🪵 __Actions__ 
Log component events as messages in the "Actions" tab, so you can see how your components respond to user interaction codebase.

### 🎛 __Controls__
Easily see how a component performs with different size labels, color variations, and more using the "Controls" tab. Does our paragraph wrap correctly? Does it unexpectedly clip off its content?

### 💾 __Stateful__
Just like with React or Vue, this repo let's your Elm components track their own state. For example, you can demo how your "Tab" component works with a tiny example

### 👩‍💻 __Source code__
See the Elm source code directly in the browser, using the "Source" tab! This makes it easy to see example usage and copy snippets into your project.