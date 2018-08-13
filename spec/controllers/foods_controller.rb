require 'rails_helper'

describe FoodController do
    describe 'GET #index' do
        context 'with params[:letter]' do
            it "asd"
            it "renders the :index template"    
        end
        context 'without params[:letter]' do
            it "populates an array of all foods"
            it "renders the :index template"
        end
    end
    describe 'GET #show' do
        it "assing the requested food to #food" do
            food = create(:food)
            get :show, params: { id: food }
            expect(assigns(:food)).to eq food
        end
        it "renders the :show template" do
            food = create(:food)
            get :show, params: { id: food }
            expect(response).to render_template :show
    end
    describe 'GET #new' do
    end
    describe 'GET #edit' do
    end
    
end