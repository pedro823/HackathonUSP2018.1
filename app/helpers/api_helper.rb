require 'date'

module ApiHelper
  def convert_time(timestamp)
    # Converts utc timestamp to integer 0 <= t < 86400.
    # That determines the time of day.
    datetime = DateTime.parse(timestamp)
    return datetime.hour * 3600 + datetime.min * 60 + datetime.sec
  end

  def calculate_free_probability(room, time_of_day)
    # Calculates the probability of a room being empty in a certain time of day.
    time_before = LogStudyRoom.joins(:study_room).where('study_room_id = ? AND time_of_day <= ? AND "log_study_rooms".created_at >= ?',
                                                        room.id, time_of_day, 60.days.ago)
    # sorts by same day
    days = {}
    time_before.each do |log|
      day = log.created_at.strftime("%d/%m")
      if days[day] == nil
        days[day] = []
      end
      days[day] << log
    end
    # Sorts same day hour
    # picks last of same day
    last_of_day = []
    days.each do |key, day|
      day.sort! do |a, b|
        a.time_of_day <=> b.time_of_day
      end
      last_of_day << day[-1]
    end
    # makes the probability
    sum = 0
    last_of_day.each do |i|
      if i.taken == false
        # Room is free
        sum += 1
      end
      # Else: room is taken, do nothing
    end
    if last_of_day.length > 0
      prob = sum.to_f / last_of_day.length
    else
      prob = 1
    end
    return prob
  end
end
