class ApiController < ApplicationController
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
      not_found("A instituição não existe!")
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



  private

  def not_found(text="")
    message = {
      :error => "Not found",
      :description => text
    }
    render json: message.to_json, status: 404
  end
end
