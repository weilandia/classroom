# frozen_string_literal: true
class AssignmentSubmission < ApplicationRecord
  belongs_to :submittable, polymorphic: true

  validates :sha, presence: true

  validates :github_release_id, presence: true
  validates :github_release_id, uniqueness: { scope: :submittable_id }
end
