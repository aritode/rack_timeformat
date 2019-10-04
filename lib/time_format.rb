# Time Format
class TimeFormat
  TIME_FORMATS = { year: '%Y', month: '%m', day: '%d',
                   hour: '%H', minute: '%M', second: '%S' }.freeze

  def initialize(params)
    @params = params
    check_time_formats
  end

  def result
    if valid?
      converted_time_format
    else
      "Unknown time format #{@bad_params}"
    end
  end

  def valid?
    @bad_params.empty?
  end

  private

  def check_time_formats
    all_params   = @params.split(',')
    @bad_params  = all_params.reject { |f| TIME_FORMATS.key? f.to_sym }
    @good_params = all_params - @bad_params
  end

  def converted_time_format
    format = @good_params.map { |f| TIME_FORMATS[f.to_sym] }
    Time.now.strftime(format.join('-'))
  end
end
