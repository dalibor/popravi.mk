Problem.where('user_id IS NULL').each do |problem|
  user = User.find_by_email(problem.email)
  if user
    puts "Assigning user: #{user.id} to problem: #{problem.id}: "
    problem.user = user
    problem.save(:validate => false)
  end
end
