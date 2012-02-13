# encoding: utf-8
module ApplicationHelper

  def my_page_entries_info(collection, options = {})
    entry_name_single = options[:entry_name_single] || (collection.empty?? 'entry' : collection.first.class.name.underscore.sub('_', ' '))
    entry_name_plural = options[:entry_name_plural] || (collection.empty?? 'entry' : collection.first.class.name.underscore.sub('_', ' '))
    entry_name_few = options[:entry_name_few] || (collection.empty?? 'entry' : collection.first.class.name.underscore.sub('_', ' '))

    if collection.num_pages < 2
      case collection.total_count
      when 0; "Nie znaleziono #{entry_name_plural}"
      when 1; "Wyswietlam <strong>1</strong> #{entry_name_single}"
      else;   "Wyswietlam <strong>wszystkie #{collection.total_count}</strong> #{entry_name_few}"
      end
    else
      offset = (collection.current_page - 1) * collection.limit_value
      %{Wyswietlam <strong>%d&nbsp;-&nbsp;%d</strong> #{entry_name_plural} z <strong>%d</strong> w sumie} % [
      offset + 1,
      offset + collection.count,
      collection.total_count
      ]
    end
  end

  def human_date(date)
    date.strftime("%d-%m-%Y o %H:%M")
  end

  def clear_both
    "<div style='clear: both;'></div>".html_safe
  end
end
