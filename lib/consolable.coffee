###
consolable

Copyright (c) 2012 geta6
http://www.geta6.com/

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
###

# private

util = require 'util'
hooker = require 'hooker'

params =
  loglevel: 4
  appendtag: yes
  colorize: no
  colors:
    1: 'red',
    2: 'yellow',
    3: 'grey',
    4: 'cyan'

colors =
  white   : ['\x1b[37m', '\x1b[0m']
  grey    : ['\x1b[90m', '\x1b[0m']
  black   : ['\x1b[30m', '\x1b[0m']
  blue    : ['\x1b[34m', '\x1b[0m']
  cyan    : ['\x1b[36m', '\x1b[0m']
  green   : ['\x1b[32m', '\x1b[0m']
  magenta : ['\x1b[35m', '\x1b[0m']
  red     : ['\x1b[31m', '\x1b[0m']
  yellow  : ['\x1b[33m', '\x1b[0m']


# warn -> 2
level2number = (str) ->
  if typeof str is 'number'
    num = parseInt str, 10
    if num <= 4
      if num >= 0
        return num
      else
        return 0
    else
      return 4
  else
    str = str.toString()
    map =
      none        : 0
      error       : 1
      production  : 1
      warn        : 2
      info        : 3
      log         : 4
      debug       : 4
      development : 4
    if map[str]?
      return map[str]
    else
      console.log "string level '#{str}' is undfined"
      return 4

# 2 -> ['\u001b[33m', '\u001b[0m']
color4console = (level) ->
  level = level2number level if typeof level isnt 'number'
  if colors[params.colors[level]]?
    return colors[params.colors[level]]
  else
    return colors.white

# public

module.exports =
  setParams: (options) ->
    if typeof param is 'object'
      @setLogLevel options.loglevel if options.loglevel?
      @setAppendTag options.appendtag if options.appendtag?
      @setColorize options.colorize if options.colorize?
      if typeof options.colors is 'object'
        @setLevelColor 1, options.colors[1] if options.colors[1]?
        @setLevelColor 2, options.colors[2] if options.colors[2]?
        @setLevelColor 3, options.colors[3] if options.colors[3]?
        @setLevelColor 4, options.colors[4] if options.colors[4]?

  setLogLevel: (level) ->
    if level?
      return params.loglevel = level2number level

  setAppendTag: (append) ->
    if typeof append is 'boolean'
      params.appendtag = append

  setColorize: (colorize) ->
    if typeof colorize is 'boolean'
      params.colorize = colorize

  setLevelColor: (level, color) ->
    level = level2number level
    if params.colors[level]?
      if colors[color]?
        params.colors[level] = color

consolable = (level) ->
  hooker.hook console, level,
    pre: ->
      if params.loglevel >= level2number level
        if params.appendtag
          color = color4console level
          util.print "#{color[0]}[#{level}]#{color[1]} "
        if params.colorized
          util.print "#{color[0]}"
      else
        return hooker.preempt()
    post: ->
      if params.colorized
        color = color4console level
        util.print "#{color[1]}"

consolable 'log'
consolable 'info'
consolable 'warn'
consolable 'error'