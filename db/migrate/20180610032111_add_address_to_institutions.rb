class AddAddressToInstitutions < ActiveRecord::Migration[5.1]
  def change
    add_column :institutions, :address, :string
  end
end
