class AddTagToInstitutions < ActiveRecord::Migration[5.1]
  def change
    add_column :institutions, :tag, :string
  end
end
