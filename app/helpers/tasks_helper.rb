module TasksHelper
  def task_difficulty_class(difficulty)
    case difficulty
    when 1
      "bg-green-900"
    when 2
      "bg-yellow-900"
    when 3
      "bg-red-900"
    else
      "badge-neutral"
    end
  end
end
