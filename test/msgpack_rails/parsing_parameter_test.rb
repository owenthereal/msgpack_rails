require_relative "../test_helper"

class ParsingParameterController < ApplicationController
  def msgpack2json
    render json: params[:contact]
  end
end

class ParsingParameterTest < ActionDispatch::IntegrationTest
  def test_parsing_msgpack_request
    contact = Contact.new
    contact.name = 'Konata Izumi'
    contact.age = 16
    contact.created_at = Time.utc(2006, 8, 1)
    contact.awesome = true
    contact.preferences = { 'shows' => 'anime' }

    data = { :contact => contact }.to_msgpack

    if ::Rails::VERSION::MAJOR >= 5
      post "/parsing_parameter/msgpack2json.json",
        params: data,
        headers: { "Content-Type" => "application/msgpack" }
    else
      post "/parsing_parameter/msgpack2json.json",
        data,
        { "Content-Type" => "application/msgpack" }
    end

    assert_response :success

    json = ActiveSupport::JSON.decode(response.body)
    assert_equal contact.name, json['name']
    assert_equal contact.age, json['age']
    assert_equal contact.created_at, json['created_at'].to_time
    assert_equal contact.awesome, json['awesome']
    assert_equal(contact.preferences, json['preferences'])
  end
end
