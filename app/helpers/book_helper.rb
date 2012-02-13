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


  def rate_for_this_book(rate, all_rates)
    if all_rates <= 0
      "Brak"
    else
      "#{number_with_precision(rate, :precision => 2, :separator => '.')} na 6 (#{all_rates} opinii)"
    end
  end

end
