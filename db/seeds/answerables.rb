polls = Poll.all
p_size = polls.size
vote_number = rand(p_size) + 1

users = User.all

votes = [1, -1]

users.each do |u|
  vote_number.times do
    p = polls[rand(p_size)]
    u.answerables.ballots.create(:askable_id => p.id, :country_code => p.country_code, :vote => votes[rand(2)])
  end
end