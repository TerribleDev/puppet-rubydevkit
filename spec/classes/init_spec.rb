require 'spec_helper'
describe 'rubydevkit' do

  context 'with defaults for all parameters' do
    it { should contain_class('rubydevkit') }
  end
end
