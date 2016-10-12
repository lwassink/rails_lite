require 'erb'

class ShowExceptions
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    begin
      @app.call(env)
    rescue Exception => e
      p "I happend, ############################"
      return ['500', {'Content-type' => 'text/html'}, render_exception(e)]
    end
  end

  private

  def render_exception(e)
    message = <<-HTML
      <!DOCTYPE html>
      <html>
      <head>
      <title>Error #{e.class.name}</title>
      </head>
      <body>
      <h1>#{e.class.name}</h1>
      Message: #{e.message}
      <br>
      <br>
      Backtrace: #{e.backtrace}
      </body>
      </html>
    HTML

    message
  end
end

