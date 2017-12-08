describe 'Home' do
  feature 'Home page' do
    before do
      visit root_path
    end
    it { expect(page).to have_content('Hello World') }
  end
end
