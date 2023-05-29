class AddSocialLinksToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :youtube_url, :string
    add_column :users, :twitch_url, :string
  end
end
