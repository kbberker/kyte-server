require 'rest-client'
require 'json'

class FlightsController < ApplicationController

  def create

    # byebug

    payloadString = {
      "journeys": [
          {
              "departureAirport": "LGW",
              "arrivalAirport": "BCN",
              "departureDate": "2019-04-08",
              "ticketTypes": [
                  "economy"
              ]
          },
          {
              "departureAirport": "BCN",
              "arrivalAirport": "LGW",
              "departureDate": "2019-04-11",
              "ticketTypes": [
                  "economy"
              ]
          }
      ],
      "passengers": [
          {
              "type": "adult"
          }
      ]
    }.to_json

    # byebug

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

end
