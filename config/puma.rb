#!/usr/bin/env puma

base_dir = '/var/www/askacountry/current'

# The directory to operate out of.
#
# The default is the current directory.
#
# directory '/u/apps/lolcat'


# Set the environment in which the rack's app will run.
#
# The default is “development”.
#
environment = :production

# Daemonize the server into the background. Highly suggest that
# this be combined with “pidfile” and “stdout_redirect”.
#
# The default is “false”.
#
daemonize
# daemonize false

# Store the pid of the server in the file at “path”.
#
pidfile  "#{base_dir}/tmp/puma/pid"

# Use “path” as the file to store the server info state. This is
# used by “pumactl” to query and control the server.
#
state_path "#{base_dir}/tmp/puma/state"

# Redirect STDOUT and STDERR to files specified. The 3rd parameter
# (“append”) specifies whether the output is appended, the default is
# “false”.
#
# stdout_redirect '/u/apps/lolcat/log/stdout', '/u/apps/lolcat/log/stderr'
stdout_redirect "#{base_dir}/log/stdout", "#{base_dir}/log/stderr", true

# Disable request logging.
#
# The default is “false”.
#
# quiet

# Configure “min” to be the minimum number of threads to use to answer
# requests and “max” the maximum.
#
# The default is “0, 16”.
#
# threads 0, 16

# Bind the server to “url”. “tcp://”, “unix://” and “ssl://” are the only
# accepted protocols.
#
# The default is “tcp://0.0.0.0:9292”.
#
# bind 'tcp://0.0.0.0:9292'
bind "unix://#{base_dir}/tmp/puma.sock"
# bind 'unix:///var/run/puma.sock?umask=0777'
# bind 'ssl://127.0.0.1:9292?key=path_to_key&cert=path_to_cert'

# Instead of “bind 'ssl://127.0.0.1:9292?key=path_to_key&cert=path_to_cert'” you
# can also use the “ssl_bind” option.
#
# ssl_bind '127.0.0.1', '9292', { key: path_to_key, cert: path_to_cert }

# Code to run before doing a restart. This code should
# close log files, database connections, etc.
#
# This can be called multiple times to add code each time.
#
# on_restart do
#   puts 'On restart...'
# end


# === Cluster mode ===

# How many worker processes to run.
#
# The default is “0”.
#
# workers 2

# Code to run when a worker boots to setup the process before booting
# the app.
#
# This can be called multiple times to add hooks.
#
# on_worker_boot do
#   puts 'On worker boot...'
# end

# === Puma control rack application ===

# Start the puma control rack application on “url”. This application can
# be communicated with to control the main server. Additionally, you can
# provide an authentication token, so all requests to the control server
# will need to include that token as a query parameter. This allows for
# simple authentication.
#
# Check out https://github.com/puma/puma/blob/master/lib/puma/app/status.rb
# to see what the app has available.
#
activate_control_app
# activate_control_app 'unix:///var/run/pumactl.sock'
# activate_control_app "unix://#{base_dir}/tmp/pumactl.sock", { auth_token: '19781115' }
# activate_control_app 'unix:///var/run/pumactl.sock', { no_token: true }