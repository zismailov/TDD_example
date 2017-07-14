class NotePage
  include Capybara::DSL

  def visit_page(note)
    visit("/notes/#{note.id}")
    self
  end

  def encourage
    click_on("encourage-button")
    self
  end
end
