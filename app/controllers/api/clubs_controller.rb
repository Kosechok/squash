class Api::ClubsController < ApplicationController

  def index
    clubs = Club.all
    serialized_clubs = ClubSerializer.new(clubs).serializable_hash[:data].map { |club| club[:attributes] }

    render json: { code: 0, clubs: serialized_clubs }
  end

end
