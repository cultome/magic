class String
  def pascalcase
    split('_')
      .map { |word| word[0].upcase + word[1..].downcase }
      .join
  end
end

class Symbol
  def pascalcase
    to_s.pascalcase
  end
end
