activate :automatic_image_sizes
activate :i18n, langs: ['pt-BR', 'en'], mount_at_root: false

set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'

configure :build do
  activate :minify_css
  activate :asset_hash
end

# Used for generating absolute URLs
set :protocol, "http://"
set :host, "ecostage.com.br"
set :port, 80

helpers do
  def host_with_port
    [host, optional_port].compact.join(':')
  end

  def optional_port
    port unless port.to_i == 80
  end

  def image_url(source)
    protocol + host_with_port + image_path(source)
  end
end

configure :development do
  # Used for generating absolute URLs
  set :host, '127.0.0.1'
  set :port, 4567
end