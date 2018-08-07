require 'rails_helper'

describe Food do
    it "is valid with a name and description" do
        food = Food.new(
            name: "Nasi Uduk",
            description: "asd",
            price: 20000.00
        )
        expect(food).to be_valid
    end
    it "is invalid without a name" do
        food = Food.new(
            name: nil,
            description: "asd",
            price: 10000.00
        )
        food.valid?
        expect(food.errors[:name]).to include("name cant be blank")
    end
    it "is invalid without a description" do
        food = Food.new(
            name: "asd",
            description: nil,
            price: 30000.00
        )
        food.valid?
        expect(food.errors[:description]).to include("description cant be blank")
    end
    it "is invalid without a duplicate name" do
        food1 = Food.create(
            name: "nasi uduk",
            description: "Asd",
            price: 10000.00
        )
        food2 = Food.new(
            name: "nasi uduk",
            description: "asd",
            price: 10000.00
        )
        food2.valid?
        expect(food2.errors[:name].to include("has already taken"))
    end
    it "return a sorted array of results that match" do
        food1 = Food.create(
            name: "nasi uduk",
            description: "asd",
            price: 10000.00
        )
        food2 = Food.create(
            name: "kerak telor",
            description: "asd",
            price: 20000.00
        )
        food3 = Food.create(
            name: "nasi semur jengkol",
            description: "asd",
            price: 8000.00
        )
        expect(Food.by_letter("N")).to eq([food3, food1])
    end
    it "omits result that do not match" do
        food1 = Food.create(
            name: "nasi uduk",
            description: "asd",
            price: 10000.00
        )
        food2 = Food.create(
            name: "kerak telor",
            description: "asd",
            price: 20000.00
        )
        food3 = Food.create(
            name: "nasi semur jengkol",
            description: "asd",
            price: 8000.00
        )
        expect(Food.by_letter("N")).not_to include(food2)
    end
end