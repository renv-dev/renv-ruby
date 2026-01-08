# frozen_string_literal: true
require_relative "renv/version"
require 'net/http'
require 'json'

BASE_ENDPOINT = "https://renv-web.vercel.app/api"

module Renv
  class Error < StandardError; end
  # Your code goes here...
  class Client
    def initialize(data)
      puts "Renv Client Initialized"
      if data[:api_key].nil? || data[:api_key].empty?
        raise ArgumentError, "API key is required"
      end
      puts data
      @api_key = data[:api_key]
    end

    private
    def http_get(path, headers = {})
      url = BASE_ENDPOINT + path
      uri = URI(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (uri.scheme == "https")
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(uri)
      request['Authorization'] ||= "Bearer #{@api_key}"
      headers.each { |k, v| request[k] = v }

      http.request(request)
    end

    def http_post(path, body = {}, headers = {})
      url = BASE_ENDPOINT + path
      uri = URI(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (uri.scheme == "https")

      request = Net::HTTP::Post.new(uri)
      headers["Content-Type"] ||= "Bearer #{@api_key}"
      request["Content-Type"] ||= "application/json"
      headers.each { |k, v| request[k] = v }

      request.body = body.to_json
      http.request(request)
    end

    def raise_code_error(res)
      unless res.code == "200"
        raise "HTTP Error #{res.code}: #{res.body}"
      end
    end

    def config
      res = http_get("/keys")
      self.raise_code_error(res)
      JSON.parse(res.body)
    end

    def branch(branch)
      res = http_get("/projects/#{@project_id}/branches?name=#{branch}")
      raise_code_error(res)
      JSON.parse(res.body)
    end

    public
    def load(branch)
      puts "Renv Loading branch: #{branch}"
      config = self.config
      @project_id = config["data"]["token"]["projectId"]
      if @project_id.nil? || @project_id.empty?
        raise "Project ID not found in configuration"
      end
      branch = self.branch(branch)
      @branch = branch["data"]["branches"][0]['id']
      if @branch.nil? || @branch.empty?
        raise "Branch not found"
      end
    end
  end
end
