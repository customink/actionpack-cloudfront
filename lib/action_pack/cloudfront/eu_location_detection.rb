module ActionPack
  module Cloudfront
    module EuLocationDetection
      EU_ISO_3166_ALPHA_2 = /^(AL|AD|AT|BY|BE|BA|BG|HR|CY|CZ|DK|EE|FI
                              |FR|DE|GI|GR|HU|IS|IE|IM|IT|RS|LV|LI|LT
                              |LU|MK|MT|MD|MC|ME|NL|NO|PL|PT|RO|RU|SM
                              |RS|SK|SI|ES|SE|CH|UA|GB|VA|RS)$/ix

      def request_from_eu?
        country_code = request.headers['CloudFront-Viewer-Country']
        country_code_in_eu?(country_code)
      end

      private

      def country_code_in_eu?(code)
        !(code =~ EU_ISO_3166_ALPHA_2).nil?
      end
    end
  end
end
