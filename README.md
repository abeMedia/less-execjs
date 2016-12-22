## less-execjs

less-execjs allows you to compile [Less CSS files](http://lesscss.org/) from Ruby.

To install:

    gem install less-execjs

To use:

    require 'less-execjs'
    Less::Parser.compile("body { background: darken(#CCC, 10%) }")

These bindings also integrate with [Tilt](https://github.com/rtomayko/tilt) and [Sprockets](https://github.com/sstephenson/sprockets), so work seamlessly with Rails.

## Requirements

[Node.js](http://nodejs.org) needs to be installed, and in the path.

## About

These are Ruby bindings for the next generation LESS, which is implemented in JavaScript.

These are separate from the [official bindings](https://github.com/cowboyd/less.rb), as they've been ported to [ExecJS](https://github.com/sstephenson/execjs). This means you don't have to re-compile v8 every deploy.

For more information, visit <http://lesscss.org>.

## Usage

less-execjs exposes the `less.render` constructor to ruby code via `Less::Parser`. You can instate it
context free:

    parser = Less::Parser.new

or with configuration options:

    parser = Less::Parser.new :paths => ['./lib', 'other/lib'], :filename => 'mystyles.less'

Once you have a parser instantiated, you can parse code to get your CSS

    result = parser.parse(".class {width: 1+1}") # => Less::Result
    result.to_css #=> .class {\n  width: 2;\n}\n
    parser.parse(".class {width: 1+1}", :compress => true).to_css #=> .class{width:2;}

There's a shortcut for this whole routine:

    Less::Parser.compile(css, options)

### Custom functions

You can load in custom functions for less by supplying the `:custom_functions` option with a path to a JS file. Your JS file must export a function with the signature of `registerCustomFunctions(less, functionRegistry)` which you can then use to add the custom functions to the less compiler using `functionRegistry.add[Multiple]`.

## Credits

This library was ported from [less.rb](https://github.com/cowboyd/less.rb) also using the Apache License. It was created by [Alex MacCaw](http://alexmaccaw.com) ([@maccman](http://twitter.com/maccman)).
