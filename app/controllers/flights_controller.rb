require 'rest-client'
require 'json'

class FlightsController < ApplicationController

  def create

    byebug

    payloadString = {
      "journeys": [
          {
              "departureAirport": search_params["departureAirport"],
              "arrivalAirport": search_params["arrivalAirport"],
              "departureDate": search_params["departureDate"],
              "ticketTypes": [
                  "economy"
              ]
          },
          {
              "departureAirport": search_params["arrivalAirport"],
              "arrivalAirport": search_params["departureAirport"],
              "departureDate": search_params["returnDate"],
              "ticketTypes": [
                  "economy"
              ]
          }
      ],
      "passengers": search_params["numOfPass"]

    }.to_json

    response = RestClient::Request.new({
      method: :post,
      url: 'https://sandbox.api.gokyte.com/api/flights/search',
      payload: payloadString,
      headers: {content_type: 'application/json', "x-api-key": Rails.application.credentials.api_key}
      }).execute do |response, request, result|
        case response.code
        when 400
          [ :error, JSON.parse(response.to_str) ]
        when 200
          [ :success, JSON.parse(response.to_str) ]
        else
          fail "Invalid response #{response.to_str} received."
        end
      end

      # byebug
      render json: response

  end

  private

  def search_params
    # Doesn't work when .require is added first
    params.require(:flight).permit(:departureDate, :departureAirport, :arrivalAirport, :returnDate, :numOfPass => [:type])
  end

end
