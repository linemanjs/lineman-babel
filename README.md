# lineman-babel

A plugin to make it easy to use ES6/ES2015 in conjunction with a [Lineman](http://linemanjs.com) app.

It adds a default configuration of [Babel](https://babeljs.io)'s [grunt-babel](https://github.com/babel/grunt-babel) task to your project.

## Installation

```bash
$ npm install lineman-babel --save
```


## Configuration

All you need to do is install lineman-babel and it'll start treating all your
app's production & test ".js" files as ES6.

## Interrogating configuration

At any time, you can ask lineman about your babel config by asking:

```
$ lineman config babel
```

And to see what files it matches, you can run

```
$ lineman config files | grep babel
```

### Overriding configuration

In your application.js, you can override the babel task:

``` js
babel: {
  options: {
    sourceMap: true
  }
}
```
