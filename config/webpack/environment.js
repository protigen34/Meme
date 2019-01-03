const { environment } = require('@rails/webpacker')
const erb =  require('./loaders/erb')
const fonts =  require('./loaders/fonts')
const audio =  require('./loaders/audio')

// resolve-url-loader must be used before sass-loader
environment.loaders.get('sass').use[2].options.importLoaders = 3;
environment.loaders.get('sass').use[4].options.sourceMapContents = false;
environment.loaders.get('sass').use[4].options.includePaths = ["vendor/javascript"]
environment.loaders.get('sass').use.splice(-2, 0, {
  loader: 'resolve-url-loader',
  options: {
    sourceMap: true,
    keepQuery: true,
    debug: true
  }
});
//console.log(environment.loaders.get('sass').use);
//process.exit(1);

if(!environment.config.resolve) environment.config.resolve = {};
if(!environment.config.resolve.alias) environment.config.resolve.alias = {};
environment.config.resolve.alias.jquery = 'jquery/src/jquery';

environment.loaders.append('erb', erb)
environment.loaders.append('fonts', fonts)
environment.loaders.append('audio', audio)
module.exports = environment
