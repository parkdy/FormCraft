class FormMailer < ActionMailer::Base
  default from: "admin@formcraft.org"

  def responses_email(form)
    @form = form
    @user = form.author

    # Attach csv file
    attachments['responses.csv'] = { data: form.responses_csv, mime_type: 'text/csv' }

    # Attach xls file
    html = File.read("#{Rails.root}/app/views/shared/_responses_table.xls.erb")
    result = ERB.new(html).result(binding) # binds 'form'
    attachments['responses.xls'] = { data: result, mime_type: 'text/xls' }

  	mail(to: @user.email, subject: "FormCraft: Responses to your form, '#{form.title}'")
  end
end
