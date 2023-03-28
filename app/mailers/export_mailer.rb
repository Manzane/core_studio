class ExportMailer < ApplicationMailer
    default :from => 'mathilde@core-studio.fr'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_export_email(filepath, filename)
    #return filepath
    @url = "https://core-studio.herokuapp.com"
    attachments["#{filename}.csv"] = {mime_type: 'text/csv', content: File.read(filepath)}
    mail( :to => "mathilde@core-studio.fr",
    :subject => 'Envoi des data' )
  end
  
end
