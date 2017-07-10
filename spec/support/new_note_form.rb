class NewNoteForm
  include Capybara::DSL
  
  def visit_page
    visit('/')
    click_on('New Notes')
    self
  end

  def fill_in_with(params = {})
    fill_in('Title', with: params.fetch(:title, 'My first notes'))
    fill_in('Description', with: 'Excellent create my notes')
    select('Public', from: 'Privacy')
    check('Featured notes')
    attach_file('Cover image', "#{Rails.root}/spec/fixtures/cover_image.png")
    self
  end

  def submit
    click_on('Create Notes')
    self
  end
end
