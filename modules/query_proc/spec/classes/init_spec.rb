require 'spec_helper'
describe 'query_proc' do
  context 'with default values for all parameters' do
    it { should contain_class('query_proc') }
  end
end
