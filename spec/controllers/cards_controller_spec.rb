require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  let(:admin) { create(:user, :admin) }
  let(:player) { create(:user, :player) }
  let(:card) { create(:card) }

  describe "GET #new" do
    context "as an admin" do
      before { sign_in admin }

      it "allows admin to access the new card form" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    context "as a player" do
      before { sign_in player }

      it "does not allow player to access the new card form" do
        expect {
          get :new
        }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe "POST #create" do
    context "as an admin with valid attributes" do
      before { sign_in admin }

      it "allows admin to create a new card" do
        expect {
          post :create, params: { card: attributes_for(:card) }
        }.to change(Card, :count).by(1)
      end

      it "redirects admin to the card show page after creation" do
        post :create, params: { card: attributes_for(:card) }
        expect(response).to redirect_to(card_path(Card.last))
      end
    end

    context "as an admin with invalid attributes" do
      before { sign_in admin }

      it "does not allow admin to create a new card with invalid data" do
        expect {
          post :create, params: { card: attributes_for(:card, name: nil) }
        }.to_not change(Card, :count)
      end

      it "re-renders the new card form for admin" do
        post :create, params: { card: attributes_for(:card, name: nil) }
        expect(response).to render_template(:new)
      end
    end

    context "as a player" do
      before { sign_in player }

      it "does not allow player to create a new card" do
        expect {
          post :create, params: { card: attributes_for(:card) }
        }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe "GET #edit" do
    context "as an admin" do
      before { sign_in admin }

      it "allows admin to access the edit card form" do
        get :edit, params: { id: card.id }
        expect(response).to have_http_status(:success)
      end
    end

    context "as a player" do
      before { sign_in player }

      it "does not allow player to access the edit card form" do
        expect {
          get :edit, params: { id: card.id }
        }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe "PATCH #update" do
    context "as an admin with valid attributes" do
      before { sign_in admin }

      it "allows admin to update the card" do
        patch :update, params: { id: card.id, card: { name: "Updated Name" } }
        card.reload
        expect(card.name).to eq("Updated Name")
      end

      it "redirects admin to the card show page after update" do
        patch :update, params: { id: card.id, card: { name: "Updated Name" } }
        expect(response).to redirect_to(card_path(card))
      end
    end

    context "as an admin with invalid attributes" do
      before { sign_in admin }

      it "does not allow admin to update the card with invalid data" do
        patch :update, params: { id: card.id, card: { name: nil } }
        card.reload
        expect(card.name).to_not eq(nil)
      end

      it "re-renders the edit card form for admin" do
        patch :update, params: { id: card.id, card: { name: nil } }
        expect(response).to render_template(:edit)
      end
    end

    context "as a player" do
      before { sign_in player }

      it "does not allow player to update the card" do
        expect {
          patch :update, params: { id: card.id, card: { name: "Updated Name" } }
        }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe "DELETE #destroy" do
    context "as an admin" do
      before { sign_in admin }

      it "allows admin to delete the card" do
        card
        expect {
          delete :destroy, params: { id: card.id }
        }.to change(Card, :count).by(-1)
      end

      it "redirects admin to the card index page after deletion" do
        delete :destroy, params: { id: card.id }
        expect(response).to redirect_to(cards_path)
      end
    end

    context "as a player" do
      before { sign_in player }

      it "does not allow player to delete the card" do
        expect {
          delete :destroy, params: { id: card.id }
        }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe "GET #show" do
    context "as an admin" do
      before { sign_in admin }

      it "allows admin to view the card details" do
        get :show, params: { id: card.id }
        expect(response).to have_http_status(:success)
      end
    end

    context "as a player" do
      before { sign_in player }

      it "allows player to view the card details" do
        get :show, params: { id: card.id }
        expect(response).to have_http_status(:success)
      end
    end

    context "as a guest" do
      it "allows guest to view the card details" do
        get :show, params: { id: card.id }
        expect(response).to have_http_status(:success)
      end
    end
  end
end
