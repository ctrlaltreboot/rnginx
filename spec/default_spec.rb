require 'chefspec'

describe 'rnginx::default' do
  nginx_version = "1.4.2"
  nginx_install_dir = "/opt"

  let (:chef_run) {
    ChefSpec::ChefRunner.new(
      platform:'ubuntu', version:'12.04'

      ).converge(described_recipe)
  }

  it 'includes common_packages recipe' do
    expect(chef_run).to include_recipe "#{described_cookbook}::common_packages"
  end

  it 'downloads nginx' do
    expect(chef_run).to create_remote_file("/tmp/nginx-#{nginx_version}.tar.gz").with(
      source: "http://nginx.org/download/nginx-#{nginx_version}.tar.gz"
    )    
  end

# it 'untars nginx source' do
#   expect(chef_run).to execute_command("tar xzf /tmp/nginx-#{nginx_version}.tar.gz -C /tmp")
# end

  it 'should create nginx init script from template' do
    expect(chef_run).to create_file '/etc/init.d/nginx'
    init_file = chef_run.template('/etc/init.d/nginx')
    expect(init_file).to be_owned_by('root', 'root')
    expect(init_file.source).to eq('nginx.init.erb')
  end

  it 'should enable and start the nginx service' do
    expect(chef_run).to set_service_to_start_on_boot 'nginx'
  end
   
  it 'should start the nginx service' do
    expect(chef_run).to start_service 'nginx'
  end
 
  delete_default = %w(nginx.conf.default fastcgi.conf.default fastcgi_params.conf.default uwsgi_params.default scgi_params.default nginx.conf)
  delete_default.each do |me| 
    it 'should delete #{me}' do
      expect(chef_run).to delete_file "#{nginx_install_dir}/nginx-#{nginx_version}/conf/#{me}" 
    end
  end
  
  conf_dirs = %w(conf.d vhosts)
  conf_dirs.each do |confdir|
    it "should create the #{confdir} directory" do
      expect(chef_run).to create_directory "#{nginx_install_dir}/nginx-#{nginx_version}/conf/#{confdir}"
    end
  end

  it 'should create a new nginx.conf from template and restart nginx' do
    expect(chef_run).to create_file "#{nginx_install_dir}/nginx-#{nginx_version}/conf/nginx.conf"
    conf_file = chef_run.template("#{nginx_install_dir}/nginx-#{nginx_version}/conf/nginx.conf")
    expect(conf_file).to be_owned_by('root', 'root')
    expect(conf_file.source).to eq('nginx.conf.erb')
    expect(conf_file).to notify 'service[nginx]', :restart
  end

end
