require 'rack'
require 'rack/contrib/try_static'

class LanguageChooser
  LANGS = ['en', 'pt-BR']

  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)
    case req.path_info
    when /^$/
      return [302, {'Content-Type' => 'text', 'Location' => "#{req.base_url}/index.html"}, ['302 Found']]
    when /^\/$/
      return [302, {'Content-Type' => 'text', 'Location' => "#{req.base_url}/index.html"}, ['302 Found']]
    when /^\/(#{LANGS.join("|")})(.*).html$/
      return @app.call(env)
    when /^\/(.*).html$/
      begin
        lang = req.accept_language[0][0]
        if lang == 'en-US'
          lang = 'en'
        end
        if !LANGS.include?(lang)
          lang = LANGS.first
        end
      rescue
        lang = LANGS.first
      end
      return [302, {'Content-Type' => 'text', 'Location' => "#{req.base_url}/#{lang}#{req.fullpath}"}, ['302 Found']]
    else
      return @app.call(env)
    end
  end
end

use LanguageChooser

# Serve files from the build directory
use Rack::TryStatic,
  root: 'build',
  urls: %w[/],
  try: ['.html', 'index.html', '/index.html']

run lambda { |env|
  four_oh_four_page = File.expand_path("../build/404/index.html", __FILE__)
  [ 404, { 'Content-Type'  => 'text/html'}, [ File.read(four_oh_four_page) ]]
}
