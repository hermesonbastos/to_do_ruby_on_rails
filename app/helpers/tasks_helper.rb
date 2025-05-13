module TasksHelper
  def task_difficulty_class(difficulty)
    case difficulty
    when 1
      "badge-success"
    when 2
      "badge-warning"
    when 3
      "badge-error"
    else
      "badge-neutral"
    end
  end
end
