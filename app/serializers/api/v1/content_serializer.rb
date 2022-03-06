class Api::V1::ContentSerializer < ActiveModel::Serializer
  attributes :id,:title,:file_type,:path,:description,:chapter_id,:upvoted,:downvoted,:upvotes,:downvotes,:notes
  # has_many :user_contents


  def upvotes
    @instance_options[:upvotes]
  end

  def downvotes
    @instance_options[:downvotes]
  end

  def upvoted
    @instance_options[:user_content][:upvoted]
  end

  def downvoted
    @instance_options[:user_content][:downvoted]
  end

  def notes
    @instance_options[:user_content][:notes]
  end

end
