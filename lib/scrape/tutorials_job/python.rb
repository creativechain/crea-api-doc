require 'git'

module Scrape
  module TutorialsJob
    class Python < Base
      def initialize(options = {})
        options[:tutorial_github_url] = 'https://github.com/creativechain/crea-api-doc-tutorials-py.git'
        options[:tutorial_github_name] ||= 'devportal-tutorials-py'
        options[:tutorial_url] = 'https://github.com/creativechain/crea-api-doc-tutorials-py'
        options[:dest_tutorials_path] ||= '_tutorials-python'
        
        super
      end
    end
  end
end
