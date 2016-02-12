activate :automatic_image_sizes
activate :react

configure :development do
  activate :livereload
end

after_configuration do
    sprockets.append_path File.dirname(::React::Source.bundled_path_for('react.js'))
end

set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
end
