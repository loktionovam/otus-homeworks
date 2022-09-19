# encoding: utf-8
# copyright: 2018, The Authors

title 'packer validation'

control 'packer' do
  impact 1
  title 'Run packer validate'

  files = [
    'packer/app.json',
    'packer/db.json',
    'packer/variables.json.example',
    'ansible/packer_app.yml',
    'ansible/packer_db.yml',
  ]

  files.each do |path|
    describe file(path) do
      it { should exist }
      its('content') { should match(%r{\n\Z}) }
    end
  end

  describe command('packer validate -var-file=packer/variables.json.example packer/app.json') do
    its('stdout') { should eq "The configuration is valid.\n" }
    its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end

  describe command('packer validate -var-file=packer/variables.json.example packer/db.json') do
    its('stdout') { should eq "The configuration is valid.\n" }
    its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end
end
