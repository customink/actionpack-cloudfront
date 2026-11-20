require 'test_helper'

class LocationHeadersTest < ActiveSupport::TestCase
  class ApplicationController < ActionController::Base
    include ActionPack::Cloudfront::LocationHeaders
  end

  class ApiController < ActionController::API
    include ActionPack::Cloudfront::LocationHeaders
  end

  test '#request_eu? - includes when has helper method' do
    assert_includes ApplicationController._helper_methods, :request_eu?
    assert_nil ApiController.try(:_helper_methods)
  end
end
