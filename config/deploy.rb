set :application, "tic_tac_toe_web"
set :repo_url, "git@github.com:ranizilpelwar/tic_tac_toe_web.git"
set :deploy_to, "/var/www/html"
set :ssh_options, {
  forward_agent: true,
  auth_methods: %w[publickey],
  keys: %w[/Users/ranizilpelwar/documents/github/tic_tac_toe_web/InstanceKeyPair.pem]
}
set :default_env, { path: "/usr/local/bin:$PATH" }
