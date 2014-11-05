Symphony-Longsip
=====

A customised [Longsip](https://github.com/firegoby/longsip) (boilerplate gulp setup) pre-configured for Symphony CMS, including support for [Browserify](http://broswerify.org/), [Polymer Web Components](http://www.polymer-project.org/), [BrowserSync](http://www.browsersync.io/), [Stylus](learnboost.github.io/stylus/), [Autoprefix CSS](https://github.com/ai/autoprefixer) and more!

Version: 0.1.0

Features
--------

* **[Autoprefixer](https://github.com/ai/autoprefixer)** - *automatically add CSS vendor prefixes*
* **[Bower](http://bower.io/)** - *frontend package manager*
* **[BrowserSync](http://www.browsersync.io/)** - *live reloading and development file server*
* **[Browserify](http://browserify.org/)** - *bundle/concat Javascript with require() dependency management*
* **Error Notifications** - *Mac OSX*
* **[jQuery](http://jquery.com/)** - *as CDN loaded external dependency for Browserify*
* **Concats all CSS & Javascript** - *into a single production file for each*
* **[Polymer Web Components](http://www.polymer-project.org/)** - *all ready to use, with auto concatenation*
* **[Stylus](http://learnboost.github.io/stylus/)** - *CSS preprocessing*
* **[Vulcanize](https://github.com/Polymer/vulcanize)** - *concat & minify Polymer Components*
* **[Watchify](https://github.com/substack/watchify)** - *for fast cached Browserify recompiles*

Requirements
------------

* [**Node.js**](http://nodejs.org/) - Download and run the installer for your platform
* [**Gulp**](http://gulpjs.com/) - Install with `npm install -g gulp`
* [**Bower**](http://bower.io/) - Install with `npm install -g bower`

*You may need to run `sudo -E npm install -g` commands depending on your system's particular setup* (e.g. Mac OS X)

Installation
------------

1. Download and unzip archive, copy/merge files into symphony project directory. Make sure to manually update `package.json` if you've made your own additions over the Symphony CMS defaults (if you haven't you can simply overwrite `packages.json` as it conatins both the Symphony and Longsip defaults already combined).
2. Edit `package.json` and `bower.json` with name & description of your own project
3. Run `npm install` (see note below)
4. Run `bower install`
5. Run `gulp`
6. *Profit!*

*You may need to run `sudo -E npm install` depending on your system's particular setup* (e.g. Mac OS X)

Post Installation Tips
----------------------

1. See `workspace/pages/example.xsl` for an sample HTML template showing how to integrate into your master.xsl or equivalent
2. The `workspace/build` directory contains both un-minified and minified versions of the concatenated stylesheet, javascript and web components. The un-minified version also contain sourcemaps/debugging info where applicable and should NEVER be used in production (see seciton entitel 'Production' for more details). Be aware that by default these un-minifed versions will be publically accessible unless steps are taken to protect/delete them from production systems. Normally them being available isn't an issue, the web is built on openly available source-code for the most part :) but if your javascript for instance contains a lot of propritery code then it's probably best for your relationship with your boss not to make all of that publically available :) You have been warned. (Easy preventions are ban access via .htaccess, or delete the relevant files as part of your deployment process)
3. BrowserSync is setup to automatically proxy http://localhost/ - if your development server is running at a different address, e.g. http://dev.example.com/ then update `gulpfile.js` config on line #29 to your custom URL
4. The `workspace/vendor` directory contains any third party assets you may need to include, at installation time it contains a backup, minified copy of jQuery (for when the google CDN isn't loading) and the Polymer (Web Components) loader `platform.js`. This later file is available post-installation at `bower_components/platform/platform.js` and ideally should be linked to from there, so that after updates via Bower to Polymer the new version of platform is automatically linked to. Since making the `bower_components` directory available via the web server, or or some other method, is out of the scope of this document a hard copt of `platform.js` is provided for simplicity's sake.
5. Because Symphony now comes with its own `package.json` if you upgrade your Symphony installation you'll want to check to see if there are any updates to `package.json` and manually update the references as part of your Symphony upgrade process.

Production
----------

In production you'll want to change the references in your HTML to the minified versions of both `main.css` and `bundle.js` to `main.min.css` and `bundle.min.js`. The un-minified versions contain source-maps so your browser's developer tools can show you where a certain piece of compiled code actually came from, these sourcemaps however take up a lot extra bytes and should never be served in production. The minified versions also reduce the stylesheet and javascripts assets in a number of other ways - stripping whitespace, removing comments, uglifying js - all saving you valuable bandwidth and your users time. So, *always* use the minified version in production!

**Update**: In production you should also change reference to `components.html` to `components.min.html` for a minified version of your Polymer Web Components file too.

FAQs
----

###1. Why not use the **[debowerify](https://www.npmjs.org/package/debowerify)** transform to allow seamless loading of bower components in browserify?

Because as of time of writing debowerify [doesn't provide a way to exclude or include certain bower packages](https://github.com/eugeneware/debowerify/issues/37). The result of this is that when the default Polymer packages are installed via bower (Polymer's recommended installation option) browserify crashes with a `maximum stack size exceeded` error because of the size of the Polymer packages and their dependencies. For the moment, bower packages can be used in `main.js` etc by simply referencing the relative path to the file. So for instance: -

    bower install moment

then in `main.js` (or other `scripts/*.js` file): -

    var moment = require('../../bower_components/moment/moment.js')
    console.log(moment().format('dddd'))

###2. Why Stylus? Why not Sass? It's much more popular!

Because Stylus can do (*nearly*) everything Sass can but it saves adding **yet another** requirement/dependency (Ruby) to the build process. Also Stylus is significantly faster, which once your project grows and Sass is taking a couple of seconds to compile your styles every time you save really starts to make a difference. If you really want/need Sass support it isn't hard to add, there are a million tutorials on getting Sass setup with Gulp, just follow one and add a new `sass` task to  `gulpfile.js` et voila!

###3. Why is `node_modules` over 120Mb?!

Don't ask me, apparently the npm dependency chain for all the little text utilities that make up a modern web frontend build process take up over 120Mb! Yes, it shocked me too.

###4. I already have a server, I want BrowserSync to use that!

Simply change `gulpfile.js` config for `config.BrowserSync.use` to `server`. Also make sure the details in `config.browserSync.serve.server` match your local server. All done. (NB: If you're using your own server you'll need to make sure the `/bower_components` directory is available for the loading of Polymer's components)

###5. Add do I add a new Polymer Web Component?

Simply list the `<import>` in `public/components.html` and run `gulp` (or re-save the file if Gulp is already running). This will concatenate the component with all the other components and load them as a single import in index.html. **NB**: The individual Polymer Web Component needs to be already installed using bower, as per the Polymer documentation, this is usually of the form e.g. `bower install --save Polymer/core-elements`

Notes, Tips & Tricks
--------------------

###1. Review the `.gitignore` file

The `bower_components` and `node_modules` directories are ignored from git by default since each are created on the fly by running the respective commands: `bower install` and `npm install`. Also, they're *huge* (See FAQ #4) and unnecessarily bloat your git repo. However, depending on your own project's needs you might want to include of the contents of these directories under version control.

###2. Read the [Browserify Handbook](https://github.com/substack/browserify-handbook)

Seriously, read it, otherwise trying to use Browserify without doing so is going to lead to much confusion.

Credits
-------

A lot of the early foundation of this Gulp setup was based on the excellent work done by [Dan Tello (greypants)](http://github.com/greypants) and his [gulp-starter](https://github.com/greypants/gulp-starter) project. Please check it out, it features a number of cool things not included in Longsip that might be useful for your project. Longsip arose out of a need for a default frontend build system that differed from the toolset that gulp-starter focuses on, in no way do I suggest that Longsip is better, simply a mutated cousin who wandered off in a slightly different direction :) Many, many thanks to Dan (and the other gulp-starter contributors) for all their hard work and sharing their efforts.
