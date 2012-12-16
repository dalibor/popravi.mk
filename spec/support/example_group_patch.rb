class RSpec::Core::ExampleGroup
  def passed?
    example.instance_variable_get(:@exception).nil?
  end

  def failed?
    !passed?
  end
end
