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
      rooms[:study_rooms] << {
        :name => i.name,
        :fits_people => i.fits_number,
        :is_free => i.is_free
      }
    end
    render json: rooms.to_json
  end

  def set_study_room
    body = JSON.parse(request.body.read)
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
      result = {
        success: true,
        new_state: free
      }
      render json: result.to_json and return
    else
      internal_error("Could not save study_room") and return
    end
  end

  def plan_study
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
      a[:probability] <=> b[:probability]
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
