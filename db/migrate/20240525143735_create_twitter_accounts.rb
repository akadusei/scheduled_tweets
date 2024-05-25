class CreateTwitterAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :twitter_accounts do |t|
      t.belongs_to :user, null: false, foreign_key: true, index: {unique: true}
      t.string :name
      t.string :username, null: false, index: {unique: true}
      t.string :image
      t.string :token
      t.string :secret

      t.timestamps
    end
  end
end
