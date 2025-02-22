# frozen_string_literal: true

require 'spec_helper'

describe RubyWarrior::Abilities::Explode do
  before(:each) do
    @floor = RubyWarrior::Floor.new
    @floor.width = 2
    @floor.height = 3
    @captive = RubyWarrior::Units::Captive.new
    @floor.add(@captive, 0, 0)
    @explode = RubyWarrior::Abilities::Explode.new(@captive)
  end

  it 'should subtract 100 health from each unit on the floor' do
    unit = RubyWarrior::Units::Base.new
    unit.health = 20
    @floor.add(unit, 0, 1)
    @captive.health = 10
    @explode.perform
    expect(@captive.health).to eq(-90)
    expect(unit.health).to eq(-80)
  end

  it 'should explode when bomb time reaches zero' do
    @captive.health = 10
    @explode.time = 3
    @explode.pass_turn
    @explode.pass_turn
    expect(@captive.health).to eq(10)
    @explode.pass_turn
    expect(@captive.health).to eq(-90)
  end
end
