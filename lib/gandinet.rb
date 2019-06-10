# frozen_string_literal: true

require 'gandinet/version'
require 'unirest'
require 'json'
require 'oauth2'

module Gandinet
  class Error < StandardError; end

  class Client
    attr_accessor :api_key

    def initialize(api_key)

      unless api_key.empty?
        @api_key = api_key
      else
        puts "Error: required Api-key"
      end

      client = OAuth2::Client.new('kewMQCRyVQE0UPYmjqAjf7RQKZnNmWYZE5FBOhN7lww', '7RflozGr00KvmdjlEMOzIakZyP-8CemKdf2dqMtmphI', :site => 'https://www.facebook.com/v3.3/dialog/oauth?')

      client.auth_code.authorize_url(:redirect_uri => 'https://www.facebook.com/v3.3/dialog/oauth?')
      token = client.password.get_token('user@example.com', 'doorkeeper', :headers => {"grant_type" => 'password'})
      response = token.get('/oauth/authorize')
      puts response
    end

    def domains_all
      Unirest.get('https://api.gandi.net/v5/domain/domains',
                  headers: { 'authorization' => "Apikey #{@api_key}" })
             .raw_body
    end

    def check_domain_parameters(domain, duration, city, given, family, zip, country, streetaddr, phone, state, type, email)
      Unirest.post('https://api.gandi.net/v5/domain/domains',
                   headers: { 'authorization' => "Apikey #{@api_key}", 'dry-run' => 1, 'content-type' => 'application/json' },
                   parameters: "{\"fqdn\":\"#{domain}\",\"duration\":#{duration},\"owner\":{\"city\":\"#{city}\",\"given\":\"#{given}\",\"family\":\"#{family}\",\"zip\":\"#{zip}\",\"country\":\"#{country}\",\"streetaddr\":\"#{streetaddr}\",\"phone\":\"#{phone}\",\"state\":\"#{state}\",\"type\":#{type},\"email\":\"#{email}\"}}")
             .raw_body
    end

    def domain_registration(domain, duration, city, given, family, zip, country, streetaddr, phone, state, type, email)
      Unirest.post('https://api.gandi.net/v5/domain/domains',
                   headers: { 'authorization' => "Apikey #{@api_key}", 'content-type' => 'application/json' },
                   parameters: "{\"fqdn\":\"#{domain}\",\"duration\":#{duration},\"owner\":{\"city\":\"#{city}\",\"given\":\"#{given}\",\"family\":\"#{family}\",\"zip\":\"#{zip}\",\"country\":\"#{country}\",\"streetaddr\":\"#{streetaddr}\",\"phone\":\"#{phone}\",\"state\":\"#{state}\",\"type\":#{type},\"email\":\"#{email}\"}}")
             .raw_body
    end

    def information(domain)
      Unirest.get("https://api.gandi.net/v5/domain/domains/#{domain}",
                  headers: { 'authorization' => "Apikey #{@api_key}" })
             .raw_body
    end

    def automatic_renewal(domain, duration, enabled)
      Unirest.patch("https://api.gandi.net/v5/domain/domains/#{domain}/autorenew",
                    headers: { 'authorization' => "Apikey #{@api_key}", 'content-type' => 'application/json' },
                    parameters: "{\"duration\":#{duration},\"enabled\":#{enabled}}")
             .raw_body
    end

    def get_contacts(domain)
      Unirest.get("https://api.gandi.net/v5/domain/domains/#{domain}/contacts",
                  headers: { 'authorization' => "Apikey #{@api_key}" })
             .raw_body
    end

    def update_contacts(domain, lang, city, given, family, zip, extra_parameters, country, streetaddr, data_obfuscated, mail_obfuscated, phone, state, type, email)
      Unirest.patch("https://api.gandi.net/v5/domain/domains/#{domain}/contacts",
                    headers: { 'authorization' => "Apikey #{@api_key}",
                               'content-type' => 'application/json' },
                    parameters: "{\"admin\":{\"lang\":\"#{lang}\",\"city\":\"#{city}\",\"given\":\"#{given}\",\"family\":\"#{family}\",\"zip\":\"#{zip}\",\"extra_parameters\":#{extra_parameters},\"country\":\"#{country}\",\"streetaddr\":\"#{streetaddr}\",\"data_obfuscated\":#{data_obfuscated},\"mail_obfuscated\":#{mail_obfuscated},\"phone\":\"#{phone}\",\"state\":\"#{state}\",\"type\":#{type},\"email\":\"#{email}\"}}")
             .raw_body
    end

    def glue_list(domain)
      Unirest.get("https://api.gandi.net/v5/domain/domains/#{domain}/hosts",
                  headers: { 'authorization' => "Apikey #{@api_key}" })
             .raw_body
    end

    def glue_create(domain, name, ip4_1, ip4_2, ip6)
      Unirest.post("https://api.gandi.net/v5/domain/domains/#{domain}/hosts",
                   headers: { 'authorization' => "Apikey #{@api_key}",
                              'content-type' => 'application/json' },
                   parameters: "{\"name\":\"#{name}\",\"ips\":[\"#{ip4_1}\",\"#{ip4_2}\",\"#{ip6}\"]}")
             .raw_body
    end

    def glue_info(domain, ns_name)
      Unirest.get("https://api.gandi.net/v5/domain/domains/#{domain}/hosts/#{ns_name}",
                  headers: { 'authorization' => "Apikey #{@api_key}" })
             .raw_body
    end

    def glue_update(domain, name, ip4_1, ip4_2, ip6)
      Unirest.put("https://api.gandi.net/v5/domain/domains/#{domain}/hosts",
                  headers: { 'authorization' => "Apikey #{@api_key}",
                             'content-type' => 'application/json' },
                  parameters: "{\"name\":\"#{name}\",\"ips\":[\"#{ip4_1}\",\"#{ip4_2}\",\"#{ip6}\"]}")
             .raw_body
    end

    def glue_delete(domain, ns_name)
      Unirest.delete("https://api.gandi.net/v5/domain/domains/#{domain}/hosts/#{ns_name}",
                     headers: { 'authorization' => "Apikey #{@api_key}" })
             .raw_body
    end

    def ldns(domain)
      Unirest.get("https://api.gandi.net/v5/domain/domains/#{domain}/livedns",
                  headers: { 'authorization' => "Apikey #{@api_key}" })
             .raw_body
    end

    def ldns_enable(domain)
      Unirest.post("https://api.gandi.net/v5/domain/domains/#{domain}/livedns",
                   headers: { 'authorization' => "Apikey #{@api_key}" })
             .raw_body
    end

    def nameserver_info(domain)
      Unirest.get("https://api.gandi.net/v5/domain/domains/#{domain}/nameservers",
                  headers: { 'authorization' => "Apikey #{@api_key}" })
             .raw_body
    end

    def nameserver_update(domain, nameserver_1, nameserver_2)
      Unirest.put("https://api.gandi.net/v5/domain/domains/#{domain}/nameservers",
                  headers: { 'authorization' => "Apikey #{@api_key}",
                             'content-type' => 'application/json' },
                  parameters: "{\"nameservers\":[\"#{nameserver_1}\",\"#{nameserver_2}\"]}")
             .raw_body
    end

    def renewal_info(domain)
      Unirest.get("https://api.gandi.net/v5/domain/domains/#{domain}/renew",
                  headers: { 'authorization' => "Apikey #{@api_key}" })
             .raw_body
    end

    def do_renewal(domain, duration)
      Unirest.put("https://api.gandi.net/v5/domain/domains/#{domain}/renew",
                  headers: { 'authorization' => "Apikey #{@api_key}",
                             'content-type' => 'application/json' },
                  parameters: "{\"duration\":#{duration}}")
             .raw_body
    end

    def restore_info(domain)
      Unirest.get("https://api.gandi.net/v5/domain/domains/#{domain}/restore",
                  headers: { 'authorization' => "Apikey #{@api_key}" })
             .raw_body
    end

    def do_restore(domain)
      Unirest.post("https://api.gandi.net/v5/domain/domains/#{domain}/renew",
                   headers: { 'authorization' => "Apikey #{@api_key}",
                              'content-type' => 'application/json' },
                   parameters: '{}')
             .raw_body
    end

    def domain_availible(domain)
      Unirest.get("https://api.gandi.net/v5/domain/check?name=#{domain}",
                  headers: { 'authorization' => "Apikey #{@api_key}" })
             .raw_body
    end

    def tld_list
      Unirest.get('https://api.gandi.net/v5/domain/tlds',
                  headers: { 'authorization' => "Apikey #{@api_key}" })
             .raw_body
    end

    def tld_info(name)
      Unirest.get("https://api.gandi.net/v5/domain/tlds/#{name}",
                  headers: { 'authorization' => "Apikey #{@api_key}" })
             .raw_body
    end
  end
end
