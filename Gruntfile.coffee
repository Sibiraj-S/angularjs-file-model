'use strict'

banner = '/*!\n * @module <%= pkg.name %>\n' +
  ' * @description <%= pkg.description %>\n' +
  ' * @version v<%= pkg.version %>\n' +
  ' * @link <%= pkg.homepage %>\n' +
  ' * @licence MIT License, https://opensource.org/licenses/MIT\n' +
  ' */\n\n';

module.exports = (grunt) ->
  require('load-grunt-tasks')(grunt)

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    coffeelintr:
      options:
        configFile: 'coffeelint.json'
      source: ['src/fileModel.coffee', 'Gruntfile.coffee']

    coffee:
      compileJoined:
        options:
          join: true
        files:
          'dist/fileModel.js': ['src/fileModel.coffee']

    concat:
      options:
        stripBanners: true
        banner: banner
      dist:
        files:
          'dist/fileModel.js': ['dist/fileModel.js']

    uglify:
      options:
        sourceMap: true
        output:
          comments: '/^!/'
      target:
        files:
          'dist/fileModel.min.js': ['dist/fileModel.js']

    watch:
      coffeescript:
        files: ['src/*.coffee']
        tasks: ['default']

  # Grunt task(s).
  grunt.registerTask 'default', ['coffeelintr', 'coffee']
  grunt.registerTask 'coffeelint', ['coffeelintr']
  grunt.registerTask 'develop', ['default', 'watch']
  grunt.registerTask 'build', ['default', 'concat', 'uglify']

  return
