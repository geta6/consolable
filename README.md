![consolable](https://dl-web.dropbox.com/get/Public/consolable.jpg?w=284686b0)

  consolable - get controls and colors in your [nodejs](http://nodejs.org) native console.

  you have good command of `console.error`, `warn`, `info`, `log`.

## Requirement

  * NodeJS


## Quick Start

  Start coding:

    $ npm install consolable

  Include in your project

    require('consolable');


## Features

  * Discarding lower level of log.
  * Visualize log by color, tag and time.
  * Output logs to file.

## Methods

    var consolable = require('consolable');

### setLogLevel(level = 4, [sync = no])

  * Set stdout log level, default 4.
    * `level` is [specific string](#Level Format Word Lists) or number.
    * `sync` is true, sync file log level with log level.
  * Lower level of logs will be discarded.
    * `level 0`: No logs output.
    * `level 1`: `error`.
    * `level 2`: `error`, `warn`.
    * `level 3`: `error`, `warn`, `info`.
    * `level 4`: `error`, `warn`, `info`, `log`.

```coffee
consolable.setLogLevel 3            # Set Lv.3
consolable.setLogLevel '2'          # Set Lv.2
consolable.setLogLevel 'production' # Set Lv.1
consolable.setLogLevel 'hoge'       # Set Lv.4, undefined word
consolable.setLogLevel 4, yes       # Set Lv.4, set FLv.4
```

### setFIleLogLevel(level = 4)

  * Set file log level, default 4.
  * Lower level of logs will be discarded.

### setFilePath(path)

  * Output logs to file, default null.
  * If path is already exists, append log.

```coffee
consolable.setFilePath './log.txt'
consolable.setFilePath null         # Stop
```

### setAppendTime([append = true])

  * Append UnixTime to log prefix, default false.

```coffee
consolable.setAppendTime()
console.log 'hoge'           # [1354605544707 log] hoge

consolable.setAppendTag no
console.log 'hoge'           # [1354605544707] hoge

consolable.setAppendTime no
console.log 'hoge'           # hoge

```

### setAppendTag([append = true])

  * Append LogLevel to log prefix, default true.

```coffee
consolable.setAppendTag()
console.log 'hoge'           # [log] hoge

consolable.setAppendTag no
console.log 'hoge'           # hoge
```

### setColorize([colorize = true])

  * Colorize body text, default false.

```coffee
consolable.setColorize()
console.log 'colorize..'     # <color=cyan>[log] colorize..</color>

consolable.setColorize no
console.log 'colorize..'     # <color=cyan>[log]</color> colorize..
```

### setLevelColor(level, color)

  * Change log color, defaults...
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
