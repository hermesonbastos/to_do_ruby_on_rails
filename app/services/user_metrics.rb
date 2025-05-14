class UserMetrics
  def initialize(user)
    @user = user
  end

  def daily_streak
    @daily_streak ||= begin
      start_of_week = Time.current.beginning_of_week(:sunday)
      end_of_week   = Time.current.end_of_week(:sunday)

      Task
        .joins(column: :board)
        .where(boards: { user_id: @user.id })
        .where(concluded_at: start_of_week..end_of_week)
        .pluck(:concluded_at)
        .map { |ts| ts.to_date.wday }
        .uniq
    end
  end

  def current_week_days_with_tasks
    daily_streak.size
  end

  def completed_tasks_count
    Task
      .joins(column: :board)
      .where(boards: { user_id: @user.id })
      .where.not(concluded_at: nil)
      .count
  end

  def completed_tasks_per_board
    Board
      .includes(:columns)
      .where(user_id: @user.id)
      .map do |board|
        last_column = board.columns.order(:id).last
        completed_tasks_count = last_column.tasks.where.not(concluded_at: nil).count
        { name: board.name, count: completed_tasks_count }
      end
      .sort_by { |b| -b[:count] }
      .first(5)
  end

  def task_distribution_per_board
    Board
      .includes(columns: :tasks)
      .where(user_id: @user.id)
      .map do |board|
        total_tasks = board.columns.flat_map(&:tasks).count
        { name: board.name, count: total_tasks }
      end
      .select { |board| board[:count].positive? }
  end

  def completed_tasks_per_weekday
    sql_expr = Arel.sql("EXTRACT(DOW FROM concluded_at)")

    weekday_labels = {
      0 => "Domingo",
      1 => "Segunda",
      2 => "Terça",
      3 => "Quarta",
      4 => "Quinta",
      5 => "Sexta",
      6 => "Sábado"
    }

    Task
      .joins(column: :board)
      .where(boards: { user_id: @user.id })
      .where.not(concluded_at: nil)
      .reorder(nil)
      .group(sql_expr)
      .count
      .sort_by { |_, count| -count }
      .map do |weekday_number, count|
        {
          name: weekday_labels[weekday_number.to_i],
          count: count
        }
      end
  end
end
