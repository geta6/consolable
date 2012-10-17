var defaults, h, u, _;

require('colors');
var _ = require('underscore')
  , h = require('hooker')
  , u = require('util');

var defaults = {
  loglevel: 4,
  tag: true,
  color: false
};

// none error|production warn info log|debug|development
// 0    1                2    3    4

var levelmap = {
  none: 0,
  error: 1,
  production: 1,
  warn: 2,
  info: 3,
  log: 4,
  debug: 4,
  development: 4
};

var logparser = function (level) {
  if (typeof level === 'number') {
    level = parseInt(level, 10);
    return level < 4 ? level : 4;
  } else if (typeof level === 'string') {
    if (typeof levelmap[level] != 'undefined') {
      return levelmap[level];
    } else {
      throw new Error('undefined log level');
      return 0;
    }
  } else {
    throw new Error('undefined log level');
    return 0;
  }
};

module.exports = function (options) {
  options = options || {}
  _.defaults(options, defaults);
  var loglevel = logparser(options.loglevel);
  h.hook(console, 'log', function () {
    if (loglevel >= 4) {
      u.print('[log] '.green);
    } else {
      return h.preempt();
    }
  });
  h.hook(console, 'info', function() {
    if (loglevel >= 3) {
      u.print('[info] '.grey);
    } else {
      return h.preempt();
    }
  });
  h.hook(console, 'warn', function() {
    if (loglevel >= 2) {
      u.print('[warn] '.cyan);
    } else {
      return h.preempt();
    }
  });
  h.hook(console, 'error', function() {
    if (loglevel >= 1) {
      u.print('[error] '.red);
    } else {
      return h.preempt();
    }
  });
};