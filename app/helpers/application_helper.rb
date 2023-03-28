module ApplicationHelper
    
    def new_parse_opening_hours(opening_hours)
        weekdays = {
          'Mon': '星期一',
          'Tue': '星期二',
          'Wed': '星期三',
          'Thur': '星期四',
          'Fri': '星期五',
          'Sat': '星期六',
          'Sun': '星期日'
        }
      
        if opening_hours.include?('/')
          # Case 1: multiple sets of opening hours
          opening_hours.split('/').map do |set|
            parse_opening_hours(set)
          end.flatten
        else
          # Case 2: single set of opening hours
          parts = opening_hours.split(' ')
      
          if parts.length == 3
            # Case 2a: opening hours for multiple weekdays
            weekdays_str = parts[0]
            start_time_str = parts[1]
            end_time_str = parts[2]
      
            weekdays_str.gsub!(/[[:space:]]+/, '') # remove any whitespace
            weekdays_str.split(',').map do |weekday_str|
              weekday = weekdays[weekday_str.to_sym]
              start_time = Time.parse(start_time_str)
              end_time = Time.parse(end_time_str)
              {
                date: weekday,
                time: "#{start_time.strftime('%H:%M')} - #{end_time.strftime('%H:%M')}"
              }
            end
          elsif parts.length == 2
            # Case 2b: opening hours for a range of weekdays
            weekday_range_str = parts[0]
            start_time_str = parts[1]
            end_time_str = parts[2]
      
            weekday_range_regex = /([A-Za-z]{3})\s*-\s*([A-Za-z]{3})/
            weekday_range_match = weekday_range_regex.match(weekday_range_str)
      
            if weekday_range_match
              start_weekday_str = weekday_range_match[1]
              end_weekday_str = weekday_range_match[2]
              start_weekday = weekdays[start_weekday_str.to_sym]
              end_weekday = weekdays[end_weekday_str.to_sym]
      
              (Date.parse(start_weekday)..Date.parse(end_weekday)).map do |date|
                start_time = Time.parse(start_time_str)
                end_time = Time.parse(end_time_str)
                {
                  date: date.strftime('%A'),
                  time: "#{start_time.strftime('%H:%M')} - #{end_time.strftime('%H:%M')}"
                }
              end
            else
              # Case 2c: opening hours for a single weekday
              weekday_str = parts[0]
              start_time_str = parts[1]
              end_time_str = parts[2]
              weekday = weekdays[weekday_str.to_sym]
              start_time = Time.parse(start_time_str)
              end_time = Time.parse(end_time_str)
              [{
                date: weekday,
                time: "#{start_time.strftime('%H:%M')} - #{end_time.strftime('%H:%M')}"
              }]
            end
          else
            # Case 2d: unknown format
            []
          end
        end
  end

  def parse_opening_hours(opening_hours)
    days_of_week = %w[Mon Tue Wed Thur Fri Sat Sun]
  
    # 將 opening_hours 字串分成每個時間區間
    time_ranges = opening_hours.split(" / ")
  
    # 用來存放結果的陣列
    result = []
  
    # 依序處理每個時間區間
    time_ranges.each do |time_range|
      # 取出星期幾的部分，例如 "Mon - Fri"
      days_str = time_range[/^[A-Z][a-z]{2},?\s*-\s*[A-Z][a-z]{2}/]
  
      # 如果找到了星期幾的部分
      if days_str.present?
        # 將星期幾的部分轉成起始和結束的日期，例如 ["Mon", "Fri"]
        start_day, end_day = days_str.split(" - ")
  
        # 找到起始和結束日期的索引值
        start_index = days_of_week.index(start_day)
        end_index = days_of_week.index(end_day)
  
        # 生成每個日期對應的時間區間
        (start_index..end_index).each do |day_index|
          result << { date: days_of_week[day_index], time: time_range.split(" ").last }
        end
      else
        # 如果沒有星期幾的部分，則認為是所有日期都適用的時間區間
        days_of_week.each do |day|
          result << { date: day, time: time_range.split(" ").last }
        end
      end
    end
  
    return result
  end
  

end


