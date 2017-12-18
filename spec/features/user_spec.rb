describe 'User' do
  let(:user) { create(:user, email: 'test@example.com') }
  let!(:employee){ create(:user, name: 'Pirun') }
  before do
    login_as(user)
  end

  feature 'List' do
    before do
      visit users_path
    end

    scenario 'name' do
      expect(page).to have_content('Pirun')
    end

    scenario 'new link' do
      expect(page).to have_link('Add new employee', new_user_path)
    end

    scenario 'edit link' do
      expect(page).to have_link('Edit', edit_user_path(employee))
    end

    scenario 'delete link' do
      expect(page).to have_css("a[href='#{user_path(employee)}'][data-method='delete']")
    end
  end

  feature 'Show' do
    before { visit user_path(employee) }

    scenario 'name' do
      expect(page).to have_content('Pirun')
    end
  end

  feature 'Create' do
    let(:password) { (('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a).sample(8).join }
    before { visit new_user_path }
    it 'success' do
      fill_in 'Name', with: 'Pirun Seng'
      fill_in 'Email', with: FFaker::Internet.email
      fill_in 'Phone', with: FFaker::PhoneNumber.short_phone_number
      fill_in 'Address', with: FFaker::Address.city
      fill_in 'Salary', with: 300
      fill_in 'Password', with: password
      fill_in 'Password confirmation', with: password
      click_button 'Create'
      expect(page).to have_content('Employee detail')
      expect(page).to have_content('Pirun Seng')
    end

    context 'failed' do
      it 'as blank' do
        click_button 'Create'
        expect(page).to have_content('New Employee')
        expect(page).to have_content("can't be blank", count: 5)
      end

      it 'as duplicate email' do
        fill_in 'Email', with: 'test@example.com'
        click_button 'Create'
        expect(page).to have_content('New Employee')
        expect(page).to have_content("has already been taken", count: 1)
      end
    end
  end

  feature 'Update' do
    before { visit edit_user_path(employee) }
    it 'success' do
      fill_in 'Name', with: 'Seng'
      # fill_in 'Current password', with: '123456789'
      # fill_in 'Password', with: '123456789'
      click_button 'Update'
      expect(page).to have_content('Employee detail')
      expect(page).to have_content('Seng')
    end

    it 'failed' do
      fill_in 'Name', with: ''
      click_button 'Update'
      expect(page).to have_content('Edit Employee')
    end
  end

  feature 'Destroy' do
    before { visit users_path }
    it 'success' do
      find("a[href='#{user_path(employee)}'][data-method='delete']").click
      expect(page).not_to have_content('Pirun')
      expect(page).not_to have_content(employee.name)
    end
  end
end
