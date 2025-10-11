class AddUserAgentToClicks < ActiveRecord::Migration[8.0]
  def change
    add_column :clicks, :user_agent, :string
  end
end
