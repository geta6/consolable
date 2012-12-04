fs = require 'fs'
path = require 'path'
util = require 'util'
exec = (require 'child_process').exec

SOURCE_DIR = './lib'
TARGET_DIR = './'
TARGET_FILE = 'consolable.js'

task 'build', 'Compile and Concatenate CoffeeScripts', ->
  console.log '\nCoffee Configure...'
  list = []
  index = 1
  for name in fs.readdirSync SOURCE_DIR
    if path.extname(name) is '.coffee'
      list.push "#{SOURCE_DIR}/#{name}"
      console.log "#{++index}) #{name}"
  list.reverse()
  list = list.join ' '
  option = "-b -cj #{TARGET_DIR}/#{TARGET_FILE} #{list}"
  console.log 'Coffee Compiling...'
  exec "coffee #{option}", (error, stdout, stderr) ->
    console.error error if error
    console.info stdout if stdout
    console.warn stderr if stderr
    console.info if error then 'Failed.' else 'Succeeded.'