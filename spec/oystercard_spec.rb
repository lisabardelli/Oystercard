require 'rspec'
require './lib/oystercard.rb'

describe Oystercard do
    let(:card){Oystercard.new}
  it "is created with a default balance of zero" do
    expect(card.balance).to eq(0)
  end

  describe "#top_up" do
    it "returns updated balance after calling top_up method" do
        card.top_up(20)
        expect(card.balance).to eq(20)
    end
    it "returns an error if top-up will exceed MAXIMUM_BALANCE" do
      expect {card.top_up(Oystercard::MAXIMUM_BALANCE + 1)}.to raise_error("Cannot exeed max balance (#{Oystercard::MAXIMUM_BALANCE})!")
    end
  end
  describe "#deduct" do
    it "deducts amount of money from balance" do
        card.top_up(20)
        card.deduct(5)
        expect(card.balance).to eq(15)
    end
  end
  describe "#touch_in" do
    it "changes the state of the card to 'in_journey' " do
      card.touch_in
      expect(card.in_journey).to eq(true)
    end
  end
  describe "#touch_out" do
    it "changes the state of the card to 'not_in_journey'" do
      card.touch_out
      expect(card.in_journey).to eq(false)
    end
  end
  describe "#in_journey?" do
    it "returns true for an 'in' card" do
      card.touch_in
      expect(card.in_journey).to be(true)
    end
    it "returns false for an 'out' card" do
      card.touch_out
      expect(card.in_journey).to be(false)
    end
  end
end
