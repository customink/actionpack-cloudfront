require 'test_helper'

class CloudfrontTest < ActiveSupport::TestCase

  setup do
    ActionPack::Cloudfront::Railtie.config.action_pack_cloudfront.load_proxies = true
    ActionDispatch::Railtie.config.action_dispatch.trusted_proxies = trusted_proxies
  end

  test '#remote_ip - passes a few standard rails tests' do
    request = stub_request 'REMOTE_ADDR' => '1.2.3.4'
    assert_equal '1.2.3.4', request.remote_ip

    request = stub_request 'REMOTE_ADDR' => '127.0.0.1',
                           'HTTP_X_FORWARDED_FOR' => '3.4.5.6'
    assert_equal '3.4.5.6', request.remote_ip
  end

  test '#remote_ip - with cloudfront connecting ip header' do
    request = stub_request 'REMOTE_ADDR' => '172.68.65.232',
                           'HTTP_X_FORWARDED_FOR' => '98.166.16.134'
    assert_equal '98.166.16.134', request.remote_ip

    request = stub_request 'REMOTE_ADDR' => '127.0.0.1',
                           'HTTP_X_FORWARDED_FOR' => '98.166.16.134, 34.195.252.211'
    assert_equal '98.166.16.134', request.remote_ip
  end

  private

  def trusted_proxies
    ActionPack::Cloudfront::IpRanges.trusted_proxies
  end

  def stub_request(env = {})
    ip_spoofing_check = env.key?(:ip_spoofing_check) ? env.delete(:ip_spoofing_check) : true
    ip_app = ActionDispatch::RemoteIp.new(Proc.new { }, ip_spoofing_check, trusted_proxies)
    tld_length = env.key?(:tld_length) ? env.delete(:tld_length) : 1
    ip_app.call(env)
    ActionDispatch::Http::URL.tld_length = tld_length
    ActionDispatch::Request.new(env)
  end

end
