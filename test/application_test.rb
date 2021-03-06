require_relative "test_helper"

class TestController < Rulers::Controller
  def index
    'TestController index (default) action'
  end

  def custom_action
    'TestController custom action'
  end
end

class TestApp < Rulers::Application
end

class RulersAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TestApp.new
  end

  def test_request
    get '/test/custom_action'

    assert last_response.ok?
    body = last_response.body
    assert body['TestController custom action']
  end

  def test_default_action
    get '/test'

    assert last_response.ok?
    body = last_response.body
    assert body['TestController index (default) action']
  end

  def test_blank_question_mark
    blank = nil
    empty_array = []
    empty_string = ''
    whitespace_including_unicode_string = " \n\t\u00a0"

    assert blank.blank?
    assert empty_array.blank?
    assert empty_string.blank?
    assert whitespace_including_unicode_string.blank?
  end

  def test_present_question_mark
    string = 'Hello'
    zero = 0
    number = 7
    array = [1, 2, 3]
    time = Time.now

    assert string.present?
    assert zero.present?
    assert number.present?
    assert array.present?
    assert time.present?
  end
end
