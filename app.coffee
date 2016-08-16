netlify         = require 'roots-netlify'
axis            = require 'axis'
rupture         = require 'rupture'
autoprefixer    = require 'autoprefixer-stylus'
js_pipeline     = require 'js-pipeline'
css_pipeline    = require 'css-pipeline'
accord          = require 'accord'
postcss         = accord.load 'postcss'
rucksack        = require 'rucksack-css'
lost            = require 'lost'
typographic     = require 'typographic'
font_magician   = require 'postcss-font-magician'
postcss_modules = require 'postcss-modules'
postcss_initial = require 'postcss-initial'
postcss_autoreset = require 'postcss-autoreset'
inline_svg      = require 'postcss-inline-svg'
cssnano         = require 'cssnano'
dynamic         = require 'dynamic-content'


module.exports =
  ignores: ['readme.md', '**/layout.*', '**/_*', '.gitignore', 'ship.*conf', '.npmrc', 'views/*.sublime-project']

  extensions: [
    js_pipeline(files: 'assets/js/**', out: 'js/scripts.js'),
    css_pipeline(files: 'assets/css/*.styl'),
    dynamic()
  ]

  stylus:
    use: [axis(), rupture(), typographic(), autoprefixer()]
    sourcemap: true

  'coffee-script':
    sourcemap: true

  jade:
    pretty: true

  postcss:
    use: [
      lost(),
      font_magician({
        hosted: 'assets/fonts'
        }),
      rucksack(),
      postcss_autoreset({
        reset: 'sizes',
        rulesMatcher: 'suit'
        }),
      postcss_initial(),
      inline_svg({
        path: 'assets/img/'
        }),
      # cssnano({
      #   core: false
      #   })
      cssnano({
        core: false
        })
    ]