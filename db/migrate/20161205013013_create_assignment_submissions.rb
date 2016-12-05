class CreateAssignmentSubmissions < ActiveRecord::Migration[5.0]
  def change
    create_table :assignment_submissions do |t|
      t.string  :sha, null: false
      t.integer :github_release_id, null: false

      t.references :submittable, polymorphic: true, index: { name: 'index_assignment_submissions' }

      t.timestamps null: false
    end
  end
end
