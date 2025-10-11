// module.exports = {
//   content: [
//     './app/views/**/*.{erb,html,html.erb}',
//     './app/helpers/**/*.rb',
//     './app/javascript/**/*.{js,jsx,ts,tsx}'
//   ],
//   theme: {
//     extend: {},
//   },
//   plugins: [],
// }

module.exports = {
  darkMode: 'media', // or 'class' if you prefer manual toggling
  content: [
    './app/**/*.{html,erb,rb,js}',
  ],
  theme: {
    extend: {
      fontFamily: {
        inter: ['Inter', 'sans-serif'],
      },
    },
  },
  plugins: [],
}
