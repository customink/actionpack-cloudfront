require 'rails/railtie'

module ActionPack
  module Cloudfront
    class Railtie < ::Rails::Railtie

      config.action_pack_cloudfront = ActiveSupport::OrderedOptions.new
      config.action_pack_cloudfront.load_proxies = !::Rails.env.test? && !::Rails.env.development?

      config.before_initialize do |app|
        if app.config.action_pack_cloudfront.load_proxies
          trusted_proxies = ActionPack::Cloudfront::IpRanges.trusted_proxies
          existing_proxies = Array(app.config.action_dispatch.trusted_proxies)

          app.config.action_dispatch.trusted_proxies = trusted_proxies.concat(existing_proxies).uniq
        end
      end

    end
  end
end
