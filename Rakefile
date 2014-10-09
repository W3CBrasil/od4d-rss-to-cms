

task :default => :gem

namespace :gem do

  desc "Remove old gem files"
  task :clean do
    sh "rm -rf output"
  end

  desc "Build gem file"
  task :build => :clean do
    sh "mkdir output"
    sh "gem build rss-to-cms.gemspec"
    sh "mv rss-to-cms*.gem output/"
  end

  desc "Uninstall gem"
  task :uninstall do
    sh "sudo gem uninstall -x rss-to-cms"
  end

  desc "Install gem"
  task :install => [:uninstall, :build] do
    sh "sudo gem install output/rss-to-cms*.gem"
  end

end

namespace :deploy do

  def deploy(server)
    command = <<-eos
      cd /tmp
      gem uninstall -x rss-to-cms
      gem install rss-to-cms --install-dir ~/.gem
      rm rss-to-cms*.gem
    eos

    verify_package_exist
    configure_deploy_ssh_key(server)
    sh "scp output/rss-to-cms*.gem od4d@#{server}:/tmp"
    sh "ssh od4d@#{server} \"#{command}\""
  end

  def verify_package_exist
    raise "Gem file not found. Please run 'rake gem:build' to generate gem file." if Dir.glob('output/rss-to-cms*.gem').empty?
  end

  def configure_deploy_ssh_key(server)
    command = <<-eos
      echo "$DEPLOY_SSH_KEY" > ~/.ssh/deploy-key
      chmod 0600 ~/.ssh/deploy-key
      printf "\nHost #{server}\nUserKnownHostsFile /dev/null\nIdentityFile ~/.ssh/deploy-key\n" >> $HOME/.ssh/config
    eos
    sh command if ENV['CI']
  end

  def get_server_from_env_variable(name)
    fail "Please set the server address using the environment variable #{name}" if ENV[name].to_s.empty?
    ENV[name]
  end

  desc "Deploy to localhost"
  task :local => "gem:install"

  desc "Deploy to test environment"
  task :test do
    deploy("app-server.dev")
  end

  desc "Deploy to staging environment"
  task :staging do
    server = get_server_from_env_variable('OD4D_STAGING_SERVER')
    deploy(server)
  end

  desc "Deploy to production environment"
  task :production do
    server = get_server_from_env_variable('OD4D_PROD_SERVER')
    deploy(server)
  end

end