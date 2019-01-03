module.exports = {
  test: /\.(wav|mp3|aac|ogg|flac)(\?v=\d+\.\d+\.\d+)?$/,
  use: [{
    loader: 'file-loader',
    options: {
        name: '[name].[ext]',
        outputPath: 'audio/'
    }
  }]
}