class String
  def slugged(sep = '-')
    slugged = String.new(self)
    # Turn unwanted chars into the separator
    # Now supporting Unicode words
    slugged.gsub!(/[^\p{Word}]+|_/, sep)
  
    unless sep.nil? || sep.empty?
      re_sep = Regexp.escape(sep)
      # No more than one of the separator in a row.
      slugged.gsub!(/#{re_sep}{2,}/, sep)
      # Remove leading/trailing separator.
      slugged.gsub!(/^#{re_sep}|#{re_sep}$/, '')
    end
  
    slugged.downcase
  end
  
  def capital_first!
    self[0] = self.first.upcase
  end
end