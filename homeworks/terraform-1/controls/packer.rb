# encoding: utf-8
# copyright: 2018, The Authors

title 'packer validation'

control 'packer' do
  impact 1
  title 'Run packer validate'

  describe file('packer/ubuntu16.json') do
    it { should exist }
  end

  describe file('packer/variables.json.example') do
    it { should exist }
  end

  describe command('cd packer && packer validate -var-file=variables.json.example ubuntu16.json') do
    its('stdout') { should eq "The configuration is valid.\n" }
    its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end
end
