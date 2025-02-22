# frozen_string_literal: true

require 'spec_helper'

describe RubyWarrior::Abilities::Form do
  before(:each) do
    @floor = RubyWarrior::Floor.new
    @floor.width = 2
    @floor.height = 3
    @warrior = RubyWarrior::Units::Warrior.new
    @floor.add(@warrior, 0, 0, :east)
    @form = RubyWarrior::Abilities::Form.new(@warrior)
  end

  it 'should form a golem in front of warrior' do
    @form.perform
    expect(@floor.get(1, 0)).to be_kind_of(RubyWarrior::Units::Golem)
  end

  it 'should form a golem in given direction' do
    @form.perform(:right)
    expect(@floor.get(0, 1)).to be_kind_of(RubyWarrior::Units::Golem)
  end

  it "should not form golem if space isn't empty" do
    @floor.add(RubyWarrior::Units::Base.new, 1, 0)
    @form.perform(:forward)
    @form.perform(:left)
    expect(@floor.units.size).to eq(2)
  end

  it "should reduce warrior's health by half (rounding down) and give it to the golem" do
    @warrior.health = 19
    @form.perform
    expect(@warrior.health).to eq(10)
    expect(@floor.get(1, 0).max_health).to eq(9)
  end

  it "should add passed block as golem's turn block" do
    @passed = nil
    @form.perform(:forward) { |turn| @passed = turn }
    @floor.get(1, 0).play_turn(:turn)
    expect(@passed).to eq(:turn)
  end

  it 'should start in same direction as warrior' do
    @form.perform(:right)
    expect(@floor.get(0, 1).position.direction).to eq(:east)
  end
end
