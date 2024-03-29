require 'rack'
require_relative 'lib/time_format'

# Main App
class App
  def call(env)
    request = Rack::Request.new(env)

    if request.get?
      route_request(request)
    else
      method_not_allowed_response
    end
  end

  private

  def route_request(request)
    case request.path
    when '/time'
      time_format_response(request)
    else
      not_found_response
    end
  end

  def time_format_response(request)
    time_format = TimeFormat.new(request.params['format'])

    if time_format.valid?
      response(status: 200, body: time_format.result)
    else
      response(status: 400, body: time_format.result)
    end
  end

  def response(status:, headers: { 'Content-Type' => 'text/plain' }, body:)
    [status, headers, [body]]
  end

  def not_found_response
    response(status: 404, body: '404 Not Found')
  end

  def method_not_allowed_response
    response(status: 405, body: 'App supports only GET requests')
  end
end
