class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    title = record.title
    stack = []
    brackets = { '(' => ')', '[' => ']', '{' => '}', '<' => '>' }
    opening = brackets.keys
    closing = brackets.values
    
    title.each_char.with_index do |char, index|
      if opening.include?(char)
        next_char = title[index+1]
        record.errors[:title] << 'unmatched bracket detected' if closing.include? next_char
        stack.push << char
      elsif closing.include?(char)
        record.errors[:title] << 'unmatched bracket detected' if stack.empty? || (brackets[stack.pop] != char)
      end
    end
    record.errors[:title] << 'unmatched bracket detected' unless stack.empty?
  end
end
