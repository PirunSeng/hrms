describe 'Position' do
  let(:user) { create(:user) }
  let!(:position){ create(:position, title: 'HR') }
  before do
    login_as(user)
  end

  feature 'List' do
    before do
      visit positions_path
    end

    scenario 'title' do
      expect(page).to have_content('HR')
    end

    scenario 'new link' do
      expect(page).to have_link('Add new position', new_position_path)
    end

    scenario 'edit link' do
      expect(page).to have_link('Edit', edit_position_path(position))
    end

    scenario 'delete link' do
      expect(page).to have_css("a[href='#{position_path(position)}'][data-method='delete']")
    end
  end

  feature 'Show' do
    before { visit position_path(position) }

    scenario 'title' do
      expect(page).to have_content('HR')
    end
  end

  feature 'Create' do
    before { visit new_position_path }
    it 'success' do
      fill_in 'Title', with: 'Development'
      click_button 'Create'
      expect(page).to have_content('Position detail')
      expect(page).to have_content('Development')
    end

    it 'failed' do
      click_button 'Create'
      expect(page).to have_content('New Position')
    end
  end

  feature 'Update' do
    before { visit edit_position_path(position) }
    it 'success' do
      fill_in 'Title', with: 'Management'
      click_button 'Update'
      expect(page).to have_content('Position detail')
      expect(page).to have_content('Management')
    end

    it 'failed' do
      fill_in 'Title', with: ''
      click_button 'Update'
      expect(page).to have_content('Edit Position')
    end
  end

  feature 'Destroy' do
    before { visit positions_path }
    it 'success' do
      find("a[href='#{position_path(position)}'][data-method='delete']").click
      expect(page).not_to have_content('HR')
      expect(page).not_to have_content(position.title)
    end
  end
end
