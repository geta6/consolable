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

fs = require 'fs'
util = require 'util'
hooker = require 'hooker'

params =
  filepath: null
  appendtime: no
  fileloglevel: 4
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

sendprefix = (level) ->
  tag = if params.appendtag then level else no
  time = if params.appendtime then Date.now() else no
  if tag and time
    return "[#{time} #{tag}] "
  if tag and !time
    return "[#{tag}] "
  if !tag and time
    return "[#{time}] "
  if !tag and !time
    return ""


# public

module.exports =
  setLogLevel: (level = 4, filesync = no) ->
    if level?
      params.loglevel = level2number level
    if typeof filesync is 'boolean' and filesync is yes
      @setFileLogLevel level2number level

  setFileLogLevel: (level = 4) ->
    if level?
      return params.fileloglevel = level2number level

  setFilePath: (filepath) ->
    if typeof filepath is 'string'
      unless fs.existsSync filepath
        fs.writeFileSync filepath, ''
      params.filepath = filepath

  setAppendTime: (appendtime = yes) ->
    if typeof appendtime is 'boolean'
      params.appendtime = appendtime

  setAppendTag: (append = yes) ->
    if typeof append is 'boolean'
      params.appendtag = append

  setColorize: (colorize = yes) ->
    if typeof colorize is 'boolean'
      params.colorize = colorize

  setLevelColor: (level, color) ->
    level = level2number level
    if params.colors[level]?
      if colors[color]?
        params.colors[level] = color


hooker.hook console, ['log', 'info', 'warn', 'error'],
  passName: yes
  pre: (level, log)->
    if params.fileloglevel >= level2number level
      if params.filepath isnt null
        fs.appendFileSync params.filepath, "#{sendprefix level}#{log}\n"
    if params.loglevel >= level2number level
      color = color4console level
      if params.colorize
        util.print "#{color[0]}#{sendprefix level}"
      else
        util.print "#{color[0]}#{sendprefix level}#{color[1]}"
    else
      return hooker.preempt()
  post: (res, name) ->
    if params.colorized
      color = color4console level
      util.print "#{color[1]}"