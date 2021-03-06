require 'helper'
require 'sequel'

Sequel::Model.db =  Sequel.sqlite(':memory:')
Sequel.extension :migration, :core_extensions

require 'flipper/adapters/sequel'
require 'generators/flipper/templates/sequel_migration'
require 'flipper/spec/shared_adapter_specs'

RSpec.describe Flipper::Adapters::Sequel do
  subject do
    described_class.new(feature_class: feature_class,
                        gate_class: gate_class)
  end

  let(:feature_class) { Flipper::Adapters::Sequel::Feature }
  let(:gate_class) { Flipper::Adapters::Sequel::Gate }

  before(:each) do
    CreateFlipperTablesSequel.new(Sequel::Model.db).up
    feature_class.dataset = feature_class.dataset
    gate_class.dataset = gate_class.dataset
  end

  after(:each) do
    CreateFlipperTablesSequel.new(Sequel::Model.db).down
  end

  it_should_behave_like 'a flipper adapter'
end
