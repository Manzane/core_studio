require 'csv'

class DataExportService
    def call

        current_date = DateTime.current.strftime("%d_%m_%Y")
        filename = "Export_#{current_date}"
        filepath = File.join(Rails.root, "tmp", "#{filename}.csv")
        
        #csv = []
        File.open(filepath, "wb") {|f| f.write("\xEF\xBB\xBF")}
        CSV.open(filepath, "ab", :col_sep => ";") do |csv|
            csv << %w(PRENOM NOM EMAIL NOMBRE_CREDIT CATEGORIE)
            users = User
                .left_joins(credits: :category)
                .distinct
            
            users = users.select(
                "users.*",
                "credits.quantity as cred_quantity",
                "categories.name as cat_name"
            )
            users.find_each do |user|
                row = [
                    user.first_name,
                    user.last_name,
                    user.email,
                    user.cred_quantity,
                    user.cat_name
                ]
                csv << row
            end
        end
        
        ExportMailer.send_export_email(filepath, filename).deliver  
    end
end