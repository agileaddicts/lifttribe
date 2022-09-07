const colors = require('tailwindcss/colors');

module.exports = {
  content: ["./assets/js/**/*.js", "./lib/*_web.ex", "./lib/*_web/**/*.*ex"],
  darkMode: "class",
  theme: {
    colors: {
      transparent: 'transparent',
      current: 'currentColor',
      black: colors.black,
      white: colors.white,
      slate: colors.slate,
      indigo: colors.indigo,
      // custom colors
      midnight: '#23252e',
      orange: '#ff9045'
    }
  },
  plugins: [
    require('@tailwindcss/forms')
  ]
};
