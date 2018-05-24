# frozen_string_literal: true

require "blinkist/config"

Blinkist::Config.env = ENV["RAILS_ENV"]
Blinkist::Config.app_name = ENV["APP_NAME"]
Blinkist::Config.adapter_type = ENV["SSM_AVAILABLE"] == "true" ? :aws_ssm : :env
Blinkist::Config.error_handler = :heuristic
Blinkist::Config.preload # We want to preload everything
