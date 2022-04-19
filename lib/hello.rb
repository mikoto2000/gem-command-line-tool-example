# frozen_string_literal: true

require_relative "hello/version"

module Hello
  class Error < StandardError; end

  def hello
    "Hello, World!"
  end

  module_function :hello

  puts Hello.hello
end
