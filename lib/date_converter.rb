require 'optparse'

class DateConverter

  PERIODS = ["day", "days", "month", "months", "hour", "hours", "minutes", "minute", "ago"].freeze

  def convert_date date_string
    s = date_string
    arr = s.split(" ")
    arr = arr.each_slice(2).to_a

    raise ArgumentError, 'Argument is not valid' if arr.length ==0
    arr.flatten.each do |e|
      if !(e.in?(PERIODS) || e.to_i.to_s == e)
        raise ArgumentError, 'Argument is not valid'
      end
    end

    date = Time.now

    seconds_ago = 0

    arr.each_with_index do |e, i|
      if e.size == 2
        seconds_ago += e[0].to_i.send(e[1]).seconds
      end
    end
    (date.to_i - seconds_ago).to_i
  end
end
