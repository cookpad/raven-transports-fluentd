# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.filter_parameters += [/pass|key(?!word)|token|secret|mail|address|zip|birthday|name|phone|card_number|card_code|plc/ix]
