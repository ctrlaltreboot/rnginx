require 'chefspec'

describe 'rnginx::binary' do
  let (:chef_run) {
    ChefSpec::ChefRunner.new(
      platform:'ubuntu', version:'12.04'
      ).converge(described_recipe)
  }

  it 'installs nginx' do
    expect(chef_run).to install_package 'nginx'
  end

end
