![consolable](https://dl-web.dropbox.com/get/Public/consolable.jpg?w=284686b0)

  consolable - get controls and colors in your [nodejs](http://nodejs.org) native console


## Requirement

  * NodeJS


## Quick Start

  Start coding:

    $ npm install consolable

  Include in your project

    require('consolable');


## Methods

    var consolable = require('consolable');

### setLogLevel(level = 4)

  * Change your Log Level 0~4, default is 4.
    * `level` is [specific word](#Level Format Word Lists) or number.
  * Level...
    * 0, ignore all log
    * 1, only `console.error`
    * 2, `console.error` and `console.warn`
    * 3, `console.error` and `console.warn` and `console.info`
    * 4, all log includes `console.log`

```coffee
consolable.setLogLevel 'production' # Set Lv.1, OK
consolable.setLogLevel 4            # Set Lv.4, OK
consolable.setLogLevel '2'          # Set Lv.2, OK
consolable.setLogLevel 'info'       # Set Lv.3, OK
consolable.setLogLevel 'hoge'       # Set Lv.4, Undefined word
```

### setAppendTag(append = true)

  * Append tag prefix or not, default is true.

```coffee
consolable.setAppendTag yes
console.log '（｀ェ´）ﾋﾟｬｰ'  # [log] （｀ェ´）ﾋﾟｬｰ

consolable.setAppendTag no
console.log '（｀ェ´）ﾋﾟｬｰ'  # （｀ェ´）ﾋﾟｬｰ
```

### setColorize(colorize = false)

  * Colorize log body text or not, default is false.

```coffee
consolable.setColorize no
                          #       __________ white
console.log 'colorize..'  # [log] colorize..
                          # ‾‾‾‾‾ cyan

consolable.setColorize yes
                          #       __________ cyan
console.log 'colorize..'  # [log] colorize..
                          # ‾‾‾‾‾ cyan
```

### setLevelColor(level, color)

  * Change log color.
  * Defaults...
    * `error` `red`
    * `warn` `yellow`
    * `info` `grey`
    * `log` `cyan`

```coffee
consolable.setColor 'error', 'magenta'
consolable.setColor 1, 'blue'
consolable.setColor 'info', 'green'
```

<a name='Level Format Word Lists'></a>
## Level Format Word Lists

  * 0, `none`
  * 1, `error`, `production`
  * 2, `warn`
  * 3, `info`
  * 4, `log`, `debug`, `development`

## Available Colors

  * white
  * grey
  * black
  * blue
  * cyan
  * green
  * magenta
  * red
  * yellow