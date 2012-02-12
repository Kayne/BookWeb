module ProfileHelper

  def on_bookweb_since(date)
    now = Time.new
    (Date.new(now.year, now.month, now.day).to_datetime - date.to_datetime).to_i
  end

end
