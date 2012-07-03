class AddReceiveEmailsToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :receive_emails, :boolean, :default => false
  end
end
