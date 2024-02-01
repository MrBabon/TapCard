const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['"Inria Sans"', ...defaultTheme.fontFamily.sans],
        jost: ['"Jost"', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        'TapCard-yellow': '#FFD115',
        'TapCard-teal': '#19A9AA',
        'TapCard-clair': '#d1eeee',
        'TapCard-blue': '#368FE6',
        'TapCard-navy': '#406078',
        'TapCard-charcoal': '#3A3A3A',
        'TapCard-gray': '#5B5B5B',
        'TapCard-silver': '#A3A8AF',
        'TapCard-lightGray': '#F4F4F4',
      },
      backgroundColor: {
        'rgba': 'rgba(5, 26, 36, 0.8)',
      },
      backgroundImage: {
        'banner-home': "linear-gradient(rgba(255,255,255,0.45),rgba(255,255,255,0.45)),url('https://res.cloudinary.com/dilp6xqmb/image/upload/v1706191668/home-TapCard_jzn1wp.jpg')",
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
