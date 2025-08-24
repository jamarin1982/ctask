ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "webmock/minitest"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Permite localhost (para Capybara, letter_opener, etc.)
    # y ip-api.com
    # WebMock.disable_net_connect!(
    #   allow_localhost: true,
    #   allow: "ip-api.com"
    # )

    # Antes de cargar tus tests, aseguramos el adaptador de prueba
    ActiveJob::Base.queue_adapter = :test

    # Add more helper methods to be used by all tests here...
    def login
      post sessions_path, params: { login: "test@example.com", password: "123456" }
    end
  end
end
