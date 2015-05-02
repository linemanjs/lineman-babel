_ = require('underscore')

module.exports = (lineman) ->
  app = lineman.config.application

  files:
    babel:
      app: "<%= files.js.app %>"
      spec: "<%= files.js.spec %>"
      specHelpers: "<%= files.js.specHelpers %>"
      generated: "generated/js/app.babel.js"
      generatedSpec: "generated/js/spec.babel.js"
      generatedSpecHelpers: "generated/js/spec-helpers.babel.js"

  config:
    loadNpmTasks: app.loadNpmTasks.concat('grunt-babel')

    prependTasks:
      common: app.prependTasks.common.concat("babel")

    babel:
      options:
        sourceMap: true
        sourceRoot: '../..'

      compile:
        files:
          "<%= files.babel.generated %>": "<%= files.babel.app %>"
          "<%= files.babel.generatedSpec %>": "<%= files.babel.spec %>"
          "<%= files.babel.generatedSpecHelpers %>": "<%= files.babel.specHelpers %>"

    jshint:
      options:
        esnext: true

    concat_sourcemap:
      js:
        src: _(app.concat_sourcemap.js.src).map (path) ->
          return "<%= files.babel.generated %>" if path == "<%= files.js.app %>"
          path

      spec:
        src: _(app.concat_sourcemap.spec.src).map (path) ->
          return "<%= files.babel.generatedSpecHelpers %>" if path == "<%= files.js.specHelpers %>"
          return "<%= files.babel.generatedSpec %>" if path == "<%= files.js.spec %>"
          path

    watch:
      js:
        tasks: ["babel"].concat(app.watch.js.tasks...)
      jsSpecs:
        tasks: ["babel"].concat(app.watch.jsSpecs.tasks...)
