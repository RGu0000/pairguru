class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    title = record.title
    #record.errors[:title] << 'test r' if title == 'r'
  end
end
