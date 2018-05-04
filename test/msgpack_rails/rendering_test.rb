require_relative "../test_helper"

class ContactsController < ApplicationController
  def serialized
    @contact = new_contact
    render msgpack: @contact.to_msgpack
  end
  private
  def new_contact
    contact = Contact.new
    contact.name = 'Konata Izumi'
    contact.age = 16
    contact.created_at = Time.utc(2006, 8, 1)
    contact.awesome = true
    contact.preferences = { 'shows' => 'anime' }
    contact
  end
end

class RenderingTest < ActionController::TestCase
  tests ContactsController

  def setup
    r = ActionDispatch::Routing::RouteSet.new
    r.draw do
      get ":controller/:action"
    end
    r.finalize!
    @routes = r
  end

  def test_serialized
    get :serialized, :format => :msgpack
    verify_response
  end

  private

  def verify_response
    assert_response :success

    contact = MessagePack.unpack(response.body)
    assert_equal 'Konata Izumi', contact['name']
    assert_equal 16, contact['age']
    assert_equal Time.utc(2006, 8, 1), contact['created_at']
    assert_equal true, contact['awesome']
    assert_equal({ 'shows' => 'anime' }, contact['preferences'])
  end
end
