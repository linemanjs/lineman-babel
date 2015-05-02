_ = require('underscore')

module.exports = (lineman) ->
  app = lineman.config.application

  files:
    babel:
      app: "<%= files.js.app %>"
      spec: "<%= files.js.spec %>"
      specHelpers: "<%= files.js.specHelpers %>"
      generated: "generated/js/babel/"


  config:
    loadNpmTasks: app.loadNpmTasks.concat('grunt-babel')

    prependTasks:
      common: app.prependTasks.common.concat("babel")

    babel:
      options:
        sourceMap: true
        sourceRoot: '../..'

      src:
        files: [
          expand: true
          src: "<%= files.babel.app %>"
          dest: "<%= files.babel.generated %>"
        ]
      spec:
        options:
          sourceRoot: '..'
        files: [
            expand: true
            src: "<%= files.babel.spec %>"
            dest: "<%= files.babel.generated %>"
        ]
      specHelpers:
        files: [
            expand: true
            src: "<%= files.babel.specHelpers %>"
            dest: "<%= files.babel.generated %>"
        ]


    jshint:
      options:
        esnext: true

    _babel_util:
      prepend: (prepend, pattern) ->
        if _(pattern).isArray()
          "{#{_(pattern).map((p) -> "#{prepend}#{p}")}}"
        else
          "#{prepend}#{pattern}"


    concat_sourcemap:
      js:
        src: _(app.concat_sourcemap.js.src).map (path) ->
          return "<%= _babel_util.prepend(files.babel.generated, files.babel.app) %>" if path == "<%= files.js.app %>"
          path

      spec:
        src: _(app.concat_sourcemap.spec.src).map (path) ->
          return "<%= _babel_util.prepend(files.babel.generated, files.babel.specHelpers) %>" if path == "<%= files.js.specHelpers %>"
          return "<%= _babel_util.prepend(files.babel.generated, files.babel.spec) %>" if path == "<%= files.js.spec %>"
          path

    watch:
      js:
        tasks: ["babel"].concat(app.watch.js.tasks...)
      jsSpecs:
        tasks: ["babel"].concat(app.watch.jsSpecs.tasks...)
