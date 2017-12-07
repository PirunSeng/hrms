describe 'Home' do
  let!(:user){ create(:user) }

  feature 'login' do
    scenario 'failed' do
      visit root_path
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end

    scenario 'success' do
      login_as(user)
      visit root_path
      expect(page).not_to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
