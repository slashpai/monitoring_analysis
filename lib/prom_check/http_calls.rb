# common methods
module PromCheck
  # HTTP Requests
  class Request
    include Concurrent::Async
    def get(api)
      response = RestClient.get(api)
      JSON.parse(response)
    end
  end
end
