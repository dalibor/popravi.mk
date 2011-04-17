class ProblemObserver < ActiveRecord::Observer
  # Generic transition callback *after* problem is created
  def after_create(problem)
    problem.problem_transitions.create(:user => problem.user,
            :from => nil, :to => problem.status)
  end

  # Generic transition callback *after* problem is updated
  def after_update(problem)
    if problem.status_changed?
      problem.problem_transitions.create(:user => problem.last_editor,
              :from => problem.status_was, :to => problem.status)
    end
  end
end
