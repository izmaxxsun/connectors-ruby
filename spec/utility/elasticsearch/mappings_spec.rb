# frozen_string_literal: true

#
# Copyright Elasticsearch B.V. and/or licensed to Elasticsearch B.V. under one
# or more contributor license agreements. Licensed under the Elastic License;
# you may not use this file except in compliance with the Elastic License.
#

require 'spec_helper'
require 'utility/elasticsearch/index/mappings'

describe Utility::Elasticsearch::Index::Mappings do
  describe '#default_text_fields_mappings' do
    subject { Utility::Elasticsearch::Index::Mappings.default_text_fields_mappings(connectors_index: connectors_index) }

    context 'when the index is a search index' do
      let(:connectors_index) { true }

      it { is_expected.to be_kind_of(Hash) }
      it { is_expected.to include(dynamic: true, dynamic_templates: Array, properties: Hash) }
      it { is_expected.to include(properties: { id: Hash, _subextracted_as_of: Hash, _subextracted_version: Hash }) }
    end

    context 'when the index is not a search index' do
      let(:connectors_index) { false }

      it { is_expected.to be_kind_of(Hash) }
      it { is_expected.to include(dynamic: true, dynamic_templates: Array, properties: Hash) }
      it { is_expected.not_to include(properties: { id: Hash, _subextracted_as_of: Hash, _subextracted_version: Hash }) }
    end
  end
end
