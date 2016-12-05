# frozen_string_literal: true
# Documentation: https://developer.github.com/v3/activity/events/types/#releaseevent
class ReleaseEventJob < ApplicationJob
  queue_as :github_event

  # rubocop:disable GuardClause
  def perform(payload_body)
    if (@assignment_repo = find_repo_by_github_id(payload_body['repository']['id']))
      @assignment_repo.submissions.create!(new_submission_params(event_payload: payload_body))
    end
  end
  # rubocop:enable GuardClause

  private

  def find_repo_by_github_id(github_id)
    AssignmentRepo.find_by(github_repo_id: github_id) || GroupAssignmentRepo.find_by(github_repo_id: github_id)
  end

  def new_submission_params(event_payload:)
    {
      sha: @assignment_repo.github_repository.commit_sha("tags/#{event_payload['release']['tag_name']}"),
      github_release_id: event_payload['release']['id'],
      created_at: event_payload['release']['created_at']
    }
  end
end
