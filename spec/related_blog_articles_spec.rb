require 'spec_helper'
require 'related_blog_articles'

class BlogData
  attr_reader :authors, :tags

  def initialize(authors: nil, tags: nil)
    @authors = authors
    @tags = tags
  end

  # def ==(other)
  #   self.author == other.author && self.tags == other.tags
  # end
end

RSpec.describe RelatedBlogArticles do
  describe '.weight' do
    describe 'authors' do
      it 'has the maximum author weighting when authors are the same' do
        current_article = BlogData.new(authors: ['A'], tags: [])
        other_article = BlogData.new(authors: ['A'], tags: [])
        expect(described_class.new(current_article, other_article).weight).to eq 1.0
      end

      it 'has the maximum author weighting when multiple authors are the same' do
        current_article = BlogData.new(authors: ['A', 'B'], tags: [])
        other_article = BlogData.new(authors: ['A', 'B'], tags: [])
        expect(described_class.new(current_article, other_article).weight).to eq 1.0
      end

      it 'has no author weighting when authors are different' do
        current_article = BlogData.new(authors: ['A'], tags: [])
        other_article = BlogData.new(authors: ['B'], tags: [])
        expect(described_class.new(current_article, other_article).weight).to eq 0.0
      end

      it 'has no author weighting when there are no authors' do
        current_article = BlogData.new(tags: [])
        other_article = BlogData.new(tags: [])
        expect(described_class.new(current_article, other_article).weight).to eq 0.0
      end

      it 'has a 50% author weighting when authors are similar by a half' do
        current_article = BlogData.new(authors: ['A', 'C'])
        other_article = BlogData.new(authors: ['B', 'A'])
        expect(described_class.new(current_article, other_article).weight).to eq 0.5
      end
    end

    describe 'tags' do
      it 'has the maximum tag weighting when tags are exactly the same' do
        current_article = BlogData.new(authors: ['A'], tags: ['A'])
        other_article = BlogData.new(authors: ['B'], tags: ['A'])
        expect(described_class.new(current_article, other_article).weight).to eq 1.0
      end

      it 'has a 50% tag weighting when tags are similar by a half' do
        current_article = BlogData.new(authors: ['A'], tags: ['A', 'B'])
        other_article = BlogData.new(authors: ['B'], tags: ['A', 'C'])
        expect(described_class.new(current_article, other_article).weight).to eq 0.5
      end

      it 'has no tag weighting when tags are different' do
        current_article = BlogData.new(authors: ['A'], tags: ['A'])
        other_article = BlogData.new(authors: ['B'], tags: ['B'])
        expect(described_class.new(current_article, other_article).weight).to eq 0.0
      end

      it 'has no tag weighting when tags are not present' do
        current_article = BlogData.new(authors: ['A'])
        other_article = BlogData.new(authors: ['B'], tags: [])
        expect(described_class.new(current_article, other_article).weight).to eq 0.0
      end
    end
  end
end