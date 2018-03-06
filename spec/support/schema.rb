ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => File.expand_path('../../test.db', __FILE__)
)

MIGRATION_CLASS =
  if ActiveRecord::VERSION::MAJOR >= 5
    ActiveRecord::Migration[4.2]
  else
    ActiveRecord::Migration
  end

class CreateSchema < MIGRATION_CLASS
  def self.up
    create_table :users, :force => true do |t|
      t.string :first_name
      t.string :last_name
      t.timestamps null: false
    end

    create_table :vestal_versions, :force => true do |t|
      t.belongs_to :versioned, :polymorphic => true
      t.belongs_to :user, :polymorphic => true
      t.string :user_name
      t.text :modifications
      t.integer :number
      t.integer :reverted_from
      t.string :tag
      t.timestamps null: false
    end
  end
end
