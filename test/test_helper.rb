# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "renv"
require_relative 'TOKEN'

client = Renv::Client.new(api_key: TOKEN)


require "minitest/autorun"
