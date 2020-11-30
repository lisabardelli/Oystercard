require 'rspec'
require './lib/oystercard.rb'

describe Oystercard do

  it "is created with a default balance of zero" do
    expect(subject.balance).to eq(0)
  end
  
end
