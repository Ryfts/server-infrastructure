#
# Cookbook:: ryfts
# Spec:: default
#
# Copyright:: 2017, Dino Lukman, All Rights Reserved.

require 'spec_helper'

describe 'ryfts::default' do
  context 'When all attributes are default, on an Ubuntu 16.04' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
