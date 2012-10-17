/*
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
*/

var loglevels = 4;
var appendtag = true;
var colorized = false;
var stringmap = {
  none        : 0,
  error       : 1,
  production  : 1,
  warn        : 2,
  info        : 3,
  log         : 4,
  debug       : 4,
  development : 4
};
var colorsmap = {
  'white'   : ['\033[37m', '\033[39m'],
  'grey'    : ['\033[90m', '\033[39m'],
  'black'   : ['\033[30m', '\033[39m'],
  'blue'    : ['\033[34m', '\033[39m'],
  'cyan'    : ['\033[36m', '\033[39m'],
  'green'   : ['\033[32m', '\033[39m'],
  'magenta' : ['\033[35m', '\033[39m'],
  'red'     : ['\033[31m', '\033[39m'],
  'yellow'  : ['\033[33m', '\033[39m']
};
var levelsmap = {
  1: 'red',
  2: 'yellow',
  3: 'grey',
  4: 'cyan'
};

var parse = {
  level: function (level) {
    if (typeof level === 'number') {
      level = parseInt(level, 10);
      return level < 4 ? level : 4;
    } else if (typeof level === 'string') {
      if (typeof stringmap[level] != 'undefined') {
        return stringmap[level];
      } else {
        throw new Error(level + ' is undefined');
        return false;
      }
    } else {
      throw new Error('Invalid Format');
      return false;
    }
  },
  color: function (level) {
    return levelsmap[parse.level(level)];
  }
};

var setLogLevels = exports.level = function (level) {
  if (typeof level === 'undefined') {
    return loglevels = 4;
  } else {
    return loglevels = parse.level(level);
  }
};

var setAppendTag = exports.tag = function (append) {
  if (typeof append === 'boolean') {
    appendtag = append;
  } else if (typeof append === 'undefined') {
    appendtag = !appendtag;
  } else {
    throw new Error('Invalid Format');
  }
};

var setColorized = exports.colorize = function (color) {
  if (typeof color === 'boolean') {
    colorized = color;
  } else if (typeof color === 'undefined') {
    colorized = !colorized;
  } else {
    throw new Error('Invalid Format');
  }
};

var setColors = exports.color = function (level, color) {
  if (typeof colorsmap[color] != 'undefined') {
    levelsmap[parse.level(level)] = color;
  } else {
    throw new Error('Invalid Format');
  }
};

var hooker = require('hooker');
var util = require('util');

var consolable = exports.consolable = function (level) {
  hooker.hook(console, level, {
    pre: function () {
      if (loglevels >= stringmap[level]) {
        if (appendtag) {
          util.print(colorsmap[parse.color(level)][0] + '[' + level + '] ' + colorsmap[parse.color(level)][1]);
        }
        if (colorized) {
          util.print(colorsmap[parse.color(level)][0]);
        }
      } else {
        return hooker.preempt();
      }
    },
    post: function () {
      if (colorized) {
        util.print(colorsmap[parse.color(level)][1]);
      }
    }
  });
}

consolable('log');
consolable('info');
consolable('warn');
consolable('error');