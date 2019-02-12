lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scrape/api_definitions_job'
require 'scrape/tutorials_job/base'
require 'scrape/tutorials_job/javascript'
require 'scrape/tutorials_job/python'
require 'scrape/tutorials_job/ruby'

require 'rake/testtask'
require 'net/https'
require 'json'
require 'yaml'
require 'html-proofer'

namespace :scrape do
  desc "Scrape creajs docs"
  task :javascript do

  end

  desc "Scrape pycrea docs"
  task :python do
  end
  
  desc "Scrape API Definitions"
  task :api_defs do
    url = ENV.fetch('TEST_NODE', 'https://node1.creary.net')
    job = Scrape::ApiDefinitionsJob.new(url: url)
    count = job.perform
    
    puts "Methods added or changed: #{count}"
  end
  
  desc 'Scrape all known tutorial repositories.'
  task :tutorials do
    puts '=' * 80
    puts "JS-Tutorials:"
    Rake::Task["scrape:tutorials:js"].invoke
    puts '=' * 80
    puts "PY-Tutorials:"
    Rake::Task["scrape:tutorials:py"].invoke
    puts '=' * 80
    puts "RB-Tutorials:"
    Rake::Task["scrape:tutorials:rb"].invoke
  end
  
  namespace :tutorials do
    desc 'Scrape JS-Tutorials'
    task :js, [:num, :force] do |t, args|
      job = Scrape::TutorialsJob::Javascript.new(num: args[:num], force: args[:force])
      count = job.perform
    
      puts "Tutorials added or changed: #{count}"
    end
    
    desc 'Scrape PY-Tutorials'
    task :py, [:num, :force] do |t, args|
      job = Scrape::TutorialsJob::Python.new(num: args[:num], force: args[:force])
      count = job.perform
      
      puts "Tutorials added or changed: #{count}"
    end
    
    desc 'Scrape RB-Tutorials'
    task :rb, [:num, :force] do |t, args|
      job = Scrape::TutorialsJob::Ruby.new(num: args[:num], force: args[:force])
      count = job.perform
      
      puts "Tutorials added or changed: #{count}"
    end
  end
end

namespace :production do
  task :prevent_dirty_builds do
    if `git status --porcelain`.chomp.length > 0
      puts '*** WARNING: You currently have uncommitted changes. ***'
      fail 'Build aborted, because project directory is not clean.' unless ENV['ALLOW_DIRTY']
    end
  end
  
  task :build do
    sh 'bundle exec jekyll build --destination docs'
  end
  
  task :drop_previous_build do
    sh 'git checkout master'
    sh 'git rm -rf docs'
    sh 'git commit -m "jekyll dropped previous site"'
  end
  
  desc "Deploy current master to GH Pages"
  task deploy: [:prevent_dirty_builds, :drop_previous_build, :build] do
    sh 'git add -A'
    sh 'git commit -m "jekyll base sources"'
    sh 'git push origin master'
    
    exit(0)
  end
  
  desc "Rollback GH Pages"
  task rollback: [:prevent_dirty_builds] do
    sh 'git checkout master'
    sh 'git reset --hard HEAD^'
    sh 'git push origin master'
    
    exit(0)
  end
  
  desc "Make a clean build."
  task :clean do
    sh 'rm -rf _site && rm -rf docs && git checkout -- docs && git checkout -- _site'
  end
end

desc 'Dump all operation types.  Useful for schema comparison.'
task :ops_dump, [:vops, :appbase] do |t, args|
  vops = args[:vops] == 'true'
  appbase = args[:appbase] == 'true'
  file_name = '_data/apidefinitions/broadcast_ops.yml'
  op_names = []
  yaml = YAML.load_file(file_name)
  op_names += yaml[0]['ops'].map do |op|
    next if op['virtual'] && !vops
    
    if !!appbase
      op['name'] + '_operation'
    else
      op['name']
    end
  end
  
  puts op_names.compact.sort
end

namespace :test do
  KNOWN_APIS = %i(
    account_by_key_api account_history_api block_api condenser_api 
    database_api follow_api jsonrpc market_history_api network_broadcast_api
    tags_api witness_api
  )
  
  desc "Tests the curl examples of api definitions.  Known APIs: #{KNOWN_APIS.join(' ')}"
  task :curl, [:apis] do |t, args|
    smoke = 0
    url = ENV.fetch('TEST_NODE', 'https://node1.creary.net')
    apis = [args[:apis].split(' ').map(&:to_sym)].flatten if !!args[:apis]
    apis ||= KNOWN_APIS
    
    version = `curl -s --data '{"jsonrpc":"2.0", "method":"condenser_api.get_version", "params":[], "id":1}' #{url}`
    version = JSON[version]['result']
    blockchain_version = version['blockchain_version']
    crea_rev = version['crea_revision'][0..5]
    fc_rev = version['fc_revision'][0..5]
    puts "node: #{url}; blockchain_version: #{blockchain_version}; crea_rev: #{crea_rev}; fc_rev: #{fc_rev}"
    
    apis.each do |api|
      file_name = "_data/apidefinitions/#{api}.yml"
      unless File.exist?(file_name)
        puts "Does not exist: #{file_name}"
        next
      end
      
      yml = YAML.load_file(file_name)
      
      yml[0]['methods'].each do |method|
        print "Testing #{method['api_method']} ... "
        
        if method['curl_examples'].nil?
          puts "no curl examples."
          next
        end
        
        method['curl_examples'].each_with_index do |curl_example, index|
          response = `curl -s -w \"HTTP_CODE:%{http_code}\" --data '#{curl_example}' #{url}`
          response = response.split('HTTP_CODE:')
          json = response[0]
          code = response[1]
          
          case code
          when '200'
            data = JSON[json]
            
            if !!data['error']
              expected_curl_response = if !!method['expected_curl_responses']
                method['expected_curl_responses'][index]
              end
              
              if !!expected_curl_response && data['error']['message'].include?(expected_curl_response)
                print '√'
              else
                smoke += 1
                print "\n\t#{data['error']['message']}\n"
              end
            else
              print '√'
            end
          else
            smoke += 1
            'X'
          end
        end
        
        print "\n"
      end
    end
    
    exit smoke
  end
  
  desc 'Want some work to do?  Run this report and get busy.'
  task :proof do
    # See: https://github.com/gjtorikian/html-proofer#configuration
    sh 'bundle exec jekyll build'
    options = {
      assume_extension: true,
      only_4xx: true,
      check_favicon: true,
      check_html: true,
      allow_hash_href: true,
      empty_alt_ignore: true
    }
    
    HTMLProofer.check_directory("./_site", options).run
  end
end
