require 'chefspec'

describe 'rnginx::proxy' do
  let (:chef_run) {
    ChefSpec::ChefRunner.new(
      platform:'ubuntu', version:'12.04'
      ).converge(described_recipe)
  }
  
  nginx_version = "1.4.2"
  nginx_dir = "/opt/nginx-#{nginx_version}"

  it 'includes rnginx::default recipe' do
    expect(chef_run).to include_recipe "#{described_cookbook}::default"
  end

  context "#nginx_optimize (definition)" do
    it 'creates an optimized site config from template' do
      expect(chef_run).to create_file "#{nginx_dir}/conf/conf.d/optimize.conf"
      optimize_conf = chef_run.template("#{nginx_dir}/conf/conf.d/optimize.conf")
      expect(optimize_conf).to be_owned_by('root', 'root')
      expect(optimize_conf.source).to eq('optimize.conf.erb')
      expect(optimize_conf).to notify 'service[nginx]', :restart
    end
  end
  
end
