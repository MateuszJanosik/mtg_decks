require 'rails_helper'

RSpec.describe DecksController, type: :controller do
  let(:admin) { create(:user, :admin) }
  let(:player) { create(:user, :player) }
  let(:other_player) { create(:user, :player) }
  let(:deck) { create(:deck, user: admin) }
  let(:player_deck) { create(:deck, user: player) }
  let(:card) { create(:card) }

  describe "GET #new" do
    context "as an admin" do
      before { sign_in admin }

      it "allows admin to access the new deck form" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    context "as a player" do
      before { sign_in player }

      it "allows player to access the new deck form" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "POST #create" do
    context "as an admin with valid attributes" do
      before { sign_in admin }

      it "allows admin to create a new deck" do
        expect {
          post :create, params: { deck: attributes_for(:deck, deck_cards_attributes: [ attributes_for(:deck_card, card_id: card.id) ]) }
        }.to change(Deck, :count).by(1)
      end

      it "redirects admin to the deck show page after creation" do
        post :create, params: { deck: attributes_for(:deck, deck_cards_attributes: [ attributes_for(:deck_card, card_id: card.id) ]) }
        expect(response).to redirect_to(deck_path(Deck.last))
      end
    end

    context "as an admin with invalid attributes" do
      before { sign_in admin }

      it "does not allow admin to create a new deck with invalid data" do
        expect {
          post :create, params: { deck: attributes_for(:deck, name: nil) }
        }.to_not change(Deck, :count)
      end

      it "re-renders the new deck form for admin" do
        post :create, params: { deck: attributes_for(:deck, name: nil) }
        expect(response).to render_template(:new)
      end
    end

    context "as a player with valid attributes" do
      before { sign_in player }

      it "allows player to create a new deck" do
        expect {
          post :create, params: { deck: attributes_for(:deck, deck_cards_attributes: [ attributes_for(:deck_card, card_id: card.id) ]) }
        }.to change(Deck, :count).by(1)
      end

      it "redirects player to the deck show page after creation" do
        post :create, params: { deck: attributes_for(:deck, deck_cards_attributes: [ attributes_for(:deck_card, card_id: card.id) ]) }
        expect(response).to redirect_to(deck_path(Deck.last))
      end
    end

    context "as a player with invalid attributes" do
      before { sign_in player }

      it "does not allow player to create a new deck with invalid data" do
        expect {
          post :create, params: { deck: attributes_for(:deck, name: nil) }
        }.to_not change(Deck, :count)
      end

      it "re-renders the new deck form for player" do
        post :create, params: { deck: attributes_for(:deck, name: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    context "as an admin" do
      before { sign_in admin }

      it "allows admin to access the edit deck form" do
        get :edit, params: { id: deck.id }
        expect(response).to have_http_status(:success)
      end
    end

    context "as a player editing their own deck" do
      before { sign_in player }

      it "allows player to access the edit form for their own deck" do
        get :edit, params: { id: player_deck.id }
        expect(response).to have_http_status(:success)
      end
    end

    context "as a player editing another user's deck" do
      before { sign_in player }

      it "does not allow player to access the edit form for another user's deck" do
        expect {
          get :edit, params: { id: deck.id }
        }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe "PATCH #update" do
    context "as an admin with valid attributes" do
      before { sign_in admin }

      it "allows admin to update the deck" do
        patch :update, params: { id: deck.id, deck: { name: "Updated Name" } }
        deck.reload
        expect(deck.name).to eq("Updated Name")
      end

      it "redirects admin to the deck show page after update" do
        patch :update, params: { id: deck.id, deck: { name: "Updated Name" } }
        expect(response).to redirect_to(deck_path(deck))
      end
    end

    context "as an admin with invalid attributes" do
      before { sign_in admin }

      it "does not allow admin to update the deck with invalid data" do
        patch :update, params: { id: deck.id, deck: { name: nil } }
        deck.reload
        expect(deck.name).to_not eq(nil)
      end

      it "re-renders the edit deck form for admin" do
        patch :update, params: { id: deck.id, deck: { name: nil } }
        expect(response).to render_template(:edit)
      end
    end

    context "as a player updating their own deck with valid attributes" do
      before { sign_in player }

      it "allows player to update their own deck" do
        patch :update, params: { id: player_deck.id, deck: { name: "Updated Name" } }
        player_deck.reload
        expect(player_deck.name).to eq("Updated Name")
      end

      it "redirects player to the deck show page after update" do
        patch :update, params: { id: player_deck.id, deck: { name: "Updated Name" } }
        expect(response).to redirect_to(deck_path(player_deck))
      end
    end

    context "as a player updating their own deck with invalid attributes" do
      before { sign_in player }

      it "does not allow player to update their own deck with invalid data" do
        patch :update, params: { id: player_deck.id, deck: { name: nil } }
        player_deck.reload
        expect(player_deck.name).to_not eq(nil)
      end

      it "re-renders the edit deck form for player" do
        patch :update, params: { id: player_deck.id, deck: { name: nil } }
        expect(response).to render_template(:edit)
      end
    end

    context "as a player updating another user's deck" do
      before { sign_in player }

      it "does not allow player to update another user's deck" do
        expect {
          patch :update, params: { id: deck.id, deck: { name: "Updated Name" } }
        }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe "DELETE #destroy" do
    context "as an admin" do
      before { sign_in admin }

      it "allows admin to delete the deck" do
        deck
        expect {
          delete :destroy, params: { id: deck.id }
        }.to change(Deck, :count).by(-1)
      end

      it "redirects admin to the deck index page after deletion" do
        delete :destroy, params: { id: deck.id }
        expect(response).to redirect_to(decks_path)
      end
    end

    context "as a player deleting their own deck" do
      before { sign_in player }

      it "allows player to delete their own deck" do
        player_deck
        expect {
          delete :destroy, params: { id: player_deck.id }
        }.to change(Deck, :count).by(-1)
      end

      it "redirects player to the deck index page after deletion" do
        delete :destroy, params: { id: player_deck.id }
        expect(response).to redirect_to(decks_path)
      end
    end

    context "as a player deleting another user's deck" do
      before { sign_in player }

      it "does not allow player to delete another user's deck" do
        expect {
          delete :destroy, params: { id: deck.id }
        }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe "GET #show" do
    context "as an admin" do
      before { sign_in admin }

      it "allows admin to view the deck details" do
        get :show, params: { id: deck.id }
        expect(response).to have_http_status(:success)
      end
    end

    context "as a player" do
      before { sign_in player }

      it "allows player to view the deck details" do
        get :show, params: { id: deck.id }
        expect(response).to have_http_status(:success)
      end
    end

    context "as a guest" do
      it "allows guest to view the deck details" do
        get :show, params: { id: deck.id }
        expect(response).to have_http_status(:success)
      end
    end
  end
end
