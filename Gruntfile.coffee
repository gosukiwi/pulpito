module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    coffee:
      compile:
        expand: true
        cwd: 'coffee/'
        src: ['**/*.coffee']
        dest: 'js/'
        ext: '.js'
    sass:
      compile:
        files:
          'css/main.css': 'sass/main.sass'
    clean:
      build:
        force: true
        src: ['js', 'css']
    watch:
      scripts:
        files: ['coffee/**/*.coffee']
        tasks: ['coffee:compile']
        options:
          spawn: false
      styles:
        files: ['sass/**/*.sass']
        tasks: ['sass:compile']
        options:
          spawn: false

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default', ['clean', 'coffee', 'sass', 'watch']
