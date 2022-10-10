# encoding: utf-8
# copyright: 2018, The Authors

title 'terraform validation'

control 'terraform' do
  impact 1
  title 'Run terraform validate'

  describe file('terraform/terraform.tfvars.example') do
    it { should exist }
  end

  describe command('cd terraform && terraform init && terraform validate -no-color') do
    its('stdout') { should match "Success! The configuration is valid." }
    its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end

  describe command('cd terraform && tflint --var-file=terraform.tfvars.example') do
    its('stdout') { should match "" }
    its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end
end
