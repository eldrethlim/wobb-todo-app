task complete_tasks: :environment do
  tasks = Task.where(complete: false)
  tasks.update_all(complete: true)
end
