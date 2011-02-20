class ProblemObserver < ActiveRecord::Observer
  # Generic transition callback *after* the transition is performed
  def after_create(problem)
    problem.problem_transitions.create(:from => nil, :to => problem.status)
  end

  # Generic transition callback *after* the transition is performed
  def after_transition(problem, transition)
    problem.problem_transitions.create(:from => transition.from, :to => transition.to)
  end
end
