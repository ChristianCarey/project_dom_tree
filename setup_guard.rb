
# basic steps - excluding installation - for setting up Guard w/ RSpec
# Assumes guard-rspec, and rspec are installed
# working on Ubuntu 16.04 2016-11-04

# runs rspec --init
# adds the --format d line to .rspec
# creates a Gemfile with requirements for
#   rspec and guard-rspec
# creates a lib directory
# runs guard init rspec
guard_setup_commands = ['rspec --init',
                        'echo "--format d" >> .rspec',
                        'echo "\nsource \'https://rubygems.org\'\n\ngem \'rspec\'\ngem \'guard-rspec\'" >> Gemfile',
                        'mkdir lib',
                        'guard init rspec'
                       ]

# Executes given system commands if prior step succeeded
def execute_system_commands(commands)
  prior_command_succeeded = true

  commands.each_with_index do |command, index|
    if prior_command_succeeded
      prior_command_succeeded = system( command )
    else
      raise "#{ commands[( index - 1 )] } failed."
    end
  end
end

# Prevents accidental invocation
# to run enter 'ruby setup_guard please' at the command line
# Recommend deleting this file once setup completes for the first time
execute_system_commands(guard_setup_commands) if ARGV[0] == "please"

# Failed to use sed to insert line into Guardfile
# Manually add w/i guard :rspec block to watch .rb files in lib/
# watch(%r{^lib/(.+)\.rb$}) { |m| "spec/#{ m[1] }_spec.rb" }
