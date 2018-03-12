class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    initialize_instance_variables(record)
    validate_params
    raise_unmatched_error(:title, @record) unless @stack.empty?
  end

  private

  def initialize_instance_variables(record)
    @record = record
    @title = record.title
    @stack = []
    initialize_brackets
  end

  def initialize_brackets
    @brackets = { '(' => ')', '[' => ']', '{' => '}', '<' => '>' }
    @opening = @brackets.keys
    @closing = @brackets.values
  end

  def validate_params
    @title.each_char.with_index do |char, index|
      if @opening.include?(char)
        next_char = @title[index + 1]
        raise_unmatched_error(:title, @record) if @closing.include? next_char
        @stack.push << char
      elsif @closing.include?(char)
        raise_unmatched_error(:title, @record) if @stack.empty? || (@brackets[@stack.pop] != char)
      end
    end
  end

  def raise_unmatched_error(field, record)
    record.errors[field] << 'unmatched bracket detected'
  end
end
