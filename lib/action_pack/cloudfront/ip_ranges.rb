module ActionPack
  module Cloudfront
    module IpRanges

      class Range
        attr_reader :ip_prefix, :region, :service

        def initialize(attrs)
          @service = attrs['service']
          @ip_prefix = attrs['ip_prefix'] || attrs['ipv6_prefix']
          @region = attrs['region']
        end

        def cloudfront?
          service =~ /cloudfront/i
        end

        def ipaddr
          IPAddr.new(ip_prefix)
        end
      end

      def trusted_proxies
        cloudfront_proxies + ActionDispatch::RemoteIp::TRUSTED_PROXIES
      end

      def cloudfront_proxies
        ip_ranges.select(&:cloudfront?).map(&:ipaddr)
      end

      def ip_ranges
        @ip_ranges ||= begin
          data = ip_data
          prefixes = data['prefixes']
          prefixesv6 = data['ipv6_prefixes']
          (prefixes + prefixesv6).map do |attrs|
            Range.new(attrs)
          end
        end
      end

      def ip_data
        Timeout.timeout(5) do
          uri = URI('https://ip-ranges.amazonaws.com/ip-ranges.json')
          res = Net::HTTP.get(uri)
          JSON.parse(res)
        end
      rescue
        backup_json = File.join File.dirname(__FILE__), 'ip-ranges.json'
        JSON.parse File.read(backup_json)
      end

      extend self

    end
  end
end


