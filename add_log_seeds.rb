800.times do
  days_ago = rand(1..60)
  time_begin = rand(23000..72000)
  study_room_id = rand(1..6)
  time_end = (time_begin + rand(14400) * time_begin.to_f / 72000).to_i
  LogStudyRoom.create(
    study_room_id: study_room_id,
    taken: true,
    time_of_day: time_begin,
    created_at: days_ago.days.ago
  )
  LogStudyRoom.create(
    study_room_id: study_room_id,
    taken: false,
    time_of_day: time_end,
    created_at: days_ago.days.ago
  )
end
