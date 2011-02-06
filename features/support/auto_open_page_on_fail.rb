After do |scenario|
  if ENV.include?('SHOW_ME_THE_PAGE')
    save_and_open_page if scenario.status == :failed
  end
end