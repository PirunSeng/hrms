describe 'Department' do
  let(:user) { create(:user) }
  let!(:department){ create(:department, name: 'HR') }
  before do
    login_as(user)
  end

  feature 'List' do
    before do
      visit departments_path
    end

    scenario 'name' do
      expect(page).to have_content('HR')
    end

    scenario 'new link' do
      expect(page).to have_link('Add new department', new_department_path)
    end

    scenario 'edit link' do
      expect(page).to have_link('Edit', edit_department_path(department))
    end

    scenario 'delete link' do
      expect(page).to have_css("a[href='#{department_path(department)}'][data-method='delete']")
    end
  end

  feature 'Show' do
    before { visit department_path(department) }

    scenario 'name' do
      expect(page).to have_content('HR')
    end
  end

  feature 'Create' do
    before { visit new_department_path }
    it 'success' do
      fill_in 'Name', with: 'Development'
      click_button 'Create'
      expect(page).to have_content('Department detail')
      expect(page).to have_content('Development')
    end

    it 'failed' do
      click_button 'Create'
      expect(page).to have_content('New Department')
    end
  end

  feature 'Update' do
    before { visit edit_department_path(department) }
    it 'success' do
      fill_in 'Name', with: 'Management'
      click_button 'Update'
      expect(page).to have_content('Department detail')
      expect(page).to have_content('Management')
    end

    it 'failed' do
      fill_in 'Name', with: ''
      click_button 'Update'
      expect(page).to have_content('Edit Department')
    end
  end

  feature 'Destroy' do
    before { visit departments_path }
    it 'success' do
      find("a[href='#{department_path(department)}'][data-method='delete']").click
      expect(page).not_to have_content('HR')
      expect(page).not_to have_content(department.name)
    end
  end
end
