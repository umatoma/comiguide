class CreateApiTokens < ActiveRecord::Migration
  def change
    create_table :api_tokens do |t|
      t.references :user, null: false
      t.string :token, null: false

      t.timestamps
    end

    add_index :api_tokens, :user_id, unique: true
    add_index :api_tokens, :token, unique: true
  end
end
