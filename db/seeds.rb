# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

puts "Limpando dados antigos..."
Label.destroy_all
Task.destroy_all
Column.destroy_all
Board.destroy_all
User.destroy_all

puts "Criando usuário..."
user = User.create!(
  name: Faker::Name.name,
  email: Faker::Internet.unique.email,
  password: "123456"
)

puts "Criando boards..."
5.times do
  board = Board.create!(
    name: Faker::App.name,
    description: Faker::Lorem.sentence,
    user: user
    # banner removido
  )

  puts "Criando labels para o board #{board.name}..."
  labels = []
  rand(2..4).times do
    labels << Label.create!(
      title: Faker::Commerce.department(max: 1, fixed_amount: true),
      color: Faker::Color.hex_color,
      board: board
    )
  end

  puts "Criando colunas para o board #{board.name}..."
  rand(3..5).times.with_index do |_, col_index|
    column = Column.create!(
      name: Faker::Verb.base.capitalize,
      description: Faker::Lorem.sentence,
      position: col_index,
      board: board,
      is_done_column: (col_index == 2)
    )

    puts "Criando tarefas para a coluna #{column.name}..."
    rand(3..7).times.with_index do |_, task_index|
      task = Task.create!(
        title: Faker::Lorem.words(number: 3).join(" ").capitalize,
        description: Faker::Lorem.paragraph,
        difficulty: rand(1..3), # corrigido para evitar erro
        due_date: Faker::Date.forward(days: 30),
        column: column,
        position: task_index
      )

      task.labels << labels.sample(rand(0..2))
    end
  end
end

puts "Seeds gerados com sucesso!"
