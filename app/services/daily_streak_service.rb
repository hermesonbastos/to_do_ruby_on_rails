class DailyStreakService
  def initialize(user)
    @user = user
  end

  def current_week_streak
    start_of_week = Time.current.beginning_of_week(:sunday)
    end_of_week   = Time.current.end_of_week(:sunday)

    @current_week_streak ||= Task
      .joins(column: { board: :user })
      .where(
        columns: { is_done_column: true },
        boards:  { user_id:       @user.id }
      )
      .where(concluded_at: start_of_week..end_of_week)
      .pluck(:concluded_at)
      .map { |ts| ts.to_date.wday }
      .uniq
  end

  def total_streak
    current_week_streak.size
  end
end
