require 'chefspec'

describe 'rnginx::common_packages' do
  let (:chef_run) {
    ChefSpec::ChefRunner.new(
      platform:'ubuntu', version:'12.04'
      ).converge(described_recipe)
  }

  it 'installs libpcre3' do
    expect(chef_run).to install_package 'libpcre3'
  end
  it 'installs libpcre3-dev' do
    expect(chef_run).to install_package 'libpcre3-dev'
  end
  it 'installs libssl-dev' do
    expect(chef_run).to install_package 'libssl-dev'
  end

end
