class CreateThreeOtherTables < ActiveRecord::Migration[5.1]
  def change

    create_table :titles do |t|
      t.string :name
    end

    create_table :figures do |t|
      t.string :name
    end

    create_table :figure_titles do |t|
      t.belongs_to :figure
      t.belongs_to :title
    end

  end
end
