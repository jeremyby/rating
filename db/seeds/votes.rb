polls = Poll.approved
p_size = polls.size
vote_number = rand(p_size) + 1

users = User.all

votes = [1, -1]

users.each do |u|
  vote_number.times do
    p = polls[rand(p_size)]
    u.votings.create(:poll_id => p.id, :country_code => (p.country_code == "all" ? "cn" : p.country_code), :vote  => votes[rand(2)])
  end
end