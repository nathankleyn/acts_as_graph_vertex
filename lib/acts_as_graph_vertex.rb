# frozen_string_literal: true

# A mixin module enabling classes to have parents and children. It provides
# convenience methods for determining dependencies, and depdenants.
#
# Note that in contrast to a tree, this graph module allows multiple parents.
module ActsAsGraphVertex
  # The self.included idiom. This is described in great detail in a
  # fantastic blog post here:
  #
  # http://www.railstips.org/blog/archives/2009/05/15/include-vs-extend-in-ruby/
  #
  # Basically, this idiom allows us to add both instance *and* class methods
  # to the class that is mixing this module into itself without forcing them
  # to call extend and include for this mixin. You'll see this idiom everywhere
  # in the Ruby/Rails world, so we use it too.
  def self.included(cls)
    cls.extend(ClassMethods)
  end

  # Common methods inherited by all classes
  module ClassMethods
    attr_writer :parents, :children
  end

  # Public: The parents linked to this instance.
  #
  # Returns an Array of Objects.
  def parents
    @parents ||= []
  end

  # Public: The children linked to this instance.
  #
  # Returns an Array of Objects.
  def children
    @children ||= []
  end

  # Public: Add a vertex to the parents linked to this instance. Will automatically add as a child of the given parent
  # if the given parent also mixes in the graph functionality.
  #
  # vertex - The Object to add as a parent.
  # add_child - Whether to add this item as a child of the given parent.
  def add_parent(vertex, add_child = true)
    return if parents.include?(vertex)

    vertex.add_child(self, false) if add_child && vertex.respond_to?(:add_child)
    parents << vertex
  end

  # Public: Add a vertex to the children linked to this instance. Will automatically add as a parent of the given child
  # if the given child also mixes in the graph functionality.
  #
  # vertex - The Object to add as a child.
  # add_parent - Whether to add this item as a parent of the given child.
  def add_child(vertex, add_parent = true)
    return if children.include?(vertex)

    vertex.add_parent(self, false) if add_parent && vertex.respond_to?(:add_parent)
    children << vertex
  end

  # Public: Convenience method to return all of the parents from this vertex in
  # the tree upwards to the root of the tree.
  #
  # Returns an Array of parent Objects.
  def all_parents
    (parents + parents.map(&:all_parents)).flatten.uniq
  end

  # Public: Convenience method to return all of the children from this vertex in
  # the tree downwards to the leaves of the tree.
  #
  # Returns an Array of child Objects.
  def all_children
    (children + children.map(&:all_children).flatten).uniq
  end
end
