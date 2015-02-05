require 'spec_helper'
require 'acts_as_graph_vertex'

RSpec.describe(ActsAsGraphVertex) do
  let(:test_class) do
    Class.new do
      attr_reader :name

      def initialize(name)
        @name = name
      end

      def inspect
        {
          name: name,
          parents: parents.map(&:name),
          children: children.map(&:name)
        }.inspect
      end
    end
  end
  let(:test_class_with_graph_mixin) { test_class.tap { |c| c.include(described_class) } }
  let(:parent) { test_class_with_graph_mixin.new('parent') }
  let(:child1) { test_class_with_graph_mixin.new('child1') }
  let(:child2) { test_class_with_graph_mixin.new('child2') }
  let(:child3) { test_class_with_graph_mixin.new('child3') }
  let(:child4) { test_class_with_graph_mixin.new('child4') }

  before do
    parent.add_child(child1)
    child2.add_parent(parent)
    child3.add_parent(child1)
    child3.add_parent(child2)
  end

  describe('#parents') do
    it('returns the array of parents') do
      expect(child3.parents).to eql([child1, child2])
    end
  end

  describe('#children') do
    it('returns the array of children') do
      expect(parent.children).to eql([child1, child2])
    end
  end

  describe('#add_parent') do
    it('does nothing if the parent is already in the array of parents') do
      child1.add_parent(parent)

      expect(child1.instance_variable_get(:@parents)).to eql([parent])
    end

    it('adds the given parent to the array of parents') do
      child4.add_parent(child3)

      expect(child4.instance_variable_get(:@parents)).to eql([child3])
    end

    it('adds the current vertex as a child to the given parent if add_child is true') do
      child4.add_parent(child3)

      expect(child3.instance_variable_get(:@children)).to eql([child4])
    end

    it('does not add the current vertex as a child to the given parent if add_child is false') do
      child4.add_parent(child3, false)

      expect(child3.instance_variable_get(:@children)).to eql(nil)
    end
  end

  describe('#add_child') do
    it('does nothing if the child is already in the array of childs') do
      parent.add_child(child1)

      expect(parent.instance_variable_get(:@children)).to eql([child1, child2])
    end

    it('adds the given child to the array of childen') do
      child3.add_child(child4)

      expect(child3.instance_variable_get(:@children)).to eql([child4])
    end

    it('adds the current vertex as a parent to the given child if add_parent is true') do
      child3.add_child(child4)

      expect(child4.instance_variable_get(:@parents)).to eql([child3])
    end

    it('does not add the current vertex as a parent to the given parent if add_parent is false') do
      child3.add_child(child4, false)

      expect(child4.instance_variable_get(:@parents)).to eql(nil)
    end
  end

  describe('#all_parents') do
    it('returns a list of all of the unique parents above this vertex after traversing the graph') do
      expect(child3.all_parents).to eql([child1, child2, parent])
    end
  end

  describe('#all_children') do
    it('returns a list of all of the unique children below this vertex after traversing the graph') do
      expect(parent.all_children).to eql([child1, child2, child3])
    end
  end
end
