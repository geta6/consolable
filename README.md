![consolable](https://photos-5.dropbox.com/t/0/AAB_l0JQJIfJOBc1zYBQieE1CL1bNnsPhGsSBongoeH9rA/10/112615465/jpeg/32x32/2/1350468000/0/2/consolable.jpg/szivIHnEjJL7rh-JGHZmla-UAHju7Wy6BM52vvOX8nY?size=800x600)

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

* `consolable.level(level)`
  * ログレベルを変更します、`Level Format`セクションにある語で指定できます
  * デフォルトは`4`です

* `consolable.tag(bool)`
  * タグによるプレフィックスを付与するかどうかを変更します
  * デフォルトは`true`です、引数を与えないとトグルします

* `consolable.colorize(bool)`
  * ログの本文にカラーを付与するかどうかを変更します
  * デフォルトは`false`です、引数を与えないとトグルします

* `consolable.color(level, color)`
  * ログのカラーを変更します、第1引数は`Level Format`、第2引数は`Color Format`です
  * デフォルトは次の通りです
    * `error : red`
    * `warn  : yellow`
    * `info  : grey`
    * `log   : cyan`

### Level Format

#### Level 0

  `0`, `none`

#### Level 1

  `1`, `error`, `production`

#### Level 2

  `2`, `warn`

#### Level 3

  `3`, `info`

#### Level 4

  `4`, `log`, `debug`, `development`


### Color Format

#### grayscale

  `white`, `grey`, `black`

#### colors

  `blue`, `cyan`, `green`, `magenta`, `red`, `yellow`


## Features

  * control show/hide logs by `loglevel` option.
  * append colorized tag for message.


## Example

```js
var consolable = require('consolable');

consolable.level(2);

console.log('test');      // ignored
console.info('test');     // ignored
console.warn('warn');     // [warn] warn      // [warn] is yellow color
console.error('!ERROR!'); // [error] !ERROR!  // [error] is red color

consolable.level(4);

console.log('test');      // [log] test

consolable.tag(false);

console.log('test');      // test

consolable.colorize(true);

console.log('test');      // test // (cyan color)
console.error('FIXME');   // FIXME // (red color)

consolable.color('error', 'blue');

console.error('FIXME');   // FIXME // (blue color)
```
