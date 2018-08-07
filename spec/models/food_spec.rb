require 'rails_helper'

describe Food do
    it "has a valid factory" do
        expect(FactoryGirl.build(:food)).to be_valid
    end
    it "is valid with a name and description" do
        expect(FactoryGirl.build(:food)).to be_valid
    end

    it "is invalid without a name" do
        food = FactoryGirl.build(:food, name: nil)
        food.valid?
        expect(food.errors[:name]).to include("can't be blank")
    end

    it "is invalid without a description" do
        food = FactoryGirl.build(:food, description: nil)
        food.valid?
        expect(food.errors[:description]).to include("can't be blank")
    end

    it "is invalid with a duplicate name" do
        food1 = FactoryGirl.create(:food, name: "nasi uduk")
        food2 = FactoryGirl.build(:food, name: "nasi uduk")
        food2.valid?
        expect(food2.errors[:name]).to include("has already been taken")
    end

    it "returns a sorted array of results that match" do
        food1 = Food.create(
        name: "Nasi Uduk",
        description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
        price: 10000.0
        )

        food2 = Food.create(
        name: "Kerak Telor",
        description: "Betawi traditional spicy omelette made from glutinous rice cooked with egg and served with serundeng.",
        price: 8000.0
        )

        food3 = Food.create(
        name: "Nasi Semur Jengkol",
        description: "Based on dongfruit, this menu promises a unique and delicious taste with a small hint of bitterness.",
        price: 8000.0
        )

        expect(Food.by_letter("N")).to eq([food3, food1])
    end

    it "omits results that do not match" do
        food1 = Food.create(
        name: "Nasi Uduk",
        description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
        price: 10000.0
        )

        food2 = Food.create(
        name: "Kerak Telor",
        description: "Betawi traditional spicy omelette made from glutinous rice cooked with egg and served with serundeng.",
        price: 8000.0
        )

        food3 = Food.create(
        name: "Nasi Semur Jengkol",
        description: "Based on dongfruit, this menu promises a unique and delicious taste with a small hint of bitterness.",
        price: 8000.0
        )

        expect(Food.by_letter("N")).not_to include(food2)
    end

    describe "filter name by letter" do
        before :each do
        @food1 = Food.create(
            name: "Nasi Uduk",
            description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
            price: 10000.0
        )

        @food2 = Food.create(
            name: "Kerak Telor",
            description: "Betawi traditional spicy omelette made from glutinous rice cooked with egg and served with serundeng.",
            price: 8000.0
        )

        @food3 = Food.create(
            name: "Nasi Semur Jengkol",
            description: "Based on dongfruit, this menu promises a unique and delicious taste with a small hint of bitterness.",
            price: 8000.0
        )
        end

        context "with matching letters" do
            it "returns a sorted array of results that match" do
                expect(Food.by_letter("N")).to eq([@food3, @food1])
            end
        end

        context "with non-matching letters" do
            it "omits results that do not match" do
                expect(Food.by_letter("N")).not_to include(@food2)
            end
        end
    end
end

