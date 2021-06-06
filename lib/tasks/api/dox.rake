namespace :api do
  def generate( namespace, version = nil )
    subtitle = version || namespace
    title = "#{ namespace }_#{ subtitle }"

    RSpec::Core::RakeTask.new title do | task |
      pattern = "spec/requests/#{ namespace }"
      pattern << "/#{ version }" if version

      task.pattern = pattern
      task.rspec_opts = "-f Dox::Formatter --order defined --tag dox --out dox/#{ subtitle }/docs.json"
    end

    Rake::Task[ title ].invoke

    `yarn redoc-cli bundle -o dox/#{ subtitle }/index.html dox/#{ subtitle }/docs.json`
  end

  desc 'Generate API documentation'
  task :dox do
    require 'rspec/core/rake_task'

    generate 'api', 'v1'
  end
end
