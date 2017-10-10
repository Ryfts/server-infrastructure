#
# Cookbook:: ryfts
# Recipe:: default
#
# Copyright:: 2017, Dino Lukman, All Rights Reserved.

include_recipe 'ryfts::bootstrap'
include_recipe 'ryfts::nginx'
include_recipe 'ryfts::certificate'
include_recipe 'ryfts::mongodb'
include_recipe 'ryfts::bitcoin'