class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  include ApiHelper

  def all_institutions
    all = {
      :institutions => []
    }
    Institution.joins(:location).each do |i|
      all[:institutions] << {
        :id => i.id,
        :name => i.name,
        :tag => i.tag,
        :address => i.address,
        :location => i.location.name
      }
    end
    render json: all.to_json
  end

  def institution
    id = params[:id]
    unless Institution.exists?(id)
      not_found("A instituição não existe!") and return
    end
    rooms = {
      :study_rooms => []
    }
    StudyRoom.joins(:institution).where(:institution_id => id).each do |i|
      # N + 1 'cause fuckkkk
      last_time = LogStudyRoom.where(study_room_id: i.id).order(created_at: :desc).first
      if last_time
        last_time = last_time.created_at
      end
      rooms[:study_rooms] << {
        :id => i.id,
        :name => i.name,
        :fits_people => i.fits_number,
        :is_free => i.is_free,
        :last_change => last_time
      }
    end
    render json: rooms.to_json
  end

  def set_study_room
    begin
      body = JSON.parse(request.body.read)
    rescue => e
      puts e.to_s
      bad_request(e.to_s)
    end
    if (free = body['free']) == nil or (id = body['id']) == nil
      bad_request('missing arguments: be sure free and id are in the body') and return
    end
    if free != true and free != false
      bad_request('free must be a boolean') and return
    end
    unless StudyRoom.exists?(id)
      not_found("study room with id #{id} was not found") and return
    end
    study_room = StudyRoom.find(id)
    study_room.is_free = free
    if study_room.save
      # Creates log
      log = LogStudyRoom.new(
        study_room_id: study_room.id,
        taken: free,
        time_of_day: convert_time(Time.now.to_s),
      )
      logged = log.save

      result = {
        success: true,
        new_state: free,
        logged: logged
      }
      render json: result.to_json and return
    else
      internal_error("Could not save study_room") and return
    end
  end

  def plan_study
    # Ranks the room most probable to be empty at that time
    if (time = params[:time]) == nil
      bad_request('Missing required param: time')
    end
    begin
      time_of_day = convert_time(time)
    rescue ArgumentError => e
      bad_request(e.to_s) and return
    end
    all_rooms = []
    StudyRoom.joins(:institution).each do |i|
      all_rooms << {
        study_room: i,
        probability: calculate_free_probability(i, time_of_day)
      }
    end
    all_rooms.sort! do |a, b|
      b[:probability] <=> a[:probability]
    end
    result = {
      rooms: []
    }
    all_rooms.each do |i|
      result[:rooms] << {
        room_name: i[:study_room].name,
        intitution_name: i[:study_room].institution.name,
        fits_people: i[:study_room].fits_number,
        probability: i[:probability]
      }
    end
    render json: result.to_json
  end

  def plan_single
    # Asks if a single room would be full in that time
    id = params[:id]
    time = params[:time]
    if id == nil || time == nil
      bad_request('Missing required parameter') and return
    end
    unless StudyRoom.exists?(id)
      not_found("Study Room with id #{id} not found") and return
    end
    begin
      time_of_day = convert_time(time)
    rescue ArgumentError => e
      bad_request(e.to_s) and return
    end
    study_room = StudyRoom.find(id)
    probability = calculate_free_probability(study_room, time_of_day)
    result = {
      probability: probability
    }
    render json: result.to_json
  end

  def peak_hours
    id = params[:id]
    unless StudyRoom.exists?(id)
      not_found("Study Room with id #{id} not found") and return
    end
    study_room = StudyRoom.find(id)
    histogram = []
    (0...24).each do |hour|
      time = "#{hour}:00"
      time_of_day = convert_time(time)
      histogram << calculate_free_probability(study_room, time_of_day).round(4)
    end
    result = {
      range: 'hourly',
      probabilities: histogram
    }
    render json: result.to_json
  end

  private

  def internal_error(text="")
    message = {
      :error => "Internal Error",
      :description => text
    }
    render json: message.to_json, status: 500
  end

  def not_found(text="")
    message = {
      :error => "Not found",
      :description => text
    }
    render json: message.to_json, status: 404
  end

  def bad_request(text="")
    message = {
      :error => "Bad Request",
      :description => text
    }
    render json: message.to_json, status: 400
  end
end
