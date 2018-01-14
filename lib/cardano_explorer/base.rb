module CardanoExplorer
  class Base
    attr_reader :hash

    def self.find(hash)
      new hash
    end

    def initialize(hash)
      @hash = hash
    end

    def summary
      @summary ||= get "#{endpoint}/summary/#{@hash}"
      @summary.parsed_response['Right']
    end

  private

    def get(path, options = {})
      HTTParty.get "#{root_url}/#{path}", query: options
    end

    def root_url
      CardanoExplorer.configuration.root_url
    end

    def endpoint
      raise NotImplementedError, '#endpoint not defined in child class'
    end
  end
end
