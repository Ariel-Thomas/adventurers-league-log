module FeatureHelpers
  def show_page
    save_page Rails.root.join( 'public', 'capybara.html' )
    %x(launchy http://localhost:3000/capybara.html)
  end

  def fill_in_editor_field(text)
    within ".CodeMirror" do
      # Click makes CodeMirror element active:
      current_scope.click

      # Find the hidden textarea:
      field = current_scope.find("textarea", visible: false)

      # Mimic user typing the text:
      field.send_keys text
    end
  end

  def have_editor_display(options)
    editor_display_locator = ".CodeMirror-code"
    have_css(editor_display_locator, options)
  end
end