# encoding: utf-8
module BookHelper

  def you_have_since(date)
    now = Time.new
    since_date = (Date.new(now.year, now.month, now.day).to_datetime - date.to_datetime).to_i
    if  since_date == 0
      "dzisiaj"
    elsif since_date == 1
      "1 dnia"
    else
      "#{since_date} dni"
    end
  end

end
