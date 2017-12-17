describe 'Applicant' do
  let(:user) { create(:user) }
  let!(:applicant){ create(:applicant, name: 'Pirun') }
  before do
    login_as(user)
  end

  feature 'List' do
    before do
      visit applicants_path
    end

    scenario 'name' do
      expect(page).to have_content('Pirun')
    end

    scenario 'new link' do
      expect(page).to have_link('Add new applicant', new_applicant_path)
    end

    scenario 'edit link' do
      expect(page).to have_link('Edit', edit_applicant_path(applicant))
    end

    scenario 'delete link' do
      expect(page).to have_css("a[href='#{applicant_path(applicant)}'][data-method='delete']")
    end
  end

  feature 'Show' do
    before { visit applicant_path(applicant) }

    scenario 'name' do
      expect(page).to have_content('Pirun')
    end
  end

  feature 'Create' do
    before { visit new_applicant_path }
    it 'success' do
      fill_in 'Name', with: 'Pirun Seng'
      fill_in 'Email', with: FFaker::Internet.email
      fill_in 'Phone', with: FFaker::PhoneNumber.short_phone_number
      click_button 'Create'
      expect(page).to have_content('Applicant detail')
      expect(page).to have_content('Pirun Seng')
    end

    it 'failed' do
      click_button 'Create'
      expect(page).to have_content('New Applicant')
      expect(page).to have_content("can't be blank", count: 3)
    end
  end

  feature 'Update' do
    before { visit edit_applicant_path(applicant) }
    it 'success' do
      fill_in 'Name', with: 'Seng'
      click_button 'Update'
      expect(page).to have_content('Applicant detail')
      expect(page).to have_content('Seng')
    end

    it 'failed' do
      fill_in 'Name', with: ''
      click_button 'Update'
      expect(page).to have_content('Edit Applicant')
    end
  end

  feature 'Destroy' do
    before { visit applicants_path }
    it 'success' do
      find("a[href='#{applicant_path(applicant)}'][data-method='delete']").click
      expect(page).not_to have_content('Pirun')
      expect(page).not_to have_content(applicant.name)
    end
  end
end
