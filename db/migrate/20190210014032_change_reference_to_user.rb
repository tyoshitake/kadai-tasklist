class ChangeReferenceToUser < ActiveRecord::Migration[5.0]
  
  remove_reference :tasks, :users, foreign_key: true
  
  add_reference :tasks, :user, foreign_key: true
  
end
