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
      options:
        spawn: false
      scripts:
        files: ['coffee/**/*.coffee']
        tasks: ['coffee:compile', 'includeSource']
      styles:
        files: ['sass/**/*.sass']
        tasks: ['sass:compile', 'includeSource']
      html:
        files: ['index.dev.html']
        tasks: ['includeSource']
    includeSource:
      build:
        files:
          'index.html': 'index.dev.html'


  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-include-source'

  grunt.registerTask 'default', ['clean', 'coffee', 'sass', 'includeSource', 'watch']
