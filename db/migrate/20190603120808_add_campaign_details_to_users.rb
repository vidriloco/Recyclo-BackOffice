class AddCampaignDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :campaign_code, :string
    add_column :users, :via_campaign, :boolean, default: false
  end
end
