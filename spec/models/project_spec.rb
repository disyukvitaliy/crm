require 'rails_helper'

RSpec.describe Project, type: :model do

  # subject usage example
  #
  # subject do
  #   Project.new(title: 'Project 1', alias: 'Project 1')
  # end
  #
  # it { expect(subject.title).to eq('Project 1') }

  it { is_expected.to respond_to(:active?) }
  it { is_expected.to respond_to(:archived?) }

  describe "standart validation rules" do

    it "is valid with a title" do
      project = Project.new(title: 'Project #1')
      expect(project).to be_valid
    end

    it "is invalid without a title" do
      project = Project.new(title: '')
      project.valid?
      expect(project.errors[:title]).to include("can't be blank")
    end

    it "is invalid with no unique alias" do
      project = Project.create(title: 'title', alias: 'title')
      project = Project.new(title: 'title', alias: 'title')
      project.valid?
      expect(project.errors[:title]).to include('has already been taken')
    end

  end

  describe "transliteration" do

    it "transliterate title if alias blank" do
      project = Project.new(title: 'Проект 1')
      project.valid?
      expect(project.alias).to eq Translit.convert(project.title, :english)
    end

    it "don't transliterate title if alias presence" do
      project = Project.new(title: 'Проект 1', alias: 'custom')
      project.valid?
      expect(project.alias).to eq 'custom'
    end

  end

  describe "gem strip_attributes" do

    it "convert empty POST strings to nil before save" do
      project = Project.new(title: '', alias: '', descr: '', parent_id: '')
      project.valid?
      expect(project.as_json).to include('title' => nil, 'alias' => nil, 'descr' => nil, 'parent_id' => nil)
    end

  end

  let(:first_state) { {'parent_id' => nil, 'lft' => 1, 'rgt' => 2, 'depth' => 0} }
  let(:second_state) { {'parent_id' => nil, 'lft' => 3, 'rgt' => 4, 'depth' => 0} }
  let(:first_with_a_child_state) { {'lft' => 1, 'rgt' => 4} }
  let(:second_as_a_child_state) { {'parent_id' => @first_project.id, 'lft' => 2, 'rgt' => 3, 'depth' => 1} }

  describe "gem nested_set" do

    before :each do
      @first_project = Project.create(title: 'Project 1')
    end

    context "the first project entry is added" do
      it "set it parent_id, lft, rgt and depth to [nil,1,2,0] respectively" do
        expect(@first_project.as_json).to include(first_state)
      end
    end

    context "the second project entry is added" do
      it "set it parent_id, lft, rgt and depth to [nil,3,4,0] respectively" do
        second_project = Project.create(title: 'Project 2')
        expect(second_project.as_json).to include(second_state)
      end
    end

    context "the first edded entry have a one child" do
      it "set it lft, rgt to [1,4] respectively" do
        second_project = Project.create(title: 'Project 2', parent_id: @first_project.id)
        first_project = Project.first
        expect(first_project.as_json).to include(first_with_a_child_state)
      end
    end

    context "the second entry becomes child of the first one" do
      it "set it parent_id, lft, rgt and depth to [@first_project.id,2,3,1] respectively" do
        second_project = Project.create(title: 'Project 2', parent_id: @first_project.id)
        expect(second_project.as_json).to include(second_as_a_child_state)
      end
    end

  end

end
