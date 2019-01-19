(1..30).each do |number|
  Task.create(content: 'test_' + number.to_s, status: 'status_' + number.to_s)
end