require 'chefspec'

describe 'rnginx::default_site' do
  let (:chef_run) {
    ChefSpec::ChefRunner.new(
      platform:'ubuntu', version:'12.04'
      ).converge(described_recipe)
  }
  
  nginx_version = "1.4.2"
  nginx_dir = "/opt/nginx-#{nginx_version}"
  www_default = "/var/www/default"

  it 'includes rnginx::default recipe' do
    expect(chef_run).to include_recipe "#{described_cookbook}::default"
  end

  it 'creates a default site config from template' do
    expect(chef_run).to create_file "#{nginx_dir}/conf/vhosts/default.conf"
    default_site = chef_run.template("#{nginx_dir}/conf/vhosts/default.conf")
    expect(default_site).to be_owned_by('root', 'root')
    expect(default_site.source).to eq('default.conf.erb')
  end
  
  it "creates the #{www_default} directory" do
    expect(chef_run).to create_directory "#{www_default}"
    directory = chef_run.directory("#{www_default}")
    expect(directory).to be_owned_by('www-data', 'www-data')
  end
  
  it 'creates a dummy index.html for testing' do
    expect(chef_run).to create_file "#{www_default}/index.html"
    index = chef_run.cookbook_file("#{www_default}/index.html")
    expect(index).to be_owned_by('www-data', 'www-data')
    expect(index.source).to eq('index.html')
  end

end
