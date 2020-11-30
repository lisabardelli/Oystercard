require 'rspec'
require './lib/oystercard.rb'

describe Oystercard do

  it "is created with a default balance of zero" do
    expect(subject.balance).to eq(0)
  end
  describe "#top_up" do
    it "returns updated balance after calling top_up method" do
        card = Oystercard.new
        card.top_up(20)
        expect(card.balance).to eq(20)
    end
  end 
end
